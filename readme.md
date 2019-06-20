# smash-ranks-android-players #

A Ruby script that will take in CSV files containing Smash player data, and then spit out JSON files and avatar images in a very easy-to-read form.


## Android App ##

This repository is primarily used by the GAR PR Android app: [[GitHub link](https://github.com/charlesmadere/smash-ranks-android)] [[Google Play Store link](https://play.google.com/store/apps/details?id=com.garpr.android)].


## About the Project ##

The code portion of this project is written in [Ruby v2.5.3](https://www.ruby-lang.org/). Please make sure that you have a working Ruby installation to be able to run this code. Note that while it was developed against Ruby v2.5.3, it's very possible that it works with many other versions as well. For instance, on my MacBook Pro, I use Ruby v2.3.3, which has no problems.

If you have no local installation of Ruby, please go to the main Ruby website before proceeding.

This project relies on [MiniMagick](https://github.com/minimagick/minimagick), which requires that you have a working version of ImageMagick or GraphicsMagick installed.


## How to Run the Project ##

From a terminal or command line interface, run this command:

```
ruby generate_roster.rb
```

The script will then keep you informed as it progresses. And at the end, you'll see two new folders in the working directory: `avatars` and `json`, which have everything you will need.


## About the JSON ##

Only fields that are expressly marked as `(optional)` have the potential to not show up in the JSON data.

Note that the values in the `mains` array are always a 3 character string that directly corresponds to one of the values in the "Smash Character Values" section below. Your codebase should be made to deal with unknown values in this array, as that may mean that a new Smash Character has been added to the game that you're not yet familiar with. For example, Ridley (`rid`) and Inkling (`ink`) were recently announced for Smash Ultimate. Your code should be capable of gracefully handling them even if it hasn't been updated to explicitly support these.

Also note that the `avatar` object contains relative paths for its URLs. You need to manually build up the preceding portion of the URL within your code.


### Example JSON Schema ###

```
{
	"playerId1": {
		"avatar": { (optional)
			"large": "url", (optional)
			"medium": "url", (optional)
			"original": "url", (optional)
			"small": "url" (optional)
		},
		"id": "playerId1",
		"mains": [ (optional)
			"shk"
		],
		"name": "Charles Madere",
		"tag": "Charlezard",
		"websites": { (optional)
			"other": "url", (optional)
			"twitch": "url", (optional)
			"twitter": "url", (optional)
			"youtube": "url" (optional)
		}
	},
	"playerId2": {
		"avatar": "url", (optional)
		"id": "playerId2",
		"mains": [ (optional)
			"shk", "fox", "doc"
		],
		"name": "Declan Doyle",
		"tag": "Imyt",
		"websites": { (optional)
			"other": "url", (optional)
			"twitch": "url", (optional)
			"twitter": "url", (optional)
			"youtube": "url" (optional)
		}
	},
	"playerId3": ...
}
```


### Real JSON Example ###

```
{
  "588999c5d2994e713ad63ca7": {
    "name": "Joseph Marquez",
    "tag": "Mang0",
    "mains": [
      "fox",
      "fco"
    ],
    "websites": {
      "twitch": "https://www.twitch.tv/mang0",
      "twitter": "https://twitter.com/C9Mang0",
      "youtube": "https://www.youtube.com/channel/UCJLpammGMzjc4A2RfBVMbOg"
    },
    "id": "588999c5d2994e713ad63ca7"
  },
  "588999c5d2994e713ad63cac": {
    "name": "Adam Lindgren",
    "tag": "Armada",
    "mains": [
      "pch",
      "fox",
      "ylk"
    ],
    "websites": {
      "twitch": "https://www.twitch.tv/armadaugs",
      "twitter": "https://twitter.com/ArmadaUGS",
      "youtube": "https://www.youtube.com/channel/UCfagwFCjnHBYRYIyBnmNAdA"
    },
    "id": "588999c5d2994e713ad63cac"
  },
  "588999c5d2994e713ad63968": {
    "name": "Jason Zimmerman",
    "tag": "Mew2King",
    "mains": [
      "mrt",
      "shk",
      "fox"
    ],
    "websites": {
      "twitch": "https://www.twitch.tv/mew2king",
      "twitter": "https://twitter.com/MVG_Mew2King",
      "youtube": "https://www.youtube.com/user/therealmew2king"
    },
    "id": "588999c5d2994e713ad63968"
  },
  "587a951dd2994e15c7dea9fe": {
    "name": "Charles Madere",
    "tag": "Charlezard",
    "mains": [
      "shk"
    ],
    "websites": {
      "twitch": "https://www.twitch.tv/chillinwithcharles",
      "twitter": "https://twitter.com/charlesmadere",
      "other": "https://github.com/charlesmadere"
    },
    "avatar": {
      "original": "avatars/gar_pr/587a951dd2994e15c7dea9fe/original.jpg",
      "small": "avatars/gar_pr/587a951dd2994e15c7dea9fe/small.jpg",
      "medium": "avatars/gar_pr/587a951dd2994e15c7dea9fe/medium.jpg",
      "large": "avatars/gar_pr/587a951dd2994e15c7dea9fe/large.jpg"
    },
    "id": "587a951dd2994e15c7dea9fe"
  }
}
```


## Smash Character Values ##

* Banjo & Kazooie: `bnk`
* Bayonetta: `byo`
* Bowser: `bow`
* Bowser Jr.: `bjr`
* Captain Falcon: `fcn`
* Captain Olimar: `olm`
* Charizard: `chr`
* Chrom: `chm`
* Cloud: `cld`
* Corrin: `crn`
* Dark Pit: `dpt`
* Dark Samus: `dks`
* Diddy Kong: `ddy`
* Doctor Mario: `doc`
* Donkey Kong: `dnk`
* Duck Hunt: `dck`
* Falco: `fco`
* Fox: `fox`
* Ganondorf: `gnn`
* Greninja: `grn`
* Hero: `hro`
* Ice Climbers: `ics`
* Ike: `ike`
* Incineroar: `inc`
* Inkling: `ink`
* Ivysaur: `ivy`
* Jigglypuff: `puf`
* Joker: `jok`
* Ken: `ken`
* King Dedede: `ddd`
* King K. Rool: `kkr`
* Kirby: `kby`
* Link: `lnk`
* Little Mac: `lmc`
* Lucario: `lcr`
* Lucas: `lcs`
* Lucina: `lcn`
* Luigi: `lgi`
* Mario: `mar`
* Marth: `mrt`
* Mega Man: `meg`
* Meta Knight: `mtk`
* Mewtwo: `mw2`
* Mii Brawler: `mib`
* Mii Gunner: `mig`
* Mii Swordfighter: `mis`
* Mr. Game & Watch: `gnw`
* Ness: `nes`
* Pac-Man: `pac`
* Palutena: `pal`
* Peach: `pch`
* Pichu: `pic`
* Pikachu: `pik`
* Piranha Plant: `pir`
* Pit: `pit`
* Pokémon Trainer: `pkt`
* Ricter: `ric`
* Ridley: `rid`
* R.O.B.: `rob`
* Robin: `rbn`
* Rosalina: `ros`
* Roy: `roy`
* Ryu: `ryu`
* Samus: `sam`
* Sheik: `shk`
* Shulk: `slk`
* Simon: `smn`
* Snake: `snk`
* Sonic: `snc`
* Squirtle: `sqt`
* Toon Link: `tlk`
* Villager: `vlg`
* Wario: `war`
* Wii Fit Trainer: `wft`
* Wolf: `wlf`
* Yoshi: `ysh`
* Young Link: `ylk`
* Zelda: `zld`
* Zero Suit Samus: `zss`


## Unlicense ##

    This is free and unencumbered software released into the public domain.

    Anyone is free to copy, modify, publish, use, compile, sell, or
    distribute this software, either in source code form or as a compiled
    binary, for any purpose, commercial or non-commercial, and by any
    means.

    In jurisdictions that recognize copyright laws, the author or authors
    of this software dedicate any and all copyright interest in the
    software to the public domain. We make this dedication for the benefit
    of the public at large and to the detriment of our heirs and
    successors. We intend this dedication to be an overt act of
    relinquishment in perpetuity of all present and future rights to this
    software under copyright law.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
    IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
    OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
    ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
    OTHER DEALINGS IN THE SOFTWARE.

    For more information, please refer to <http://unlicense.org/>
