-- theme identification file

themeInfo = {
	Name = "supercrazy-foxskulk (SM 5.3)",
	Version = "0.0.1", -- a.b.c, a for complete overhauls, b for major releases, c for minor additions/bugfix.
	Date = "20200302",
};

function getThemeName()
	return themeInfo["Name"]
end;

function getThemeVersion()
	return themeInfo["Version"]
end;

function getThemeDate()
	return themeInfo["Date"]
end;
