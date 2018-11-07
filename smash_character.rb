class SmashCharacter

    def initialize(englishForm, shortForm)
        if englishForm == nil || englishForm.empty? || shortForm == nil || shortForm.length != 3
            raise "Illegal SmashCharacter attributes! (#{englishForm}, #{shortForm})"
        end

        @englishForm = englishForm.downcase
        @shortForm = shortForm.downcase
    end

    def english_form
        return @englishForm
    end

    def short_form
        return @shortForm
    end

end

# The below values are taken from this repository's readme document.

BAYONETTA = SmashCharacter.new("Bayonetta", "byo")
BOWSER = SmashCharacter.new("Bowser", "bow")
BOWSER_JR = SmashCharacter.new("Bowser Jr.", "bjr")
CAPTAIN_FALCON = SmashCharacter.new("Captain Falcon", "fcn")
CAPTAIN_OLIMAR = SmashCharacter.new("Captain Olimar", "olm")
CHARIZARD = SmashCharacter.new("Charizard", "chr")
CHROM = SmashCharacter.new("Chrom", "chm")
CLOUD = SmashCharacter.new("Cloud", "cld")
CORRIN = SmashCharacter.new("Corrin", "crn")
DARK_PIT = SmashCharacter.new("Dark Pit", "dpt")
DARK_SAMUS = SmashCharacter.new("Dark Samus", "dks")
DIDDY_KONG = SmashCharacter.new("Diddy Kong", "ddy")
DOCTOR_MARIO = SmashCharacter.new("Doctor Mario", "doc")
DONKEY_KONG = SmashCharacter.new("Donkey Kong", "dnk")
DUCK_HUNT = SmashCharacter.new("Duck Hunt", "dck")
FALCO = SmashCharacter.new("Falco", "fco")
FOX = SmashCharacter.new("Fox", "fox")
GANONDORF = SmashCharacter.new("Ganondorf", "gnn")
GRENINJA = SmashCharacter.new("Greninja", "grn")
ICE_CLIMBERS = SmashCharacter.new("Ice Climbers", "ics")
INCINEROAR = SmashCharacter.new("Incineroar", "inc")
IKE = SmashCharacter.new("Ike", "ike")
INKLING = SmashCharacter.new("Inkling", "ink")
IVYSAUR = SmashCharacter.new("Ivysaur", "ivy")
JIGGLYPUFF = SmashCharacter.new("Jigglypuff", "puf")
KEN = SmashCharacter.new("Ken", "ken")
KING_DEDEDE = SmashCharacter.new("King Dedede", "ddd")
KING_K_ROOL = SmashCharacter.new("King K. Rool", "kkr")
KIRBY = SmashCharacter.new("Kirby", "kby")
LINK = SmashCharacter.new("Link", "lnk")
LITTLE_MAC = SmashCharacter.new("Little Mac", "lmc")
LUCARIO = SmashCharacter.new("Lucario", "lcr")
LUCAS = SmashCharacter.new("Lucas", "lcs")
LUCINA = SmashCharacter.new("Lucina", "lcn")
LUIGI = SmashCharacter.new("Luigi", "lgi")
MARIO = SmashCharacter.new("Mario", "mar")
MARTH = SmashCharacter.new("Marth", "mrt")
MEGAMAN = SmashCharacter.new("Mega Man", "meg")
META_KNIGHT = SmashCharacter.new("Meta Knight", "mtk")
MEWTWO = SmashCharacter.new("Mewtwo", "mw2")
MII_BRAWLER = SmashCharacter.new("Mii Brawler", "mib")
MII_GUNNER = SmashCharacter.new("Mii Gunner", "mig")
MII_SWORDFIGHTER = SmashCharacter.new("Mii Swordfighter", "mis")
MR_GAME_AND_WATCH = SmashCharacter.new("Mr. Game & Watch", "gnw")
NESS = SmashCharacter.new("Ness", "nes")
PAC_MAN = SmashCharacter.new("Pac-Man", "pac")
PALUTENA = SmashCharacter.new("Palutena", "pal")
PEACH = SmashCharacter.new("Peach", "pch")
PICHU = SmashCharacter.new("Pichu", "pic")
PIKACHU = SmashCharacter.new("Pikachu", "pik")
PIRANHA_PLANT = SmashCharacter.new("Piranha Plant", "pir")
PIT = SmashCharacter.new("Pit", "pit")
POKEMON_TRAINER = SmashCharacter.new("Pokémon Trainer", "pkt")
RICTER = SmashCharacter.new("Ricter", "ric")
RIDLEY = SmashCharacter.new("Ridley", "rid")
ROB = SmashCharacter.new("R.O.B.", "rob")
ROBIN = SmashCharacter.new("Robin", "rbn")
ROSALINA = SmashCharacter.new("Rosalina", "ros")
ROY = SmashCharacter.new("Roy", "roy")
RYU = SmashCharacter.new("Ryu", "ryu")
SAMUS = SmashCharacter.new("Samus", "sam")
SHEIK = SmashCharacter.new("Sheik", "shk")
SHULK = SmashCharacter.new("Shulk", "slk")
SIMON = SmashCharacter.new("Simon", "smn")
SNAKE = SmashCharacter.new("Snake", "snk")
SONIC = SmashCharacter.new("Sonic", "snc")
SQUIRTLE = SmashCharacter.new("Squirtle", "sqt")
TOON_LINK = SmashCharacter.new("Toon Link", "tlk")
VILLAGER = SmashCharacter.new("Villager", "vlg")
WARIO = SmashCharacter.new("Wario", "war")
WII_FIT_TRAINER = SmashCharacter.new("Wii Fit Trainer", "wft")
WOLF = SmashCharacter.new("Wolf", "wlf")
YOSHI = SmashCharacter.new("Yoshi", "ysh")
YOUNG_LINK = SmashCharacter.new("Young Link", "ylk")
ZELDA = SmashCharacter.new("Zelda", "zld")
ZERO_SUIT_SAMUS = SmashCharacter.new("Zero Suit Samus", "zss")

SMASH_CHARACTERS = [
    BAYONETTA,
    BOWSER,
    BOWSER_JR,
    CAPTAIN_FALCON,
    CAPTAIN_OLIMAR,
    CHARIZARD,
    CHROM,
    CLOUD,
    CORRIN,
    DARK_PIT,
    DARK_SAMUS,
    DIDDY_KONG,
    DOCTOR_MARIO,
    DONKEY_KONG,
    DUCK_HUNT,
    FALCO,
    FOX,
    GANONDORF,
    GRENINJA,
    ICE_CLIMBERS,
    INCINEROAR,
    IKE,
    INKLING,
    IVYSAUR,
    JIGGLYPUFF,
    KEN,
    KING_DEDEDE,
    KING_K_ROOL,
    KIRBY,
    LINK,
    LITTLE_MAC,
    LUCARIO,
    LUCAS,
    LUCINA,
    LUIGI,
    MARIO,
    MARTH,
    MEGAMAN,
    META_KNIGHT,
    MEWTWO,
    MII_BRAWLER,
    MII_GUNNER,
    MII_SWORDFIGHTER,
    MR_GAME_AND_WATCH,
    NESS,
    PAC_MAN,
    PALUTENA,
    PEACH,
    PICHU,
    PIKACHU,
    PIRANHA_PLANT,
    PIT,
    POKEMON_TRAINER,
    RICTER,
    RIDLEY,
    ROB,
    ROBIN,
    ROSALINA,
    ROY,
    RYU,
    SAMUS,
    SHEIK,
    SHULK,
    SIMON,
    SNAKE,
    SONIC,
    SQUIRTLE,
    TOON_LINK,
    VILLAGER,
    WARIO,
    WII_FIT_TRAINER,
    WOLF,
    YOSHI,
    YOUNG_LINK,
    ZELDA,
    ZERO_SUIT_SAMUS
]

def get_smash_character(string)
    if string == nil || string.empty?
        return nil
    end

    SMASH_CHARACTERS.each do |smashCharacter|
        if string == smashCharacter.english_form
            return smashCharacter.short_form
        end
    end

    return nil
end
