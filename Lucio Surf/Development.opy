macro DEV = true
macro VERSION = "5.14d3"
macro CODE = "6XN1G"
macro MODE = " Development"

settings "Shared/settings.opy.json"

# Variables
#!include "Shared/variables.opy"

globalvar SelectedEditable 51
globalvar YOffset 52
globalvar PosEditable 53
globalvar EntEditable 54
globalvar CpStr 55

# Debug
rule "Debug (Global)":
    @Disabled


rule "Debug (Player)":
    hudHeader(localPlayer, f"{localPlayer.getPosition()}", HudPosition.TOP, 4, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudHeader(localPlayer, "{0}.{1} sec".format(floor(localPlayer.TimeExtra + 0.001 / 10), "{0}".format(round((1000 * localPlayer.TimeExtra) % 1000 + 1000)).substring(1, 3)), HudPosition.TOP, 5, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    

rule "Debug (Player - Host)":
    @Event eachPlayer
    @Condition eventPlayer == hostPlayer

    hudHeader(eventPlayer, f"Edit: {SelectedEditable} | Y-Offset: {YOffset}", HudPosition.TOP, 5, Color.WHITE, HudReeval.STRING)


# Settings
#!include "Shared/settings.opy"

# Maps
#!include "Shared/map_init.opy"

# Setup
#!include "Shared/game_setup.opy"

rule "Start - Global (Extra)":
    # Start / Checkpoint / Finish / Barrier effects
    createEffect(getAllPlayers(), Effect.SPHERE, Color.WHITE, PosStart, 0.2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createInWorldText(getAllPlayers(), "0", PosStart + vect(0, 6, 0), 5, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
    createBeam(getAllPlayers(), Beam.GRAPPLE, PosFinish + Vector.DOWN * 10, PosFinish + Vector.UP * 10, Color.WHITE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createInWorldText(getAllPlayers(), f"{len(PosCheckpoint) + 2}", PosFinish + vect(0, 6, 0), 5, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
    for Loop1 in range(0, len(PosCheckpoint), 1):
        createBeam(getAllPlayers(), Beam.GRAPPLE, PosCheckpoint[evalOnce(Loop1)] + Vector.DOWN * 10, PosCheckpoint[evalOnce(Loop1)] + Vector.UP * 10, Color.WHITE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        createInWorldText(getAllPlayers(), f"{Loop1 + 1}", PosCheckpoint[evalOnce(Loop1)] + vect(0, 6, 0), 5, Clip.NONE, WorldTextReeval.VISIBILITY_AND_POSITION, Color.WHITE, SpecVisibility.DEFAULT)
    # Extra help text
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and player.Mode == 1 and not Edit and player == hostPlayer], "Edit Mode - Crouch + Ability 1", HudPosition.LEFT, 6, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and player.Mode == 3 and not Edit and player == hostPlayer], "Edit Mode - Crouch + Ability 1", HudPosition.LEFT, 6, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    # Help text Edit
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and Edit and player == hostPlayer], "Play Mode - Crouch + Ability 1", HudPosition.LEFT, 11, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and Edit and player == hostPlayer], "Increase Y-Offset - Ultimate", HudPosition.LEFT, 12, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and Edit and player == hostPlayer], "Decrease Y-Offset - Crouch + Ultimate", HudPosition.LEFT, 13, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and Edit and player == hostPlayer], "Next Editable - Ability 2", HudPosition.LEFT, 14, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and Edit and player == hostPlayer], "Previous Editable - Crouch + Ability 2", HudPosition.LEFT, 15, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and Edit and player == hostPlayer], "Place Editable - Crouch + Melee", HudPosition.LEFT, 16, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)


# Gamemode
#!include "Shared/general.opy"

rule "Teleport":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.MELEE) and not eventPlayer.isHoldingButton(Button.CROUCH)
    @Condition not eventPlayer.ExecutingMenu

    eventPlayer.ExecutingMenu = true
    eventPlayer.teleport(eventPlayer.getPosition() + 5 * eventPlayer.getFacingDirection())
    waitUntil(not eventPlayer.isHoldingButton(Button.MELEE), 9999)
    eventPlayer.ExecutingMenu = false


# Standard
#!include "Shared/modes/standard.opy"

# Edit
rule "Enable Edit Mode":
    @Event eachPlayer
    @Condition not Edit and (eventPlayer.Mode == 1 or eventPlayer.Mode == 3)
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_1) and eventPlayer.isHoldingButton(Button.CROUCH)
    @Condition eventPlayer == hostPlayer
    @Condition not eventPlayer.ExecutingMenu

    eventPlayer.ExecutingMenu = true
    Edit = true
    waitUntil(not eventPlayer.isHoldingButton(Button.ABILITY_1), 9999)
    eventPlayer.ExecutingMenu = false


rule "Disable Edit Mode":
    @Event eachPlayer
    @Condition Edit
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_1) and eventPlayer.isHoldingButton(Button.CROUCH)
    @Condition eventPlayer == hostPlayer
    @Condition not eventPlayer.ExecutingMenu

    eventPlayer.ExecutingMenu = true
    Edit = false
    waitUntil(not eventPlayer.isHoldingButton(Button.ABILITY_1), 9999)
    eventPlayer.ExecutingMenu = false


rule "Draw Editable Pos":
    @Event global
    @Condition Edit

    createEffect(hostPlayer, Effect.SPHERE, Color.RED, raycast(hostPlayer.getEyePosition(), hostPlayer.getEyePosition() + hostPlayer.getFacingDirection() * 100, null, null, false).getHitPosition(), 0.2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    EntEditable = getLastCreatedEntity()


rule "Stop Drawing Editable Pos":
    @Event global
    @Condition not Edit

    destroyEffect(EntEditable)


rule "Next Editable":
    @Event eachPlayer
    @Condition Edit
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2) and not eventPlayer.isHoldingButton(Button.CROUCH)
    @Condition eventPlayer == hostPlayer
    @Condition not eventPlayer.ExecutingMenu

    eventPlayer.ExecutingMenu = true
    SelectedEditable += 1
    if SelectedEditable > len(PosCheckpoint) + 2:
        SelectedEditable = len(PosCheckpoint) + 2
    waitUntil(not eventPlayer.isHoldingButton(Button.ABILITY_2), 9999)
    eventPlayer.ExecutingMenu = false


rule "Previous Editable":
    @Event eachPlayer
    @Condition Edit
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2) and eventPlayer.isHoldingButton(Button.CROUCH)
    @Condition eventPlayer == hostPlayer
    @Condition not eventPlayer.ExecutingMenu

    eventPlayer.ExecutingMenu = true
    SelectedEditable -= 1
    if SelectedEditable < 0:
        SelectedEditable = 0
    waitUntil(not eventPlayer.isHoldingButton(Button.ABILITY_2), 9999)
    eventPlayer.ExecutingMenu = false


rule "Place Editable":
    @Event eachPlayer
    @Condition Edit
    @Condition eventPlayer.isHoldingButton(Button.MELEE) and eventPlayer.isHoldingButton(Button.CROUCH)
    @Condition eventPlayer == hostPlayer
    @Condition not eventPlayer.ExecutingMenu

    eventPlayer.ExecutingMenu = true
    PosEditable = raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 100, null, null, false).getHitPosition()
    if SelectedEditable == 0:
        PosStart = PosEditable
    elif SelectedEditable == len(PosCheckpoint) + 1:
        PosCheckpoint.append(PosEditable + Vector.UP * YOffset)
        Loop1 = SelectedEditable - 1
        createBeam(getAllPlayers(), Beam.GRAPPLE, PosCheckpoint[evalOnce(Loop1)] + Vector.DOWN * 10, PosCheckpoint[evalOnce(Loop1)] + Vector.UP * 10, Color.WHITE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        createInWorldText(getAllPlayers(), f"{Loop1 + 1}", PosCheckpoint[evalOnce(Loop1)] + vect(0, 6, 0), 5, Clip.NONE, WorldTextReeval.VISIBILITY_AND_POSITION, Color.WHITE, SpecVisibility.DEFAULT)
        createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, Color.LIME_GREEN if localPlayer.Checkpoint[evalOnce(Loop1)] else Color.SKY_BLUE, PosCheckpoint[evalOnce(Loop1)], 3.5, EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)
        createEffect(getAllPlayers(), Effect.RING, Color.LIME_GREEN if localPlayer.Checkpoint[evalOnce(Loop1)] else Color.SKY_BLUE, PosCheckpoint[evalOnce(Loop1)], 3.5, EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)
        for Loop1 in range(0, len(getAllPlayers())):
            getAllPlayers()[Loop1].Checkpoint.append(false)
    elif SelectedEditable == len(PosCheckpoint) + 2:
        PosFinish = PosEditable + Vector.UP * YOffset
    else:
        PosCheckpoint[SelectedEditable - 1] = PosEditable + Vector.UP * YOffset
    printLog(f"Set Global Variable(PosStart, Vector({PosStart.x}, {PosStart.y}, {PosStart.z}));")
    if Checkpoint:
        CpStr = "Set Global Variable(PosCheckpoint, Array("
        for Loop1 in range(0, len(PosCheckpoint) - 1):
            CpStr = f"{CpStr}Vector({PosCheckpoint[Loop1].x}, {PosCheckpoint[Loop1].y}, {PosCheckpoint[Loop1].z}), "
        Loop1 = len(PosCheckpoint) - 1
        CpStr = f"{CpStr}Vector({PosCheckpoint[Loop1].x}, {PosCheckpoint[Loop1].y}, {PosCheckpoint[Loop1].z})));"
        printLog(CpStr)
    printLog(f"Set Global Variable(PosFinish, Vector({PosFinish.x}, {PosFinish.y}, {PosFinish.z}));")
    waitUntil(not eventPlayer.isHoldingButton(Button.MELEE), 9999)
    eventPlayer.ExecutingMenu = false


rule "Increase Y-Offset":
    @Event eachPlayer
    @Condition Edit
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE) and not eventPlayer.isHoldingButton(Button.CROUCH)
    @Condition eventPlayer == hostPlayer
    @Condition not eventPlayer.ExecutingMenu

    eventPlayer.ExecutingMenu = true
    YOffset += 0.1
    waitUntil(not eventPlayer.isHoldingButton(Button.MELEE), 9999)
    eventPlayer.ExecutingMenu = false


rule "Decrease Y-Offset":
    @Event eachPlayer
    @Condition Edit
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE) and eventPlayer.isHoldingButton(Button.CROUCH)
    @Condition eventPlayer == hostPlayer
    @Condition not eventPlayer.ExecutingMenu

    eventPlayer.ExecutingMenu = true
    YOffset -= 0.1
    waitUntil(not eventPlayer.isHoldingButton(Button.MELEE), 9999)
    eventPlayer.ExecutingMenu = false


# Practice
#!include "Shared/modes/practice.opy"

# Player Spectator
#!include "Shared/modes/player_spec.opy"

# Spectator
#!include "Shared/modes/spectator.opy"
