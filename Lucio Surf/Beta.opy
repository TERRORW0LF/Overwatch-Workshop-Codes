macro DEV = true
macro VERSION = "5.15b0"
macro CODE = "048YZ"
macro MODE = " Beta"

settings "Shared/settings.opy.json"

# Variables
#!include "Shared/variables.opy"

# Debug
rule "Debug (Global)":
    @Delimiter


rule "Debug (Player)":
    hudHeader(localPlayer, f"{localPlayer.getPosition()}", HudPosition.TOP, 4, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudHeader(localPlayer, "{0}.{1} sec".format(floor(localPlayer.TimeExtra + 0.001 / 10), "{0}".format(round((1000 * localPlayer.TimeExtra) % 1000 + 1000)).substring(1, 3)), HudPosition.TOP, 5, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    

# Settings
#!include "Shared/settings.opy"

# Maps
#!include "Shared/map_init.opy"

# Setup
#!include "Shared/game_setup.opy"
rule "Start - Global (Extra)":
    createIcon(getAllPlayers(), PosFinish + vect(0, 6, 0), Icon.FLAG, IconReeval.VISIBILITY, Color.WHITE, true)
    for Loop1 in range(0, len(PosCheckpoint)):
        createIcon(getAllPlayers(), PosCheckpoint[Loop1] + vect(0, 6, 0), Icon.ARROW_DOWN, IconReeval.VISIBILITY_AND_COLOR, Color.SKY_BLUE if not localPlayer.Checkpoint[evalOnce(Loop1)] else Color.LIME_GREEN, false)


# Gamemode
#!include "Shared/general.opy"
rule "Teleport":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.MELEE)

    eventPlayer.teleport(eventPlayer.getPosition() + 5 * eventPlayer.getFacingDirection())


# Standard
#!include "Shared/modes/standard.opy"

# Practice
#!include "Shared/modes/practice.opy"

# Player Spectator
#!include "Shared/modes/player_spec.opy"

# Spectator
#!include "Shared/modes/spectator.opy"