t = Def.ActorFrame{}
t[#t+1] = LoadActor("scoretracking")
t[#t+1] = LoadActor("judgecount")
t[#t+1] = LoadActor("ghostscore")
t[#t+1] = LoadActor("progressbar")
t[#t+1] = LoadActor("avatar")
t[#t+1] = LoadActor("lifepercent")
t[#t+1] = LoadActor("BPMDisplay")
t[#t+1] = LoadActor("title")
t[#t+1] = LoadFont("Common Normal")..{
	InitCommand=cmd(xy,SCREEN_CENTER_X,SCREEN_BOTTOM-10;zoom,0.35;settext,GAMESTATE:GetSongOptions('ModsLevel_Song');shadowlength,1;);
}
return t