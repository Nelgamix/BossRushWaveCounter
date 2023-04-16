[![Steam Downloads](https://img.shields.io/steam/downloads/2492654252?color=blue&logo=Steam&style=flat-square)](https://steamcommunity.com/sharedfiles/filedetails/?id=2492654252)

# DOWNLOAD

To install the mod, go to the mod's official steam page [here](https://steamcommunity.com/sharedfiles/filedetails/?id=2492654252), and subscribe to it to have it automatically be installed to your game upon next launch. You can also clone this project directly into your mods folder.

# WHAT DOES IT DO?

This quality-of-life mod adds a wave counter similar to Greed Mode to the HUD for Boss Rush!

# MOD CONFIG MENU

This mod supports Mod Config Menu! Get it [here](https://steamcommunity.com/sharedfiles/filedetails/?id=2487535818)!

With Mod Config Menu, you will be able to customise the Boss Rush Wave Counter even further by:

- Changing the RGB values in the counters text

- Using custom presets to make moving the counter into juuuuuust the right spot even easier

- Enabling a custom "Boss Bar" preset to put the counter right in place of the Boss HP Bar, and move it out of the way during the fight

- Using custom UI Scaling to change the counter's size

# HOW DO I MOVE THE COUNTER?

1. First you need to be in Boss Rush. I find the easiest way to do this is to start up any challenge from the main menu since achievements are locked during challanges so you won't accidentally unlock anything. Next open the console with "~" and run the following commands "stage 5" to put you on Depths/Necropolis 1, "giveitem k5" to give yourself and emperor card, and "debug 10" so you don't have to spend time fighting any bosses. Exit the console, use the emperor card, and go to the next floor. Once on Depths/Necropolis 2, give yourself another emperor card and use it. Now you can enter the Boss Rush room.

2. When you're in the Boss Rush room, to adjust the position of the counter, hold "/" on your keyboard to enter Edit Mode. You'll know you're in Edit Mode when there's big red text in the middle of your screen that says "Edit Mode".

3. When you're in Edit Mode, use the arrow keys on your keyboard to move the counter, and let go of "/" once you are happy.

4. Now the position of the counter will be saved and you can exit back to the main menu. The position of the counter can always be changed again like this as long as you are in the Boss Rush room.

5. If you ever want to reset the counter to its default position, make sure you are in the Boss Rush room, and press "."

# DEVELOPMENT USEFUL TIPS

## PARTICULAR CASES TO CHECK

Larry Jr, Fistula, Blastocyst and some others are bosses that can break the counting method of the wave counter.
Be sure to check with these bosses when testing any change in the logic of updating the wave counter.

The activable item Meat Cleaver splits any enemy in the room, including bosses.
It can also break the wave counter and needs to be checked.

## DEBUG CONSOLE COMMANDS

```sh
# Reload mod (only main.lua)
luamod BossRushWaveCounter

# Effects
## Infinite HP
debug 3
## High damage (+40)
debug 4
## Fast auto kill enemy entities
debug 10

# Go to Depth I
stage 5

# Cards
## The Fool (to test the logic of exiting boss rush while fighting)
giveitem k1
## The Emperor (to TP to the boss, and to speed up level navigation)
giveitem k5

# Room items
## Chest (to trigger challenge room)
spawn 5.50
## Mega Battery
spawn 5.90.3
## Rainbow Poop (full health)
gridspawn 1494

# Items
## Mr ME! (to force open boss challenge rooms)
giveitem c527
## Meat Cleaver
giveitem c631

# Bosses
## Larry Jr
spawn 19.0
## Fistula
spawn 71.0.0
## Blastocyst
spawn 74.0
```

# IMPORTANT

THIS MOD WORKS WITH REPENTANCE however it has only been coded and tested to work with Afterbirth+. I currently do not own a copy of Repentance to test this mod on, however it is currently compatible unless anything in the code changes. With that being said, if anything doesn't work with Repentance, I will try my hardest to fix it, but until I have a pc and a copy of the game, nothing is certain.