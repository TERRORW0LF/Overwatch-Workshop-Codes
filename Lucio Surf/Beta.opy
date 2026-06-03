macro DEV = true
macro VERSION = "5.17b0"
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
rule "Start - Maps (Overrides)":
    if MapName == "HV" and Layout == 3:
        PosStart = vect(65.05, 10.82, -83.64)
        return
    
    if Layout == 0:
        if MapName == "AI":
            PosStart = vect(208.224, -8.98, -238.046)
            PosFinish = vect(347, -10.6, -226.5)
            return
        if MapName == "AL":
            PosStart = vect(341.7, 45.6, 168.63)
            PosFinish = vect(187.745, 44.5, 175.131)
            return
        if MapName == "AS":
            PosStart = vect(-107.528, 6, 60.23)
            PosFinish = vect(-88.466, 6.1, -69.033)
            return

    if Layout == 1:
        if MapName == "AI":
            PosStart = vect(349.8, -9.47, -232.23)
            PosFinish = vect(257.034, -20, -197.215)
            return
        if MapName == "AL":
            PosStart = vect(204.291, 43.99, 176.709)
            PosFinish = vect(355.296, 44.8, 174.37)
            return
        if MapName == "AS":
            PosStart = vect(-81.809, 6, -50.173)
            PosFinish = vect(-76.476, 6.247, 63.389)
            return

    if Layout == 2:
        if MapName == "AI":
            PosStart = vect(253.5, -12.92, -259.15)
            PosCheckpoint = [vect(283.976, -11.1, -200.454)]
            PosFinish = vect(345.558, -9, -250.369)
            return
        if MapName == "AL":
            PosStart = vect(325.163, 43.7, 157.958)
            PosCheckpoint = [vect(278.517, 42, 185.735)]
            PosFinish = vect(255.2, 40.4, 147.868)
            return
        if MapName == "AS":
            PosStart = vect(-67.3, 6, 42.188)
            PosCheckpoint = [vect(-109.45, 7.8, -11.43)]
            PosFinish = vect(-33, -5, 0)
            return

    if Layout == 3:
        if MapName == "AI":
            PosStart = vect(349.8, -9.47, -232.23)
            PosCheckpoint = [vect(284, -15.1, -198)]
            PosFinish = vect(214.406, -9.8, -244.933)
            return
        if MapName == "AL":
            PosStart = vect(202.923, 44.09, 160.495)
            PosCheckpoint = [vect(278.651, 42, 188.052)]
            PosFinish = vect(303.159, 42, 146.37)
            return
        if MapName == "AS":
            PosStart = vect(-117.55, 7.81, -2.422)
            PosCheckpoint = [vect(-77.486, 5.3, -21.861)]
            PosFinish = vect(-99.5, 8.8, 68.5)
            return

    if Layout == 4:
        if MapName == "AI":
            PosStart = vect(284, -11, -202.5)
            PosCheckpoint = [vect(240.373, -15, -199.518), vect(227.852, -8.4, -240.547), vect(284, -9.2, -259), vect(335.274, -11.1, -237.736)]
            PosFinish = vect(284.001, -12.9, -222.088)
            return
        if MapName == "AL":
            PosStart = vect(269.938, 43.96, 184.71)
            PosCheckpoint = [vect(228.712, 43.3, 187.033), vect(212.887, 43, 177.008), vect(356.132, 45, 168.618)]
            PosFinish = vect(270.025, 39.8, 153.709)
            PosBarrier = [vect(310.21, 46.876, 172.599)]
            return
        if MapName == "AS":
            PosStart = vect(-116.89, 7.81, 0)
            PosCheckpoint = [vect(-103.996, 7.5, -67.884), vect(-67.17, 4.8, -31.457), vect(-67.17, 4.8, 31.616), vect(-102.396, 8.1, 68.5)]
            PosFinish = vect(-75.5, 0, 0)
            PosBarrier = []
            return


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