--Random quotes,phrases and memes from various rhythm gaming communities /o/ 
--(that you may or may not be familar with.... heck i don't even know the references for some of these)
--mainly from ossu, stepman and bms

-- Also (hopefully helpful) tips regarding the game/theme,etc.
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
local Tips = {
    --SM Tips
    "Pressing Scroll Lock immediately allows you to go to options",
    "You can mute action sounds by pressing <Pause/Break>",
    "Holding F3 brings up the debug menu",
    "Hold down Tab to make things go fast, ~ for making things slow, and both to make things stop.",
    "Press Ctrl+Backspace on ScreenSelectMusic delete the song from the music wheel. Make sure Allow Song Deletion is On from Advanced Options",
    "Press Ctrl+Shift+R on ScreenSelectMusic to reload the selected song",
    "Pressing PrintScr/SysRq takes a screenshot of the game, pressing Shift+PrintScr/SysRq will do so in a .png format and in original size.",
    "You can make profiles by going into Options > Profiles > Create Profile",
    "You can map keys/inputs by going into Options > Config Key/Joy Mappings",
    "(Windows only) typing %appdata% into your explorer bar opens the AppData folder. You can find your stepmania settings folder from there.",
    "StepMania by default will only save the top 3 scores on your profile. This can be changed in Arcade Options",
    "Pressing F8 Enables the autoplay. Alt+F8 will do so without displaying the autoplay text.",

    --Theme Specific
    "Please don't bug the original devs regarding bugs on this theme. This is an unofficial fork!",
    "You can change the default scoring type in Theme Options",
    "You can change the color scheme of the theme in the Color Config menu.",
    "The quick avatar switcher is gone (:crab:) because we use the SM 5.3 profile avatar module instead.",
    "Press keys 1~5 on the keyboard to select the corresponding tabs on ScreenSelectMusic",
    "While the Score tab is selected, press <effectUp>/<effectDown> to scroll through scores.",
    "While the Score tab is selected, press <effectUp>/<effectDown> while <Select> is held down to scroll through rates.",
    "You can set preferences for various theme functions in Options > Theme Options",
    "The theme is only supported for SM 5.3 or newer.",
    "This theme updates rather often, so make sure to check the thread/github page once every while for bugfixes and updates.",
    "Check the Other tab for general information regarding StepMania and the theme",
    "Rave and Course modes are disabled in this theme because it's terribly broken right now.",
    "You can change the speedmods ingame by pressing <EffectUp> or <EffectDown> during gameplay.",
    "You can adjust the lanecover height by holding <Select> and then pressing <EffectUp> or <EffectDown>",
    "Don't use cmd in your Lua scripts, it's deprecated and makes OutFox's Lua parser slower.",
    --Other SM related Tips
    "Search Tiny-Foxes on GitHub for more StepMania 5.3-related things.",
    "Poke Jousway in the Discord for anything noteskin related."
}



local Phrases = {
    "I really love SHAME, like a lot, like a whole lot, you have no idea...",
    "Single-frame Don-chan",
    "me and the boys at 2 a.m. looking for BEATS",
    "Dance Rush is amazing to play on",
    "Raymond in boxes (made you look)",
    "You're only human after all, so don't put your blame on yourself."
}

--tip

function getRandomQuotes(tipType)
    if tipType == 2 then
        return "TIP: "..Tips[math.random(#Tips)]
    elseif tipType == 3 then
        return Phrases[math.random(#Phrases)]
    else
        return ""
    end
end
