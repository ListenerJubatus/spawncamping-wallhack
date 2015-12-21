# spawncamping-wallhack
A WIP Stepmania 5 theme aimed primarily for KB players. 

Requirements: StepMania 5.0.8 or later.

---
### Acknowledgements
* The StepMania 5 devs (notably freem and Kyzentun) for making this possible in the first place.
* people in #vsrg,#stepmania-devs and various other people for feedbacks..!
* ScreenFilter.lua was taken from the Default theme by Midiman.
* CDTitle Resizer, ScreenSelectMusic Backgrounds are adapted from Jousway's code.
* Kyzentun's prefs system is used for setting various profile/theme preferences.

---
### Usage Guide (WIP)
---
#### Global
* Theme Color  
The main theme color can be set by entering "Color Config" from the title menu.  
From there, you can then set the hexadecimal value to a color of your liking.   
(For reference in case you want to revert, the default color is #00AEEF)

* **Avatars**   
You can set an avatar to a profile that is then displayed throughout the theme.
  * Adding new avatars   
  Open up the main theme folder, and navigate to this directory:   
  ```<sc-wh Theme Folder>\Graphics\Player avatar```   
  In this folder you can place any images that you wish to use, they should be at least 50px or larger and have a 1:1 aspect ratio.    
  Also, **DO NOT DELETE _fallback.png**.   
  * Setting avatars ingame   
  Once the images have been added, start up stepmania and head over to ScreenSelectMusic.   
  From this screen, you can either click the avatar, or quickly press the ```<Select>``` key twice.
  A new screen should come up on top of the current one with all the currently available images.   
  Use ```<Left>``` or ```<Right>``` to navigate, and press ```<Start>``` to update with the new image.   
  (You may also press ```<Back>``` to cancel without any changes.)   


* **Score Types**   
  Currently, the theme supports the 3 most commonly used scoring methods within the keyboard community.
  They are as follows:  

  |ScoreType|W1|W2|W3|W4|W5|Miss|OK|NG|HitMine|   
  |---|---|---|---|---|---|---|---|---|---|   
  |PS/Percentage Scoring (oni EX) <sup>default</sup>|3|2|1|0|0|0|3|0|-2|   
  |DP/Dance Points (MAX2)|2|2|1|0|-4|-8|6|0|-8|   
  |MIGS|3|2|1|0|-4|-8|6|0|-8|   
  ScoreTypes can be set from ```Options → Theme Options → Default ScoreType```.   
  Scores are calculated dynamically separate from the game engine's scoring. So any preferences set regarding score weights will have no effect.   
  DP Score will always be used for Letter grade calculations regardless of the scoretype set.
  
* **Rate Filter**   
  This option is already enabled by default. When enabled, instead of displaying all scores (with different rate mods) in a single scoreboard, all the scores will be separated by the ratemods that have been used. 
  ![](http://i.imgur.com/wd3T8wc.png)

* **Clear Types**   
  The theme uses iidx-esque cleartypes because... huur durrr lr2 wannabe theme.
  They should be self-explanatory. (e.g. PFC = ya got all perfect or higher / AAA)

---
#### ScreenSelectMusic
* General Tab
* Simfile Tab (incomplete)
* Score Tab
* Profile Tab (unimplemented)
* Other Tab
* Help Menu

---
#### ScreenGameplay
* Judge Counter
* Pacemaker Graph
* Error Bar
* Ghost Score and Average Score
* Screen Filter
* CB Lane Highlights
* Current/Peak NPS Display
* Mid-game Speedmod Change
* Sudden+/Hidden+ Lane Cover

---
#### ScreenEvaluation
* The Eval Screen Itself 
* Scoreboard 
* Judgment Cells 
* Result Background
  * Adding Custom result backgrounds

---
#### Misc.
* Tips and Quotes
