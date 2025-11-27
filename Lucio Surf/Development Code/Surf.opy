macro DEV = true
macro VERSION = "5.14d3"
macro CODE = "6XN1G"
macro MODE = " Development"

settings "../Shared/settings.opy.json"

# Variables
#!include "../Shared/variables.opy"
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
#!include "../Shared/general.opy"
rule "Teleport":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.MELEE) and not eventPlayer.isHoldingButton(Button.CROUCH)
    @Condition not eventPlayer.ExecutingMenu

    eventPlayer.ExecutingMenu = true
    eventPlayer.teleport(eventPlayer.getPosition() + 5 * eventPlayer.getFacingDirection())
    waitUntil(not eventPlayer.isHoldingButton(Button.MELEE), 9999)
    eventPlayer.ExecutingMenu = false


# Standard
#!include "../Shared/modes/standard.opy"

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
#!include "../Shared/modes/practice.opy"

# Player Spectator
#!include "../Shared/modes/player_spec.opy"

# Spectator
#!include "../Shared/modes/spectator.opy"
