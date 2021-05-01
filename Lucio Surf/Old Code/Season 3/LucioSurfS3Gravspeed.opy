#Global variables

globalvar TimeFirst 0
globalvar TimeSecond 1
globalvar TimeThird 2
globalvar PlayerFirst 3
globalvar PlayerSecond 4
globalvar PlayerThird 5
globalvar Visible 6
globalvar PosExplanation 22
globalvar PosStart 23
globalvar PosCheckpoint 24
globalvar PosFinish 25


#Player variables

playervar TimeCurrent 0
playervar TimeBest 1
playervar NewBest 2
playervar Checkpoint 3
playervar Finished 4
playervar AutoReset 5
playervar HideHelp 6
playervar Mode 7
playervar Attempts 8
playervar Spawned 9
playervar PosPracticeCheckpoint 14
playervar FacingPracticeCheckpoint 15
playervar VelocityPracticeCheckpoint 16
playervar SpeedPracticeCheckpoint 17
playervar PosCamera 18
playervar FacingCamera 19


#Subroutines

subroutine StartPlayer 0


#Debug
rule "Debug (Global)":
    @Event global
    @Disabled
    hudHeader(getAllPlayers(), "PosObj: {}".format(vect(ceil(getObjectivePosition(getCurrentObjective()).x), ceil(getObjectivePosition(getCurrentObjective()).y), ceil(getObjectivePosition(getCurrentObjective()).z))), HudPosition.LEFT, -1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)


rule "Debug (Player)":
    @Event eachPlayer
    @Disabled
    hudHeader(eventPlayer, "Mode: {0}".format(eventPlayer.Mode), HudPosition.LEFT, 6, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)


#Subroutines
def StartPlayer():
    @Name "StartPlayer"
    hudHeader(eventPlayer, "{0} sec".format(eventPlayer.TimeCurrent), HudPosition.TOP, 2, Color.WHITE, HudReeval.STRING, SpecVisibility.DEFAULT)
    hudHeader(eventPlayer, "Best - {0} sec".format(eventPlayer.TimeBest), HudPosition.LEFT, 1, Color.WHITE, HudReeval.STRING, SpecVisibility.DEFAULT)
    hudHeader(eventPlayer, "ATTEMPTS: {0}".format(eventPlayer.Attempts), HudPosition.LEFT, 2, Color.WHITE, HudReeval.STRING, SpecVisibility.DEFAULT)
    createInWorldText(eventPlayer, "{0} m".format(distance(PosFinish, eventPlayer)), PosFinish + vect(0, 5, 0), 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
    createInWorldText(eventPlayer, "{0} m".format(distance(PosCheckpoint, eventPlayer)), PosCheckpoint + vect(0, 5, 0), 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.SKY_BLUE, SpecVisibility.DEFAULT)
    wait()
    hudHeader(eventPlayer, "{0} m/s".format(eventPlayer.getHorizontalSpeed()), HudPosition.TOP, 1, Color.RED, HudReeval.STRING, SpecVisibility.DEFAULT)
    eventPlayer.Mode = 0
    eventPlayer.Spawned = true
    eventPlayer.clearStatusEffect(Status.ROOTED)
    eventPlayer.setGravity(100)
    eventPlayer.setMoveSpeed(100)
    kill(eventPlayer, null)


#Maps
rule "Start - Assault - Every Map Is In Order (a - z)":
	@Event global
    if getCurrentMap() == Map.HANAMURA:
        PosStart = vect(55.024, -0.738, 41.766)
        PosFinish = vect(91.752, -0.827, 17.33)
        PosCheckpoint = vect(76.329, -5.31, 97.421)
        return
    if getCurrentMap() == Map.HORIZON_LUNAR_COLONY:
        PosStart = vect(20.101, 7.177, -107.386)
        PosFinish = vect(47.863, 13.176, -37.389)
        PosCheckpoint = vect(94.12, 12.724, -56.787)
        return
    if getCurrentMap() == Map.PARIS:
        PosCheckpoint = vect(-43.506, 12.23, -34.903)
        PosStart = vect(-77.279, 13.247, -2.75)
        PosFinish = vect(-119.113, 12.103, -69.934)
        return
    if getCurrentMap() == Map.TEMPLE_OF_ANUBIS:
        PosCheckpoint = vect(16.802, 4.031, 106.979)
        PosStart = vect(-59.379, 7.687, 44.914)
        PosFinish = vect(-36.8, 10.183, 2.543)
        return
    if getCurrentMap() == Map.VOLSKAYA:
        PosStart = vect(-32.824, -1.762, 48.356)
        PosCheckpoint = vect(16.248, -3.81, 25.782)
        PosFinish = vect(2.417, 3.193, 107.37)


rule "Start - Escort":
	@Event global
    if getCurrentMap() == Map.DORADO:
        PosStart = vect(167.15, 18.01, 68)
        PosFinish = vect(125, 7, -18)
        PosCheckpoint = vect(68, 17, 40)
        return
    if getCurrentMap() == Map.HAVANA:
        PosFinish = vect(42.47, 6, -47)
        PosStart = vect(101.15, 2.26, -82.72)
        PosCheckpoint = vect(6, 12, -75)
        return
    if getCurrentMap() == Map.JUNKERTOWN:
        PosStart = vect(32.55, 15.2, -89.45)
        PosFinish = vect(-46.5, 9, -47.5)
        PosCheckpoint = vect(-18, 13.5, -90)
        return
    if getCurrentMap() == Map.RIALTO:
        PosStart = vect(110.31, -0.25, -34.22)
        PosFinish = vect(-15, 5.75, -55)
        PosCheckpoint = vect(33, 0.65, -36.59)
        return
    if getCurrentMap() == Map.ROUTE66:
        PosStart = vect(37.82, 2.01, 16.71)
        PosCheckpoint = vect(16, 8, -23)
        PosFinish = vect(51, 0.23, 45)
        return
    if getCurrentMap() == Map.WATCHPOINT_GIBRALTAR:
        PosStart = vect(5.42, -5, -81.88)
        PosFinish = vect(97.362, -1, 38.946)
        PosCheckpoint = vect(89, 3, -27)


rule "Start - Hybrid":
	@Event global
    if getCurrentMap() == Map.BLIZZ_WORLD:
        PosStart = vect(23.31, 2, 79.2)
        PosCheckpoint = vect(-72.57, 6.58, 105.2)
        PosFinish = vect(-8, -1, 103.66)
        return
    if getCurrentMap() == Map.EICHENWALDE:
        PosStart = vect(54.97, 22.68, -104.11)
        PosFinish = vect(64.74, 15.83, -61.86)
        PosCheckpoint = vect(4.93, 5, -14.1)
        return
    if getCurrentMap() == Map.HOLLYWOOD:
        PosStart = vect(-29.04, 13.86, -12.75)
        PosFinish = vect(-42.39, -0.15, 54.98)
        PosCheckpoint = vect(19.77, 6, 59.12)
        return
    if getCurrentMap() == Map.KINGS_ROW:
        PosStart = vect(14.73, 6, 18.19)
        PosFinish = vect(-98.35, 1, -6.78)
        PosCheckpoint = vect(-60, 0.18, -47.5)
        return
    if getCurrentMap() == Map.NUMBANI:
        PosStart = vect(88.38, 4.25, -24.17)
        PosFinish = vect(204.25, -2.19, 22.61)
        PosCheckpoint = vect(129.52, -3.75, 38.61)


rule "Start - Control - Busan":
	@Event global
	@Condition getCurrentMap() == Map.BUSAN
    #Downtown
    if getCurrentObjective() == 0:
        PosStart = vect(51.9, 21.4, -129)
        PosCheckpoint = vect(51.9, 5, -74)
        PosFinish = vect(51.9, 12, -147.9)
        return
    #MEKA Base
    if getCurrentObjective() == 2:            
        PosStart = vect(210, 9.1, 212)
        PosCheckpoint = vect(205.5, 9.1, 202)
        PosFinish = vect(226, 9.15, 250)
        return
    #Sanctuary
    if getCurrentObjective() == 1:
        PosStart = vect(-328.5, 8, 180.5)
        PosCheckpoint = vect(-328.5, 9.8, 107.4)
        PosFinish = vect(-328.5, 9, 195)


rule "Start - Control - Ilios":
	@Event global
	@Condition getCurrentMap() == Map.ILIOS
    #Lighthouse
    if getCurrentObjective() == 0:
        PosStart = vect(318, -23.66, -35)
        PosCheckpoint = vect(365, -28.64, -54.5)
        PosFinish = vect(307.8, -8, 31.4)
        return
    #Ruins
    if getCurrentObjective() == 2:
        PosStart = vect(28.5, 57.5, -141.5)
        PosCheckpoint = vect(-55, 65.4, -178)
        PosFinish = vect(11.9, 66.37, -144.2)
        return
    #Well
    if getCurrentObjective() == 1:
        PosStart = vect(-195, 1, -3)
        PosCheckpoint = vect(-284, -0.5, 10)
        PosFinish = vect(-271.9, 1.25, 53.5)


rule "Start - Control - Lijiang Tower":
	@Event global
	@Condition getCurrentMap() == Map.LIJIANG_TOWER
    #Control Tower
    if getCurrentObjective() == 2:
        PosStart = vect(0, 278, 293)
        PosCheckpoint = vect(0, 276, 330)
        PosFinish = vect(0, 270, 254)
        return
    #Garden
    if getCurrentObjective() == 1:
        PosStart = vect(-65, 94, 145)
        PosCheckpoint = vect(0, 95, 125)
        PosFinish = vect(52, 94, 182)
        return
    #Night Market
    if getCurrentObjective() ==  0:
        PosStart = vect(1, -2, -82)
        PosCheckpoint = vect(49, 3, -47)
        PosFinish = vect(1, 0, -10)


rule "Start - Control - Nepal":
	@Event global
	@Condition getCurrentMap() == Map.NEPAL
    #Sanctum
    if getCurrentObjective() == 2:
        PosStart = vect(-26, 10.66, -34)
        PosCheckpoint = vect(-63, 13, 0)
        PosFinish = vect(-24, 21, 82)
        return
    #Shrine
    if getCurrentObjective() == 1:
        PosStart = vect(-158, -89, 0)
        PosCheckpoint = vect(-220, -93.57, 0)
        PosFinish = vect(-207, -86, -44)
        return
    #Village
    if getCurrentObjective() == 0:
        PosStart = vect(78, 129.8, -59)
        PosCheckpoint = vect(81, 128, 8)
        PosFinish = vect(102, 136, 78)


rule "Start - Control - Oasis":
	@Event global
	@Condition getCurrentMap() == Map.OASIS
    #City Center
    if getCurrentObjective() == 0:
        PosStart = vect(166, 4, 270)
        PosCheckpoint = vect(102, -9, 288)
        PosFinish = vect(119, 1, 223)
        return
    #Gardens
    if getCurrentObjective() == 1:
        PosStart = vect(172.66, 8.4, -166)
        PosCheckpoint = vect(141.33, 7.4, -247.33)
        PosFinish = vect(101.5, 0, -207.5)
        return
    #University
    if getCurrentObjective() == 2:
        PosStart = vect(-198, 9, 0)
        PosCheckpoint = vect(-220, 19, 0)
        PosFinish = vect(-175, 16, 61.5)


#Gamemode
rule "Start - Global":
    @Event global
    #Start / Checkpoint / Finish effects
    createEffect(getAllPlayers(), Effect.RING, Color.GREEN, PosStart, 2, EffectReeval.VISIBILITY)
    createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, Color.WHITE, PosFinish, 5, EffectReeval.VISIBILITY)
    createEffect(getAllPlayers(), Effect.RING, Color.WHITE, PosFinish, 5, EffectReeval.VISIBILITY)
    createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, Color.SKY_BLUE, PosCheckpoint, 3.5, EffectReeval.VISIBILITY)
    createEffect(getAllPlayers(), Effect.RING, Color.SKY_BLUE, PosCheckpoint, 3.5, EffectReeval.VISIBILITY)
    #Vars
    setMatchTime(3599)
    TimeFirst = 9999
    TimeSecond = 9999
    TimeThird = 9999
    Visible = true
    PosExplanation = getObjectivePosition(getCurrentObjective()) + vect(0, 100, 0)
    #Leaderboards
    hudHeader(getAllPlayers(), l"{0} - {1} - {2}".format("3", l"{0} sec".format(TimeThird), PlayerThird), HudPosition.RIGHT, 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudHeader(getAllPlayers(), l"{0} - {1} - {2}".format("2", l"{0} sec".format(TimeSecond), PlayerSecond), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudHeader(getAllPlayers(), l"{0} - {1} - {2}".format(l"Record", l"{0} sec".format(TimeFirst), PlayerFirst), HudPosition.RIGHT, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    #Help text standard
    hudSubtext([player for player in getAllPlayers() if player.Mode != -1], "Toggle Help - 'Ultimate Status'", HudPosition.LEFT, 3, Color.YELLOW, HudReeval.VISIBILITY)
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and player.Mode != -1 and player == hostPlayer], "Toggle Invisibility - 'Need Healing'", HudPosition.LEFT, 4, Color.YELLOW, HudReeval.VISIBILITY)
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and not player.Mode], "Reset - Ultimate", HudPosition.LEFT, 5, Color.YELLOW, HudReeval.VISIBILITY)
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and not player.Mode], "Cycle Auto Reset - Leftclick", HudPosition.LEFT, 6, Color.YELLOW, HudReeval.VISIBILITY)
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and not player.Mode], "Practice Mode - Interact", HudPosition.LEFT, 7, Color.YELLOW, HudReeval.VISIBILITY)
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and not player.Mode], "Player Spectator Mode - Ability 2", HudPosition.LEFT, 8, Color.YELLOW, HudReeval.VISIBILITY)
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and not player.Mode], "Spectator Mode - Ability 1", HudPosition.LEFT, 9, Color.YELLOW, HudReeval.VISIBILITY)
    #Help text practice
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and player.Mode >= 1 and player.Mode <= 3], "Standard Mode - Interact", HudPosition.LEFT, 5, Color.YELLOW, HudReeval.VISIBILITY)
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and player.Mode >= 1 and player.Mode <= 3], "Ult Reset (Checkpoint) - Ultimate", HudPosition.LEFT, 6, Color.YELLOW, HudReeval.VISIBILITY)
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and player.Mode >= 1 and player.Mode <= 3], "Set Checkpoint - Rightclick", HudPosition.LEFT, 7, Color.YELLOW, HudReeval.VISIBILITY)
    #Help text playerspec
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and player.Mode >= 4 and player.Mode <= 6], "Standard Mode - Ability 2", HudPosition.LEFT, 5, Color.YELLOW, HudReeval.VISIBILITY)
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and player.Mode >= 4 and player.Mode <= 6], "Spectate next - Leftclick", HudPosition.LEFT, 6, Color.YELLOW, HudReeval.VISIBILITY)
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and player.Mode >= 4 and player.Mode <= 6], "Spectate previous - Rightclick", HudPosition.LEFT, 7, Color.YELLOW, HudReeval.VISIBILITY)
    #Help text spectator
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and player.Mode >= 7 and player.Mode <= 9], "Standard Mode - Ability 1", HudPosition.LEFT, 5, Color.YELLOW, HudReeval.VISIBILITY)
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and player.Mode >= 7 and player.Mode <= 9], "Stop - Leftclick", HudPosition.LEFT, 6, Color.YELLOW, HudReeval.VISIBILITY)
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and player.Mode >= 7 and player.Mode <= 9], "Slow Move - Rightclick", HudPosition.LEFT, 7, Color.YELLOW, HudReeval.VISIBILITY)


rule "Create game mode explanation":
    @Event global
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "Welcome to Lucio Surf!", PosExplanation + vect(5, 4, 0), 4, Clip.NONE, WorldTextReeval.VISIBILITY, Color.GREEN, SpecVisibility.DEFAULT)
    #Start Text
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "start:", PosExplanation + vect(-(5), 3, 0), 3, Clip.NONE, WorldTextReeval.VISIBILITY, Color.LIME_GREEN, SpecVisibility.DEFAULT)
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "- Make sure to read the information behind you before starting.", PosExplanation + vect(-5, 2.5, 0), 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.TURQUOISE, SpecVisibility.DEFAULT)
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "- Start Gamemode: Ultimate", PosExplanation + vect(-5, 2, 0), 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.TURQUOISE, SpecVisibility.DEFAULT)
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "- Watch Route Preview: Reload", PosExplanation + vect(-5, 1.75, 0), 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.TURQUOISE, SpecVisibility.DEFAULT)
    #How to Play
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "how to play:", PosExplanation + vect(5, 3, 0), 3, Clip.NONE, WorldTextReeval.VISIBILITY, Color.LIME_GREEN, SpecVisibility.DEFAULT)
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "- Lucio Surf is inspired by CS Surf and therefore follows a similar rule set.", PosExplanation + vect(5, 2.5, 0), 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.TURQUOISE, SpecVisibility.DEFAULT)
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "- Your goal is to get from Start to Checkpoint (blue beam)\n   to Finish (white beam) as fast as you can.", PosExplanation + vect(5, 2, 0), 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.TURQUOISE, SpecVisibility.DEFAULT)
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "- Touching the ground results in you being resetted to the start.", PosExplanation + vect(5, 1.75, 0), 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.TURQUOISE, SpecVisibility.DEFAULT)
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "- Watch out for any additional info given to you by small and big messages and HUD.", PosExplanation + vect(5, 1.5, 0), 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.TURQUOISE, SpecVisibility.DEFAULT)
    #Features
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "Features:", PosExplanation + vect(cosDeg(60) * 5, 3, sinDeg(60) * 5), 3, Clip.NONE, WorldTextReeval.VISIBILITY, Color.LIME_GREEN, SpecVisibility.DEFAULT)
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "- Ult Reset: Resets you back to start.", PosExplanation + vect(cosDeg(60) * 5, 2.5, sinDeg(60) * 5), 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.TURQUOISE, SpecVisibility.DEFAULT)
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "- Auto Reset: Resets you when your current time is higher than your pb or the record.", PosExplanation + vect(cosDeg(60) * 5, 2.25, sinDeg(60) * 5), 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.TURQUOISE, SpecVisibility.DEFAULT)
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "- Route Preview: Short camera tour showing checkpoint and finish.", PosExplanation + vect(cosDeg(60) * 5, 2, sinDeg(60) * 5), 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.TURQUOISE, SpecVisibility.DEFAULT)
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "{0}\n{1}".format("- Practice Mode: Doesn't reset you when hitting the ground.","Let's you set checkpoints which preserve your velocity and facing direction."), PosExplanation + vect(cosDeg(60) * 5, 1.55, sinDeg(60) * 5), 2, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.TURQUOISE, SpecVisibility.DEFAULT)
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "- Player Spectator Mode: Let's you spectate Players.", PosExplanation + vect(cosDeg(60) * 5, 1.25, sinDeg(60) * 5), 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.TURQUOISE, SpecVisibility.DEFAULT)
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "- Spectator Mode: Let's you fly around the map spectating the game.", PosExplanation + vect(cosDeg(60) * 5, 1, sinDeg(60) * 5), 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.TURQUOISE, SpecVisibility.DEFAULT)
    #Resources
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "Resources:", PosExplanation + vect(cosDeg(-60) * 5, 3, sinDeg(-60) * 5), 3, Clip.NONE, WorldTextReeval.VISIBILITY, Color.LIME_GREEN, SpecVisibility.DEFAULT)
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "- Workshop Code: MBR4N", PosExplanation + vect(cosDeg(-60) * 5, 2.5, sinDeg(-60) * 5), 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.TURQUOISE, SpecVisibility.DEFAULT)
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "- Surfing Discord: https://discord.gg/G9QBCDY", PosExplanation + vect(cosDeg(-60) * 5, 2.25, sinDeg(-60) * 5), 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.TURQUOISE, SpecVisibility.DEFAULT)
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "- Wallriding Discord: https://discord.gg/{0}".format(w"nfURYvy"), PosExplanation + vect(cosDeg(-60) * 5, 2, sinDeg(-60) * 5), 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.TURQUOISE, SpecVisibility.DEFAULT)
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "- Leaderboards: https://bit.ly/{0}".format(w"2WfVeSj"), PosExplanation + vect(cosDeg(-60) * 5, 1.75, sinDeg(-60) * 5), 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.TURQUOISE, SpecVisibility.DEFAULT)


rule "Start - Player":
    @Event eachPlayer
    @Condition eventPlayer.hasSpawned()
    createIcon(eventPlayer, PosFinish + vect(0, 6, 0), Icon.FLAG, IconReeval.VISIBILITY_AND_POSITION, Color.WHITE, true)
    createIcon(eventPlayer, PosCheckpoint + vect(0, 6, 0), Icon.ARROW_DOWN, IconReeval.VISIBILITY_AND_POSITION, Color.SKY_BLUE, true)
    hudHeader(eventPlayer, eventPlayer, HudPosition.LEFT, 0, Color.YELLOW, HudReeval.NONE, SpecVisibility.DEFAULT)
    eventPlayer.TimeBest = 9999
    eventPlayer.Finished = false
    eventPlayer.Checkpoint = false
    eventPlayer.Mode = -1
    eventPlayer.Attempts = -1
    eventPlayer.enableDeathSpectateAllPlayers()
    eventPlayer.enableDeathSpectateTargetHud()
    eventPlayer.disallowButton(Button.ABILITY_1)
    eventPlayer.disallowButton(Button.ABILITY_2)
    eventPlayer.disallowButton(Button.ULTIMATE)
    eventPlayer.setInvisibility(Invis.ALL)
    eventPlayer.setMoveSpeed(0)
    eventPlayer.setGravity(0)
    eventPlayer.teleport(PosExplanation)
    wait()
    eventPlayer.setFacing(Vector.LEFT, Relativity.TO_WORLD)
    eventPlayer.setStatusEffect(null, Status.ROOTED, 9999)
    eventPlayer.applyImpulse(eventPlayer.getVelocity() * -0.001, 0.001, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.applyImpulse(eventPlayer.getVelocity() * 0.001, 0.001, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)


rule "Start - Player - Mode":
    @Event eachPlayer
    @Condition eventPlayer.Mode == -1
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    StartPlayer()


rule "Route Preview (camera)":
	@Event eachPlayer
    @Condition eventPlayer.Mode == -1
    @Condition eventPlayer.isHoldingButton(Button.RELOAD)
    eventPlayer.Mode = -2
    eventPlayer.setMoveSpeed(0)
    bigMessage(eventPlayer, "Route Preview")
    eventPlayer.PosCamera = PosStart + vect(0, 5, 0)
    eventPlayer.setCamera(eventPlayer.PosCamera, eventPlayer.FacingCamera, 2)
    eventPlayer.FacingCamera = vect(PosCheckpoint.x + PosCheckpoint.x - PosStart.x, PosCheckpoint.y + 5, PosCheckpoint.z + PosCheckpoint.z - PosStart.z)
    chase(eventPlayer.PosCamera, PosCheckpoint + vect(0, 5, 0), duration=5, ChaseReeval.NONE)
    wait(6)
    eventPlayer.FacingCamera = PosFinish + vect(0, 5, 0)
    wait(1)
    chase(eventPlayer.PosCamera, PosFinish + vect(0, 5, 0), duration=5, ChaseReeval.NONE)
    wait(7)
    eventPlayer.stopCamera()
    eventPlayer.setMoveSpeed(100)
    StartPlayer()


rule "Start timer":
	@Event eachPlayer
    @Condition eventPlayer.Mode == 0
    @Condition not eventPlayer.Checkpoint
    @Condition distance(PosStart, eventPlayer) > 2 or not eventPlayer.isOnGround()
    chase(eventPlayer.TimeCurrent, 5000, rate=1, ChaseReeval.NONE)
    if not Visible:
        return
    eventPlayer.setInvisibility(Invis.NONE)


rule "Checkpoint":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 0
    @Condition not eventPlayer.Finished and not eventPlayer.Checkpoint
    @Condition distance(PosCheckpoint, vect(eventPlayer.getPosition().x, PosCheckpoint.y, eventPlayer.getPosition().z)) <= 3.5
    @Condition eventPlayer.TimeCurrent > 1
    eventPlayer.Checkpoint = true
    smallMessage(eventPlayer, l"{0} {1}".format(l"Finish", l"Unlocked"))
    bigMessage(eventPlayer, eventPlayer.TimeCurrent)


rule "Finish":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 0
    @Condition eventPlayer.Checkpoint and not eventPlayer.Finished
	@Condition distance(PosFinish, vect(eventPlayer.getPosition().x, PosFinish.y, eventPlayer.getPosition().z)) <= 5
    stopChasingVariable(eventPlayer.TimeCurrent)
    if eventPlayer.TimeCurrent <= 1:
        return
    eventPlayer.Attempts += 1
    if eventPlayer.TimeCurrent < eventPlayer.TimeBest:
        eventPlayer.TimeBest = eventPlayer.TimeCurrent
        eventPlayer.NewBest = true
    else:
        bigMessage(eventPlayer, l"{0}!!!".format(l"Finished"))
        goto lbl_1
    if eventPlayer.TimeCurrent >= TimeThird:
        goto lbl_2
    if eventPlayer.TimeCurrent >= TimeSecond:
        TimeThird = eventPlayer.TimeCurrent
        PlayerThird = eventPlayer
        goto lbl_3
    if eventPlayer.TimeCurrent >= TimeFirst:
        if eventPlayer != PlayerSecond:
            TimeThird = TimeSecond
            PlayerThird = PlayerSecond
        TimeSecond = eventPlayer.TimeCurrent
        PlayerSecond = eventPlayer
        goto lbl_4
    if eventPlayer.TimeCurrent < TimeFirst:
        if eventPlayer != PlayerFirst:
            if eventPlayer != PlayerSecond:
                TimeThird = TimeSecond
                PlayerThird = PlayerSecond
            TimeSecond = TimeFirst
            PlayerSecond = PlayerFirst
        TimeFirst = eventPlayer.TimeCurrent
        PlayerFirst = eventPlayer
    lbl_1:
    lbl_2:
    lbl_3:
    lbl_4:
    wait()
    eventPlayer.Finished = true


rule "Finish (no Checkpoint)":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 0
    @Condition not eventPlayer.Checkpoint and not eventPlayer.Finished
	@Condition distance(PosFinish, vect(eventPlayer.getPosition().x, PosFinish.y, eventPlayer.getPosition().z)) <= 5
    bigMessage(eventPlayer, l"{0} {1}".format(l"No", l"Checkpoint"))


rule "Finish Message (Best Time)":
	@Event eachPlayer
    @Condition eventPlayer.Finished
    @Condition eventPlayer.NewBest == true
    @Condition eventPlayer != PlayerFirst
    bigMessage(eventPlayer, l"{0} - {1}".format(l"{0} {1}".format(l"Best", l"Time"), eventPlayer.TimeBest))


rule "Finish Message (Record Time)":
	@Event eachPlayer
    @Condition eventPlayer.Finished
    @Condition eventPlayer.NewBest == true
    @Condition eventPlayer == PlayerFirst
    bigMessage(getAllPlayers(), l"{0}: {1}".format(l"New Record", l"{0} - {1}".format(l"{0} sec".format(eventPlayer.TimeBest), l"{0}!!!".format(eventPlayer))))


rule "Floor":
	@Event eachPlayer
    @Condition eventPlayer.Mode == 0
    @Condition eventPlayer.isOnGround()
    @Condition distance(PosStart, vect(eventPlayer.getPosition().x, PosStart.y, eventPlayer.getPosition().z)) > 4 and distance(PosFinish, vect(eventPlayer.getPosition().x, PosFinish.y, eventPlayer.getPosition().z)) > 6 and distance(PosCheckpoint, vect(eventPlayer.getPosition().x, PosCheckpoint.y, eventPlayer.getPosition().z)) > 6
    kill(eventPlayer, null)


rule "Ult Reset":
	@Event eachPlayer
    @Condition eventPlayer.Mode == 0
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition distance(PosStart, vect(eventPlayer.getPosition().x, PosStart.y, eventPlayer.getPosition().z)) > 2
    kill(eventPlayer, null)


rule "Velocity Counter (red)":
    @Event eachPlayer
    @Condition eventPlayer.getHorizontalSpeed() <= 8.6
    @Condition eventPlayer.Spawned
    destroyHudText(getLastCreatedText())
    hudHeader(eventPlayer, l"{0} m/s".format(eventPlayer.getHorizontalSpeed()), HudPosition.TOP, 2, Color.RED, HudReeval.STRING)


rule "Velocity Counter (Orange)":
    @Event eachPlayer
    @Condition eventPlayer.getHorizontalSpeed() > 8.6
    @Condition eventPlayer.getHorizontalSpeed() < 13.15
    @Condition eventPlayer.Spawned
    destroyHudText(getLastCreatedText())
    hudHeader(eventPlayer, l"{0} m/s".format(eventPlayer.getHorizontalSpeed()), HudPosition.TOP, 2, Color.ORANGE, HudReeval.STRING)


rule "Velocity Counter (Yellow)":
    @Event eachPlayer
    @Condition eventPlayer.getHorizontalSpeed() >= 13.15
    @Condition eventPlayer.getHorizontalSpeed() < 17.2
    @Condition eventPlayer.Spawned
    destroyHudText(getLastCreatedText())
    hudHeader(eventPlayer, l"{0} m/s".format(eventPlayer.getHorizontalSpeed()), HudPosition.TOP, 2, Color.YELLOW, HudReeval.STRING)


rule "Velocity Counter (Green)":
    @Event eachPlayer
    @Condition eventPlayer.getHorizontalSpeed() >= 17.2
    @Condition eventPlayer.Spawned
    destroyHudText(getLastCreatedText())
    hudHeader(eventPlayer, l"{0} m/s".format(eventPlayer.getHorizontalSpeed()), HudPosition.TOP, 2, Color.GREEN, HudReeval.STRING)


rule "Toggle Invisibility (Host only)":
	@Event eachPlayer
    @Condition eventPlayer.isCommunicating(Comms.NEED_HEALING)
    @Condition eventPlayer == hostPlayer
    if Visible:
        smallMessage(eventPlayer, l"{0} {1}".format(l"Players", l"Invisible"))
        getAllPlayers().setInvisibility(Invis.ALL)
        Visible = false
        return
    smallMessage(eventPlayer, "{0} {1}".format(l"Players", l"Visible"))
    [player for player in getAllPlayers() if eventPlayer.Mode == 0 and (distance(PosStart, player.getPosition()) > 2 or not eventPlayer.isOnGround())].setInvisibility(Invis.NONE)
    Visible = true


rule "Toggle Help":
	@Event eachPlayer
	@Condition eventPlayer.isCommunicating(Comms.ULTIMATE_STATUS)
    if eventPlayer.HideHelp:
        eventPlayer.HideHelp = false
        return
    eventPlayer.HideHelp = true


rule "Cycle Auto Reset":
	@Event eachPlayer
    @Condition eventPlayer.Mode == 0
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE)
    eventPlayer.AutoReset += 1
    if eventPlayer.AutoReset >= 3:
        eventPlayer.AutoReset = 0
    if eventPlayer.AutoReset == 0:
        smallMessage(eventPlayer, "Auto Reset - Disabled")
        return
    if eventPlayer.AutoReset == 1:
        smallMessage(eventPlayer, "Auto Reset - Personal Best")
        return
    if eventPlayer.AutoReset == 2:
        smallMessage(eventPlayer, "Auto Reset - Record")
        return


rule "Auto Reset (Personal Best)":
	@Event eachPlayer
    @Condition eventPlayer.Mode == 0
    @Condition eventPlayer.AutoReset == 1
    @Condition eventPlayer.TimeCurrent > eventPlayer.TimeBest
    smallMessage(eventPlayer, "Reset by 'Auto Reset'")
    kill(eventPlayer, null)


rule "Auto Reset (Record)":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 0
    @Condition eventPlayer.AutoReset == 2
    @Condition eventPlayer.TimeCurrent > TimeFirst
    smallMessage(eventPlayer, "Reset by 'Auto Reset'")
    kill(eventPlayer, null)


rule "Practice Mode (Enabled)":
	@Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)
    @Condition eventPlayer.Mode == 0
    stopChasingVariable(eventPlayer.TimeCurrent)
    eventPlayer.TimeCurrent = 0
    eventPlayer.Attempts = 0
    eventPlayer.Mode = 1
    createIcon(eventPlayer, eventPlayer.PosPracticeCheckpoint, Icon.FLAG, IconReeval.VISIBILITY_AND_POSITION, Color.GREEN, true)
    bigMessage(eventPlayer, "Entering Practice Mode")
    eventPlayer.setInvisibility(Invis.ALL)
    eventPlayer.clearStatusEffect(Status.PHASED_OUT)
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)


rule "Practice Mode (Button Held - Enabled)":
	@Event eachPlayer
    @Condition not eventPlayer.isHoldingButton(Button.INTERACT)
    @Condition eventPlayer.Mode == 1
    eventPlayer.Mode = 2


rule "Fire status (Enabled)":
	@Event eachPlayer
	@Condition eventPlayer.Mode <= 3 and eventPlayer.Mode >= 1
    eventPlayer.setStatusEffect(null, Status.BURNING, 9999)
    eventPlayer.setStatusEffect(null, Status.INVINCIBLE, 9999)


rule "Practice Mode (disabled)":
	@Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)
    @Condition eventPlayer.Mode == 2
    eventPlayer.Mode = 3


rule "Practice Mode (Button Held - disabled)":
	@Event eachPlayer
    @Condition not eventPlayer.isHoldingButton(Button.INTERACT)
    @Condition eventPlayer.Mode == 3
    destroyIcon(getLastCreatedEntity())
    eventPlayer.PosPracticeCheckpoint = 0
    bigMessage(eventPlayer, "Leaving Practice Mode")
    eventPlayer.Attempts = -1
    eventPlayer.Mode = 0
    if not eventPlayer.isOnGround() or distance(PosStart, vect(eventPlayer.getPosition().x, PosStart.y, eventPlayer.getPosition().z)) <= 4 or distance(PosFinish, vect(eventPlayer.getPosition().x, PosFinish.y, eventPlayer.getPosition().z)) <= 6 or distance(PosCheckpoint, vect(eventPlayer.getPosition().x, PosCheckpoint.y, eventPlayer.getPosition().z)) <= 6:
        kill(eventPlayer, null)


rule "Fire status (Disabled)":
	@Event eachPlayer
	@Condition eventPlayer.Mode != 1 and eventPlayer.Mode != 2 and eventPlayer.Mode != 3
    eventPlayer.clearStatusEffect(Status.BURNING)
    eventPlayer.clearStatusEffect(Status.INVINCIBLE)


rule "Practice Checkpoints":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE)
    @Condition eventPlayer.Mode == 2
    eventPlayer.PosPracticeCheckpoint = eventPlayer.getPosition()
    eventPlayer.FacingPracticeCheckpoint = eventPlayer.getFacingDirection()
    eventPlayer.VelocityPracticeCheckpoint = eventPlayer.getVelocity()
    eventPlayer.SpeedPracticeCheckpoint = eventPlayer.getSpeed()
    smallMessage(eventPlayer, l"{0} {1}".format(l"Checkpoint", l"Saved"))
    return


rule "Ult Reset Checkpoint":
	@Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition eventPlayer.Mode == 2
    kill(eventPlayer, null)
    eventPlayer.Attempts += 1


rule "Player Spectator Mode enabled":
	@Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2)
    @Condition eventPlayer.Mode == 0
    eventPlayer.Mode = 4
    stopChasingVariable(eventPlayer.TimeCurrent)
    eventPlayer.TimeCurrent = 0
    eventPlayer.setRespawnTime(9999)
    bigMessage(eventPlayer, "Entering Player Spectator Mode")
    wait()
    kill(eventPlayer, null)


rule "Player Spectator Mode enabled (Button Held)":
	@Event eachPlayer
    @Condition not eventPlayer.isHoldingButton(Button.ABILITY_2)
    @Condition eventPlayer.Mode == 4
    stopChasingVariable(eventPlayer.TimeCurrent)
    eventPlayer.TimeCurrent = 0
    eventPlayer.Mode = 5


rule "Player Spectator Mode disabled":
	@Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2)
    @Condition eventPlayer.Mode == 5
    eventPlayer.Mode = 6


rule "Player Specator Mode disabled (Button Held)":
	@Event eachPlayer
    @Condition not eventPlayer.isHoldingButton(Button.ABILITY_2)
    @Condition eventPlayer.Mode == 6
    eventPlayer.teleport(PosStart)
    eventPlayer.resurrect()
    eventPlayer.setStatusEffect(null, Status.ROOTED, 0.5)
    eventPlayer.Attempts = 0
    wait()
    eventPlayer.Mode = 0
    bigMessage(eventPlayer, "Leaving Player Spectator Mode")


rule "Spectator Mode enable":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 0
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_1)
    eventPlayer.Mode = 7
    eventPlayer.setGravity(0)
    eventPlayer.setMoveSpeed(200)
    eventPlayer.setInvisibility(Invis.ALL)
    stopChasingVariable(eventPlayer.TimeCurrent)
    eventPlayer.TimeCurrent = 0
    eventPlayer.Attempts = 0
    eventPlayer.clearStatusEffect(Status.PHASED_OUT)
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)
    bigMessage(eventPlayer, "Entering Spectator Mode")
    

rule "Spectator Mode enable (Button Held)":
	@Event eachPlayer
    @Condition not eventPlayer.isHoldingButton(Button.ABILITY_1)
    @Condition eventPlayer.Mode == 7
    eventPlayer.Mode = 8


rule "Spectator Mode disabled":
	@Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_1)
    @Condition eventPlayer.Mode == 8
    eventPlayer.Mode = 9


rule "Specator Mode disabled (Button Held)":
	@Event eachPlayer
    @Condition not eventPlayer.isHoldingButton(Button.ABILITY_1)
    @Condition eventPlayer.Mode == 9
    eventPlayer.setGravity(100)
    eventPlayer.setMoveSpeed(100)
    eventPlayer.Attempts = -1
    eventPlayer.Mode = 0
    bigMessage(eventPlayer, "Leaving Spectator Mode")
    if not eventPlayer.isOnGround() or distance(PosStart, vect(eventPlayer.getPosition().x, PosStart.y, eventPlayer.getPosition().z)) <= 4 or distance(PosFinish, vect(eventPlayer.getPosition().x, PosFinish.y, eventPlayer.getPosition().z)) <= 6 or distance(PosCheckpoint, vect(eventPlayer.getPosition().x, PosCheckpoint.y, eventPlayer.getPosition().z)) <= 6:
        kill(eventPlayer, null)


rule "Spectator Mode (move up enabled)":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.JUMP)
	@Condition eventPlayer.Mode >= 7 and eventPlayer.Mode <= 9
    eventPlayer.applyImpulse(Vector.UP, 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)


rule "Spectator Mode (move up disabled)":
    @Event eachPlayer
    @Condition not eventPlayer.isHoldingButton(Button.JUMP)
	@Condition eventPlayer.Mode >= 7 and eventPlayer.Mode <= 9
    eventPlayer.applyImpulse(Vector.DOWN, 0.001, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.applyImpulse(Vector.UP, 0.001, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)


rule "Spectator Mode (move down enabled)":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.CROUCH)
	@Condition eventPlayer.Mode >= 7 and eventPlayer.Mode <= 9
    eventPlayer.applyImpulse(Vector.DOWN, 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)


rule "Spectator Mode (move down disabled)":
    @Event eachPlayer
    @Condition not eventPlayer.isHoldingButton(Button.CROUCH)
	@Condition eventPlayer.Mode >= 7 and eventPlayer.Mode <= 9
    eventPlayer.applyImpulse(Vector.UP, 0.001, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.applyImpulse(Vector.DOWN, 0.001, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)


rule "Spectator Mode (stop movement)":
	@Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE)
    @Condition eventPlayer.Mode >= 7 and eventPlayer.Mode <= 9
    eventPlayer.applyImpulse(eventPlayer.getVelocity() * -0.001, 0.001, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.applyImpulse(eventPlayer.getVelocity() * 0.001, 0.001, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)


rule "Spectator Mode (slow movement enabled)":
    @Event eachPlayer
    @Condition eventPlayer.Mode >= 7 and eventPlayer.Mode <= 9
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE)
    eventPlayer.setMoveSpeed(150)
    if eventPlayer.getHorizontalSpeed() <= 12.89:
        return
    eventPlayer.applyImpulse(eventPlayer.getVelocity() * -0.001, 1, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.applyImpulse(eventPlayer.getVelocity() * 1, 12.89, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)


rule "Spectator Mode (slow movement disabled)":
    @Event eachPlayer
    @Condition eventPlayer.Mode >= 7 and eventPlayer.Mode <= 9
    @Condition not eventPlayer.isHoldingButton(Button.SECONDARY_FIRE)
    eventPlayer.setMoveSpeed(200)


rule "Circle Fix":
	@Event eachPlayer
    @Condition distance(PosStart, eventPlayer) <= 2
    @Condition eventPlayer.isOnGround()
    @Condition eventPlayer.Checkpoint == false
    @Condition eventPlayer.getHorizontalSpeed() <= 8.6
    stopChasingVariable(eventPlayer.TimeCurrent)
    eventPlayer.TimeCurrent = 0
    eventPlayer.clearStatusEffect(Status.PHASED_OUT)
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)
    eventPlayer.setInvisibility(Invis.ALL)
    wait(0.05)
    eventPlayer.allowButton(Button.JUMP)


rule "Match Time Frozen":
	@Event global
    @Condition isGameInProgress()
    wait()
    while true:
        wait(getMatchTime() - 10)
        setMatchTime(3599)


rule "Respawn":
	@Event playerDied
    if eventPlayer.Mode == 0:
        eventPlayer.disallowButton(Button.JUMP)
        if not eventPlayer.Finished:
            eventPlayer.Attempts += 1
        if eventPlayer.NewBest:
            eventPlayer.NewBest = false
            eventPlayer.Attempts = 0
        eventPlayer.teleport(PosStart)
        eventPlayer.resurrect()
        eventPlayer.setStatusEffect(null, Status.ROOTED, 0.5)
        wait()
        eventPlayer.Finished = false
        eventPlayer.Checkpoint = false
        return
    if eventPlayer.Mode == 1 or eventPlayer.Mode == 2 or eventPlayer.Mode == 3:
        if eventPlayer.PosPracticeCheckpoint == 0:
            eventPlayer.disallowButton(Button.JUMP)
            eventPlayer.teleport(PosStart)
            eventPlayer.resurrect()
            eventPlayer.setStatusEffect(null, Status.ROOTED, 0.5)
            return
        eventPlayer.teleport(eventPlayer.PosPracticeCheckpoint)
        eventPlayer.resurrect()
        eventPlayer.setFacing(eventPlayer.FacingPracticeCheckpoint, Relativity.TO_WORLD)
        eventPlayer.applyImpulse(eventPlayer.getVelocity() * -0.001, 0.001, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
        eventPlayer.applyImpulse(eventPlayer.VelocityPracticeCheckpoint, eventPlayer.SpeedPracticeCheckpoint, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)    
        eventPlayer.clearStatusEffect(Status.PHASED_OUT)
        eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)


