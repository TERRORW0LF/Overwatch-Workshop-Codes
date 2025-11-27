macro DEV = true
macro VERSION = "5.14b1"
macro CODE = "048YZ"
macro MODE = " Beta"

settings "../Shared/settings.opy.json"

# Variables
#!include "../Shared/variables.opy"


# Debug
rule "Debug (Global)":
    @Delimiter


rule "Debug (Player)":
    hudHeader(localPlayer, f"{localPlayer.getPosition()}", HudPosition.TOP, 4, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudHeader(localPlayer, "{0}.{1} sec".format(floor(localPlayer.TimeExtra + 0.001 / 10), "{0}".format(round((1000 * localPlayer.TimeExtra) % 1000 + 1000)).substring(1, 3)), HudPosition.TOP, 5, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    

# Settings
#!include "../Shared/settings.opy"

# Maps
#!include "../Shared/map_init.opy"
rule "Start - Map Overrides":
    @Delimiter
    
    if MapName == "DR" and Layout == 3:
        PosCheckpoint = [vect(117.076, 16.9, 5.438)]
        return

    if MapName == "NJ" and Layout == 1:
        PosStart = vect(-5.03, 4, -77.46)
        return

    if MapName == "NJ" and Layout == 3:
        PosStart = vect(63.86, -0.47, 98.6)
        PosCheckpoint = [vect(-71.13, 3.25, 53.03)]
        PosBarrier = [vect(-48.91, 10, 24.02)]

    # Start if fucked no matter what
    if MapName == "NJ" and Layout == 4:
        PosStart = vect(-27.75, 5.04, 0)
        PosCheckpoint = [vect(-67.574, -1.1, -39.99), vect(20.901, 3.8, -75.494), vect(66.197, -3, -42.641), vect(49.998, 2.7, 43.036), vect(-0.505, 5.8, 92.147), vect(-91.813, -0.2, 40.051)]
        PosFinish = vect(-31, 0, 0)
        Checkpoint = true
        return
    
    if MapName == "SA" and Layout == 0:
        PosStart = vect(5.57, 3.95, 87.59)
        return

    if MapName == "SA" and Layout == 4:
        PosStart = vect(-5.509, 4.13, 0)
        PosCheckpoint = [vect(-93.032, -3.2, 41.929), vect(0.731, 2.8, 84.548), vect(59.309, 4.8, 45.652), vect(73.2, 2.5, -41.999), vect(-12.948, 0.8, -87.767), vect(-92.491, 4.8, -56.881)]
        PosFinish = vect(17, 3.8, 0)
        Checkpoint = true
        return

    if MapName == "AA":
        if Layout == 0:
            PosStart = vect(25.61, 13.19, -79.56)
            PosFinish = vect(41.77, 10.8, 96.7)
            return
        if Layout == 1:
            PosStart = vect(47.89, 11.02, 86.04)
            PosFinish = vect(25.72, 13.04, -92.99)
            return
        if Layout == 2:
            PosStart = vect(8.346, 14, 44.745)
            PosCheckpoint = [vect(-86.743, 9.5, 39.957)]
            PosFinish = vect(2.1, 7.8, 0)
            return
        if Layout == 3:
            PosStart = vect(-89.226, 10.25, 57.74)
            PosCheckpoint = [vect(78.596, 10.4, -2.73)]
            PosFinish = vect(28.836, 13, -91.974)
            Checkpoint = true
            return
        if Layout == 4:
            PosStart = vect(-1.425, 8.04, 0)
            PosCheckpoint = [vect(-77.869, 9, -28.175), vect(-84.305, 11.8, -71.17), vect(53.731, 10.8, -89.036), vect(85.613, 13.8, -52.378), vect(95.749, 7, 40.007), vect(22.516, 13.8, 68.788), vect(-70.785, 11, 79.292), vect(-87.784, 9.4, 39.892)]
            PosFinish = vect(-12.737, 8.8, -0.014)
            return


# Setup
#!include "../Shared/game_setup.opy"
rule "Start - Global (Extra)":
    createIcon(getAllPlayers(), PosFinish + vect(0, 6, 0), Icon.FLAG, IconReeval.VISIBILITY, Color.WHITE, true)
    for Loop1 in range(0, len(PosCheckpoint)):
        createIcon([player for player in getAllPlayers() if not player.Checkpoint[evalOnce(Loop1)]], PosCheckpoint[Loop1] + vect(0, 6, 0), Icon.ARROW_DOWN, IconReeval.VISIBILITY, Color.SKY_BLUE, false)
        createIcon([player for player in getAllPlayers() if player.Checkpoint[evalOnce(Loop1)]], PosCheckpoint[Loop1] + vect(0, 6, 0), Icon.CHECKMARK, IconReeval.VISIBILITY, Color.LIME_GREEN, false)


# Gamemode
#!include "../Shared/general.opy"
rule "Teleport":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.MELEE)

    eventPlayer.teleport(eventPlayer.getPosition() + 5 * eventPlayer.getFacingDirection())


# Standard
#!include "../Shared/modes/standard.opy"

# Practice
#!include "../Shared/modes/practice.opy"

# Player Spectator
#!include "../Shared/modes/player_spec.opy"

# Spectator
#!include "../Shared/modes/spectator.opy"