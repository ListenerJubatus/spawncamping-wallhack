--Random helper functions that don't really belong anywhere else.


function get43size(size4_3)
	return 640*(size4_3/854)
end;

function capWideScale(AR4_3,AR16_9)
	if AR4_3 < AR16_9 then
		return clamp(WideScale(AR4_3, AR16_9),AR4_3,AR16_9)
	else
		return clamp(WideScale(AR4_3, AR16_9),AR16_9,AR4_3)
	end;
end;

--returns current autoplay type. returns a integer between 0~2 corresponding to
--human, autoplay and autoplay cpu respectively.
function getAutoplay()
	return Enum.Reverse(PlayerController)[tostring(PREFSMAN:GetPreference("AutoPlay"))]
end;

--returns true if windowed.
function isWindowed()
	return PREFSMAN:GetPreference("Windowed")
end;

--returns if the table contains the key.
function tableContains(table,key)
	return (table[key] ~= nil)
end;

--for non-array tables.
function getTableSize(table)
	local i = 0
	for k,v in pairs(table) do
		i = i+1
	end;
	return i
end;

-- returns the hexadecimal representaion of the MD5 hash.
function MD5FileHex(sPath)
	local text = {}
	local MD5 = CRYPTMAN:MD5File(sPath)
	for i=1,#MD5 do
		text[i] = string.format("%02X",string.byte(MD5,i) or 0)
	end
	if #text == 16 then
		return table.concat(text)
	else
		return 0 --invalid
	end
end

-- returns the hexadecimal representation of the SHA-1 hash.
function SHA1FileHex(sPath)
	local text = {}
	local SHA1 = CRYPTMAN:SHA1File(sPath)
	for i=1,#SHA1 do
		text[i] = string.format("%02X",string.byte(SHA1,i) or 0)
	end
	if #text == 20 then
		return table.concat(text)
	else
		return 0 --invalid
	end
end

-- returns the hexadecimal representaion of the MD5 hash.
function MD5StringHex(str)
	local text = {}
	local MD5 = CRYPTMAN:MD5String(str)
	for i=1,#MD5 do
		text[i] = string.format("%02X",string.byte(MD5,i) or 0)
	end
	if #text == 16 then
		return table.concat(text)
	else
		return 0 --invalid
	end
end

-- returns the hexadecimal representation of the SHA-1 hash.
function SHA1StringHex(str)
	local text = {}
	local SHA1 = CRYPTMAN:SHA1String(str)
	for i=1,#SHA1 do
		text[i] = string.format("%02X",string.byte(SHA1,i) or 0)
	end
	if #text == 20 then
		return table.concat(text)
	else
		return 0 --invalid
	end
end

--Given a table of file paths/names in a fileList
--filters out files from fileList that isn't in the type in fileTypes
--both function parameters are passed on as tables
function filterFileList(fileList,fileTypes)
	local t = {}
	for i=1,#fileList do
		local add = false
		local s
		for _,v in pairs(fileTypes) do
			s = fileList[i]
			s = s:sub(-v:len())
			if s == v then
				add = true
			end
		end
		if add then
			table.insert(t,fileList[i])
		end	
	end
	return t
end

-- Just something to get rid of scores where the player quit out early.
function isScoreValid(pn,steps,score)
	if pn == nil or steps == nil or score == nil then
		return false
	end

	if GAMESTATE:IsCourseMode() then
		return true -- Don't care about course mode atm.
	end

	if score:GetGrade() == "Grade_Failed" then
		return true
	end
	if not (steps:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds') == 
		(score:GetTapNoteScore('TapNoteScore_W1')+
		score:GetTapNoteScore('TapNoteScore_W2')+
		score:GetTapNoteScore('TapNoteScore_W3')+
		score:GetTapNoteScore('TapNoteScore_W4')+
		score:GetTapNoteScore('TapNoteScore_W5')+
		score:GetTapNoteScore('TapNoteScore_Miss'))) then
		return false
	end
	if ((score:GetTapNoteScore('TapNoteScore_Miss') == 0) and 
		((steps:GetRadarValues(pn):GetValue('RadarCategory_Holds')+(steps:GetRadarValues(pn):GetValue('RadarCategory_Rolls')) ~= 
		(score:GetHoldNoteScore('HoldNoteScore_LetGo')+score:GetHoldNoteScore('HoldNoteScore_Held')+score:GetHoldNoteScore('HoldNoteScore_MissedHold'))
		))) then 
		-- miss == 0 as HNS_MissedHold was added rather recently and NG+OK will not add up correctly for older scores.
		--where the player missed a note with a hold.
		return false
	end
	return true
end


-- I probably should check for correctness later.
function getCommonBPM(bpms,lastBeat)
	local BPMtable = {}
	local curBPM = math.round(bpms[1][2])
	local curBeat = bpms[1][1]
	for _,v in ipairs(bpms) do
		if BPMtable[tostring(curBPM)] == nil then
			BPMtable[tostring(curBPM)] = (v[1] - curBeat)/curBPM
		else
			BPMtable[tostring(curBPM)] = BPMtable[tostring(curBPM)] + (v[1] - curBeat)/curBPM
		end
		curBPM = math.round(v[2])
		curBeat = v[1]
	end

	if BPMtable[tostring(curBPM)] == nil then
		BPMtable[tostring(curBPM)] = (lastBeat - curBeat)/curBPM
	else
		BPMtable[tostring(curBPM)] = BPMtable[tostring(curBPM)] + (lastBeat - curBeat)/curBPM
	end

	local maxBPM = 0
	local maxDur = 0
	for k,v in pairs(BPMtable) do
		if v > maxDur then
			maxDur = v
			maxBPM = tonumber(k)
		end
	end
	return maxBPM
end

function getBPMChangeCount(bpms)
	local count = 0
	local threshhold = 5 -- get rid of ddreamspeed changes
	local curBPM = bpms[1][2]
	for k,v in ipairs(bpms) do
		if math.abs(curBPM - v[2]) > threshhold then
			count = count + 1
		end
		curBPM = v[2]
	end

	return count
end

-- Values based on ArrowEffects.cpp
-- Gets the note scale from the mini mod being used.
function getNoteFieldScale(pn)
	local po = GAMESTATE:GetPlayerState(pn):GetPlayerOptions('ModsLevel_Preferred')
	local val,as = po:Mini()
	local zoom = 1
	zoom = 1-(val*0.5)
	if math.abs(zoom) < 0.01 then
		zoom = 0.01
	end
	return zoom
end

-- Gets the width of the note assuming the base width is 64.
function getNoteFieldWidth(pn)
	local baseWidth = 64 -- is there a way to grab a noteskin width..?
	local style = GAMESTATE:GetCurrentStyle()
	local cols = style:ColumnsPerPlayer()
	return cols*baseWidth*getNoteFieldScale(pn)
end

-- Gets the center X position of the notefield.
function getNoteFieldPos(pn)
	local pNum = (pn == PLAYER_1) and 1 or 2
	local style = GAMESTATE:GetCurrentStyle()
	local cols = style:ColumnsPerPlayer()
	local styleType = ToEnumShortString(style:GetStyleType())
	local centered = ((cols >= 6) or PREFSMAN:GetPreference("Center1Player"))

	if centered and GAMESTATE:GetNumPlayersEnabled() == 1 then 
		return SCREEN_CENTER_X
	else
		return THEME:GetMetric("ScreenGameplay",string.format("PlayerP%i%sX",pNum,styleType))
	end

end