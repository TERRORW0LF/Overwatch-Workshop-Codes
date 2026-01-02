macro DEV = false
macro VERSION = "5.14"
macro CODE = "KVKKR"
macro MODE = ""

# Colosseo - First
# Esperanca - First 
# Hanaoka - Second
# Samoa - First
# Throne of Anubis - Second

settings "Shared/settings.opy.json"

# Variables
#!include "Shared/variables.opy"

# Settings
#!include "Shared/settings.opy"

# Maps
#!include "Shared/map_init.opy"

# Setup
#!include "Shared/game_setup.opy"
rule "Start - Global (Extra)":
    createIcon(getAllPlayers(), PosFinish + vect(0, 6, 0), Icon.FLAG, IconReeval.VISIBILITY, Color.WHITE, true)
    for Loop1 in range(0, len(PosCheckpoint)):
        createIcon([player for player in getAllPlayers() if not player.Checkpoint[evalOnce(Loop1)]], PosCheckpoint[Loop1] + vect(0, 6, 0), Icon.ARROW_DOWN, IconReeval.VISIBILITY, Color.SKY_BLUE, false)
        createIcon([player for player in getAllPlayers() if player.Checkpoint[evalOnce(Loop1)]], PosCheckpoint[Loop1] + vect(0, 6, 0), Icon.CHECKMARK, IconReeval.VISIBILITY, Color.LIME_GREEN, false)


# Gamemode
#!include "Shared/general.opy"

# Standard
#!include "Shared/modes/standard.opy"

# Practice
#!include "Shared/modes/practice.opy"

# Player Spectator
#!include "Shared/modes/player_spec.opy"

# Spectator
#!include "Shared/modes/spectator.opy"