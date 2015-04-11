-- Dependencies: Scoretracking.lua

local ghostTypeP1 = tonumber(GetUserPref("GhostScoreTypeP1")); -- 1 = off, 2 = DP, 3 = PS, 4 = MIGS
local avgScoreTypeP1 = tonumber(GetUserPref("AvgScoreTypeP1"));-- 1 = off, 2 = DP, 3 = PS, 4 = MIGS
local targetP1 = (tonumber(GetUserPref("GhostTargetP1") or "0")+1)/100; -- target score from 0% to 100%.

local ghostTypeP2 = tonumber(GetUserPref("GhostScoreTypeP2")); -- 1 = off, 2 = DP, 3 = PS, 4 = MIGS
local avgScoreTypeP2 = tonumber(GetUserPref("AvgScoreTypeP2"));-- 1 = off, 2 = DP, 3 = PS, 4 = MIGS
local targetP2 = (tonumber(GetUserPref("GhostTargetP2") or "0")+1)/100; -- target score from 0% to 100%.


local cols = GAMESTATE:GetCurrentStyle():ColumnsPerPlayer(); -- For relocating graph/judgecount frame
local center1P = ((cols >= 6) or PREFSMAN:GetPreference("Center1Player")) and GAMESTATE:GetNumPlayersEnabled() == 1;

local t = Def.ActorFrame{}

function getPosX (pn,styleType)
	return THEME:GetMetric("ScreenGameplay",string.format("PlayerP%i%sX",pn,styleType))
end;

local style = ToEnumShortString(GAMESTATE:GetCurrentStyle():GetStyleType())
local frameXP1 = SCREEN_CENTER_X+50
local frameYP1 = SCREEN_CENTER_Y+10
local frameYRP1 = SCREEN_CENTER_Y+30

local frameXP2 = SCREEN_CENTER_X+50
local frameYP2 = SCREEN_CENTER_Y+10
local frameYRP2 = SCREEN_CENTER_Y+30

if center1P == false then
	frameXP1 = getPosX(1,style)+50
	frameXP2 = getPosX(2,style)+50
end

function ghostScore(pn)

	local frameX = SCREEN_CENTER_X
	local frameY = SCREEN_CENTER_Y
	local ghostType = 1
	local target = 0
	if pn == PLAYER_1 then
		frameX = frameXP1
		frameY = frameYP1
		ghostType = ghostTypeP1
		target = targetP1
		if GAMESTATE:GetPlayerState(pn):GetCurrentPlayerOptions():UsingReverse() then
			frameY = frameYRP1
		end
	elseif pn == PLAYER_2 then
		frameX = frameXP2
		frameY = frameYP2
		ghostType = ghostTypeP2
		target = targetP2
		if GAMESTATE:GetPlayerState(pn):GetCurrentPlayerOptions():UsingReverse() then
			frameY = frameYRP2
		end
	end;
	local t = Def.ActorFrame{
		JudgmentMessageCommand=function(self,params)
			if params.TapNoteScore ~= 'TapNoteScore_AvoidMine' and params.HoldNoteScore ~= 'HoldNoteScore_MissedHold' then
				self:stoptweening()
				self:diffusealpha(1)
				self:sleep(0.25)
				self:smooth(0.75)
				self:diffusealpha(0)
			end;
		end;
		LoadFont("Common Normal") .. {
			InitCommand=cmd(xy,frameX,frameY;shadowlength,1;zoom,0.45;diffuse,color("#ffffff00");halign,0);
			BeginCommand=function(self)
				self:settext('+0')
				if ghostType == 1 or ghostType == nil then
					self:visible(false)
				end;
			end;
			SetCommand=function(self,params)
				self:diffusealpha(1)
				local targetDiff = 0
				if ghostType == 2 then
					targetDiff = getCurScoreST(pn,1)-(math.ceil(getCurMaxScoreST(pn,1)*target))
				elseif ghostType == 3 then
					targetDiff = getCurScoreST(pn,2)-(math.ceil(getCurMaxScoreST(pn,2)*target))
				elseif ghostType == 4 then
					targetDiff = getCurScoreST(pn,3)-(math.ceil(getCurMaxScoreST(pn,3)*target))
				end;

				if targetDiff > 0 then
					self:settext('+'..targetDiff)
					self:diffuse(color("#66ccff"))
				elseif targetDiff == 0 then
					self:settext('+'..targetDiff)
					self:diffuse(color("#FFFFFF"))
				else
					self:settext('-'..(math.abs(targetDiff)))
					self:diffuse(color("#FF9999"))
				end;
			end;
			JudgmentMessageCommand=function(self,params)
				self:queuecommand("Set");
			end;
		};
	};
	return t
end;

function avgScore(pn)
	local frameX = 0
	local frameY = 0
	local avgScoreType = 1
	if pn == PLAYER_1 then
		frameX = frameXP1
		frameY = frameYP1
		avgScoreType = avgScoreTypeP1
		if GAMESTATE:GetPlayerState(pn):GetCurrentPlayerOptions():UsingReverse() == true then
			frameY = frameYRP1
		end
	elseif pn == PLAYER_2 then
		frameX = frameXP2
		frameY = frameYP2
		avgScoreType = avgScoreTypeP2
		if GAMESTATE:GetPlayerState(pn):GetCurrentPlayerOptions():UsingReverse() == true then
			frameY = frameYRP1
		end
	end
	local t = Def.ActorFrame{
		JudgmentMessageCommand=function(self,params)
			if params.TapNoteScore ~= 'TapNoteScore_AvoidMine' and params.HoldNoteScore ~= 'HoldNoteScore_MissedHold' then
				self:stoptweening()
				self:diffusealpha(1)
				self:sleep(0.25)
				self:smooth(0.75)
				self:diffusealpha(0)
			end;
		end;
		LoadFont("Common Normal") .. { -- Current/Average Percentage Score
			InitCommand=cmd(xy,frameX,frameY;shadowlength,1;zoom,0.45;diffuse,color("#ffffff00");halign,1);
			BeginCommand=function(self)
				self:settext('0.00%')
				if avgScoreType == 1 or avgScoreType == nil then
					self:visible(false)
				end;
			end;
			SetCommand=function(self,params)
				self:diffusealpha(1)
				if avgScoreType ~= 1 or avgScore ~= nil then
					if getCurMaxScoreST(pn,avgScoreType-1) ~= 0 then
						self:settextf("%.2f%%",(math.floor(getCurScoreST(pn,avgScoreType-1)/getCurMaxScoreST(pn,avgScoreType-1)*10000))/100); 
					else
						self:settext('0.00%')
					end;
				end;
			end;
			JudgmentMessageCommand=function(self)
				self:queuecommand("Set");
			end;
		};
	};
	return t
end;

--[[
t[#t+1] = LoadFont("Common Normal") .. {
 	InitCommand=cmd(xy,300,300;settext,cols);
}
t[#t+1] = LoadFont("Common Normal") .. {
 	InitCommand=cmd(xy,400,300;settext,tostring(center1P));
}
--]]
if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
	t[#t+1] = ghostScore(PLAYER_1)
	t[#t+1] = avgScore(PLAYER_1)
end;
if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
	t[#t+1] = ghostScore(PLAYER_2)
	t[#t+1] = avgScore(PLAYER_2)
end;

return t