return Def.Quad{
	InitCommand=function(self) self:FullScreen():diffuse(getMainColor("background")):diffusealpha(1) end;
	OnCommand=function(self) self:smooth(0.2):diffusealpha(0) end;
};