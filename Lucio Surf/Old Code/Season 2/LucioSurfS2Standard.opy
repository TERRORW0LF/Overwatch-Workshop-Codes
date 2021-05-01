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
globalvar PosFinish 24


#Player variables

playervar TimeCurrent 0
playervar TimeBest 1
playervar NewBest 2
playervar Finished 3
playervar AutoReset 4
playervar HideHelp 5
playervar Mode 6
playervar Attempts 7
playervar Spawned 8
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
    wait()
    hudHeader(eventPlayer, "{0} m/s".format(eventPlayer.getHorizontalSpeed()), HudPosition.TOP, 1, Color.RED, HudReeval.STRING, SpecVisibility.DEFAULT)
    eventPlayer.Mode = 0
    eventPlayer.Spawned = true
    eventPlayer.clearStatusEffect(Status.ROOTED)
    eventPlayer.setGravity(100)
    eventPlayer.setMoveSpeed(100)
    kill(eventPlayer, null)


#Maps
rule  "Start - Assault - Every Map Is In Order (a - z)":
	@Event global
    if getCurrentMap() == Map.HANAMURA:
        PosStart = vect(-6.786, 0.252, -84.457)
        PosFinish = vect(58, -1.5, 34)
        return
    if getCurrentMap() == Map.HORIZON_LUNAR_COLONY:
        PosStart = vect(-19.673, 3.925, -120.219)
        PosFinish = vect(19, 13, -45.5)
        return
    if getCurrentMap() == Map.PARIS:
        PosStart = vect(-87.011, 14.176, -104.458)
        PosFinish = vect(-14.4, 14, -35.75)
        return
    if getCurrentMap() == Map.TEMPLE_OF_ANUBIS:
        PosStart = vect(-11.096, 5.841, 110.46)
        PosFinish = vect(-1, -2, -9)
        return
    if getCurrentMap() == Map.VOLSKAYA:
        PosStart = vect(-92.538, 3.193, 59.543)
        PosFinish = vect(18, -4.5, 23)


rule  "Start - Escort":
	@Event global
    if getCurrentMap() == Map.DORADO:
        PosStart = vect(190.171, 15.273, 35.423)
        PosFinish = vect(12.5, 0, 6)
        return
    if getCurrentMap() == Map.HAVANA:
        PosStart = vect(138.376, 7.174, -34.025)
        PosFinish = vect(-98, 4, -93)
        return
    if getCurrentMap() == Map.JUNKERTOWN:
        PosStart = vect(-89.759, 7.613, -105.446)
        PosFinish = vect(-46.5, 9, -47.5)
        return
    if getCurrentMap() == Map.RIALTO:
        PosStart = vect(-65.683, 5.924, -144.738)
        PosFinish = vect(106.5, -1, -15.5)
        return
    if getCurrentMap() == Map.ROUTE66:
        PosStart = vect(-89.645, 7.686, -32.632)
        PosFinish = vect(38.5, 5.75, 36.5)
        return
    if getCurrentMap() == Map.WATCHPOINT_GIBRALTAR:
        PosStart = vect(65.011, 2.173, 47.639)
        PosFinish = vect(39, 4, -124.5)


rule  "Start - Hybrid":
	@Event global
    if getCurrentMap() == Map.BLIZZ_WORLD:
        PosStart = vect(-121.57, 0.774, 116.2)
        PosFinish = vect(3, 0, 21.5)
        return
    if getCurrentMap() == Map.EICHENWALDE:
        PosStart = vect(126.088, 15.941, -17.073)
        PosFinish = vect(2, 6, 0.5)
        return
    if getCurrentMap() == Map.HOLLYWOOD:
        PosStart = vect(-33.426, 2.925, -140.166)
        PosFinish = vect(-52, 0, 12.5)
        return
    if getCurrentMap() == Map.KINGS_ROW:
        PosStart = vect(-157.049, 1.248, 38.51)
        PosFinish = vect(-12, 0, 12.5)
        return
    if getCurrentMap() == Map.NUMBANI:
        PosStart = vect(201.699, 5.376, 38.253)
        PosFinish = vect(18, 0, 13)


rule  "Start - Control - Busan":
	@Event global
    @Condition getCurrentMap() == Map.BUSAN
    #Downtown
    if getCurrentObjective() == 0:
        PosStart = vect(-1.544, 17.108, -128.594)
        PosFinish = vect(99, 16, -125.5)
        return
    #MEKA Base
    if getCurrentObjective() == 2:            
        PosStart = vect(275.5, 10, 210.5)
        PosFinish = vect(165, 10, 255)
        return
    #Sanctuary
    if getCurrentObjective() == 1:
        PosStart = vect(-391.367, 10.529, 168.276)
        PosFinish = vect(-255.5, 9, 147)


rule  "Start - Control - Ilios":
	@Event global
    @Condition getCurrentMap() == Map.ILIOS
    #Lighthouse
    if getCurrentObjective() == 0:
        PosStart = vect(288.533, -24.394, -100.389)
        PosFinish = vect(329, -25, 22)
        return
    #Ruins
    if getCurrentObjective() == 2:
        PosStart = vect(-58.5, 60, -150)
        PosFinish = vect(112, 65.5, -178)
        return
    #Well
    if getCurrentObjective() == 1:
        PosStart = vect(-264.5, -5, 29.5)
        PosFinish = vect(-159, -5, -75.5)


rule  "Start - Control - Lijiang Tower":
	@Event global
    @Condition getCurrentMap() == Map.LIJIANG_TOWER
    #Control Tower
    if getCurrentObjective() == 2:
        PosStart = vect(-35.5, 267, 316.75)
        PosFinish = vect(44, 265, 327)
        return
    #Garden
    if getCurrentObjective() == 1:
        PosStart = vect(-65.211, 95.174, 145.476)
        PosFinish = vect(64.5, 94, 145.5)
        return
    #Night Market
    if getCurrentObjective() ==  0:
        PosStart = vect(-56.087, 3.037, -35.084)
        PosFinish = vect(61, 2, -34)


rule  "Start - Control - Nepal":
	@Event global
    @Condition getCurrentMap() == Map.NEPAL
    #Sanctum
    if getCurrentObjective() == 2:
        PosStart = vect(81, 132, -35.5)
        PosFinish = vect(81, 132, 36)
        return
    #Shrine
    if getCurrentObjective() == 1:
        PosStart = vect(-70.647, 16.889, -64.165)
        PosFinish = vect(-38.5, 15, 60)
        return
    #Village
    if getCurrentObjective() == 0:
        PosStart = vect(-184.744, -95.33, -75.548)
        PosFinish = vect(-191, -98, 60)


rule  "Start - Control - Oasis":
	@Event global
    @Condition getCurrentMap() == Map.OASIS
    #City Center
    if getCurrentObjective() == 0:
        PosStart = vect(211.712, 2.178, 203.561)
        PosFinish = vect(101, 1, 309.5)
        return
    #Gardens
    if getCurrentObjective() == 1:
        PosStart = vect(101.075, 9.177, -271.365)
        PosFinish = vect(182, 8, -223.5)
        return
    #University
    if getCurrentObjective() == 2:
        PosStart = vect(-187.904, 20.942, -69.197)
        PosFinish = vect(-188, 18, 50.5)


#Gamemode
rule "Start - Global":
    @Event global
    #Start / Checkpoint / Finish effects
    createEffect(getAllPlayers(), Effect.RING, Color.GREEN, PosStart, 2, EffectReeval.VISIBILITY)
    createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, Color.WHITE, PosFinish, 5, EffectReeval.VISIBILITY)
    createEffect(getAllPlayers(), Effect.RING, Color.WHITE, PosFinish, 5, EffectReeval.VISIBILITY)
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
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "- Your goal is to get from Start to Finish (white beam) as fast as you can.", PosExplanation + vect(5, 2, 0), 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.TURQUOISE, SpecVisibility.DEFAULT)
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "- Touching the ground results in you being resetted to the start.", PosExplanation + vect(5, 1.75, 0), 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.TURQUOISE, SpecVisibility.DEFAULT)
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "- Watch out for any additional info given to you by small and big messages and HUD.", PosExplanation + vect(5, 1.5, 0), 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.TURQUOISE, SpecVisibility.DEFAULT)
    #Features
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "Features:", PosExplanation + vect(cosDeg(60) * 5, 3, sinDeg(60) * 5), 3, Clip.NONE, WorldTextReeval.VISIBILITY, Color.LIME_GREEN, SpecVisibility.DEFAULT)
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "- Ult Reset: Resets you back to start.", PosExplanation + vect(cosDeg(60) * 5, 2.5, sinDeg(60) * 5), 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.TURQUOISE, SpecVisibility.DEFAULT)
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "- Auto Reset: Resets you when your current time is higher than your pb or the record.", PosExplanation + vect(cosDeg(60) * 5, 2.25, sinDeg(60) * 5), 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.TURQUOISE, SpecVisibility.DEFAULT)
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "- Route Preview: Short camera tour showing finish.", PosExplanation + vect(cosDeg(60) * 5, 2, sinDeg(60) * 5), 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.TURQUOISE, SpecVisibility.DEFAULT)
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "{0}\n{1}".format("- Practice Mode: Doesn't reset you when hitting the ground.","Let's you set checkpoints which preserve your velocity and facing direction."), PosExplanation + vect(cosDeg(60) * 5, 1.55, sinDeg(60) * 5), 2, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.TURQUOISE, SpecVisibility.DEFAULT)
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "- Player Spectator Mode: Let's you spectate Players.", PosExplanation + vect(cosDeg(60) * 5, 1.25, sinDeg(60) * 5), 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.TURQUOISE, SpecVisibility.DEFAULT)
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "- Spectator Mode: Let's you fly around the map spectating the game.", PosExplanation + vect(cosDeg(60) * 5, 1, sinDeg(60) * 5), 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.TURQUOISE, SpecVisibility.DEFAULT)
    #Resources
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "Resources:", PosExplanation + vect(cosDeg(-60) * 5, 3, sinDeg(-60) * 5), 3, Clip.NONE, WorldTextReeval.VISIBILITY, Color.LIME_GREEN, SpecVisibility.DEFAULT)
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "- Workshop Code: 1V0S0", PosExplanation + vect(cosDeg(-60) * 5, 2.5, sinDeg(-60) * 5), 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.TURQUOISE, SpecVisibility.DEFAULT)
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "- Surfing Discord: https://discord.gg/G9QBCDY", PosExplanation + vect(cosDeg(-60) * 5, 2.25, sinDeg(-60) * 5), 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.TURQUOISE, SpecVisibility.DEFAULT)
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "- Wallriding Discord: https://discord.gg/{0}".format(w"nfURYvy"), PosExplanation + vect(cosDeg(-60) * 5, 2, sinDeg(-60) * 5), 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.TURQUOISE, SpecVisibility.DEFAULT)
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "- Leaderboards: https://bit.ly/{0}".format(w"3cA3ClB"), PosExplanation + vect(cosDeg(-60) * 5, 1.75, sinDeg(-60) * 5), 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.TURQUOISE, SpecVisibility.DEFAULT)


rule "Start - Player":
    @Event eachPlayer
    @Condition eventPlayer.hasSpawned()
    createIcon(eventPlayer, PosFinish + vect(0, 6, 0), Icon.FLAG, IconReeval.VISIBILITY_AND_POSITION, Color.WHITE, true)
    hudHeader(eventPlayer, eventPlayer, HudPosition.LEFT, 0, Color.YELLOW, HudReeval.NONE, SpecVisibility.DEFAULT)
    eventPlayer.TimeBest = 9999
    eventPlayer.Finished = false
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
    eventPlayer.FacingCamera = PosFinish + vect(0, 5, 0)
    wait(1)
    chase(eventPlayer.PosCamera, PosFinish + vect(0, 5, 0), duration=5, ChaseReeval.NONE)
    wait(7)
    eventPlayer.stopCamera()
    eventPlayer.setMoveSpeed(100)
    StartPlayer()


rule  "Start timer":
	@Event eachPlayer
    @Condition eventPlayer.Mode == 0
    @Condition distance(PosStart, eventPlayer) > 2
    chase(eventPlayer.TimeCurrent, 5000, rate=1, ChaseReeval.NONE)
    if not Visible:
        return
    eventPlayer.setInvisibility(Invis.NONE)


rule "Finish":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 0
    @Condition not eventPlayer.Finished
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


rule  "Floor":
	@Event eachPlayer
    @Condition eventPlayer.Mode == 0
    @Condition eventPlayer.isOnGround()
    @Condition distance(PosStart, vect(eventPlayer.getPosition().x, PosStart.y, eventPlayer.getPosition().z)) > 4 and distance(PosFinish, vect(eventPlayer.getPosition().x, PosFinish.y, eventPlayer.getPosition().z)) > 6
    kill(eventPlayer, null)


rule  "Ult Reset":
	@Event eachPlayer
    @Condition eventPlayer.Mode == 0
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition distance(PosStart, vect(eventPlayer.getPosition().x, PosStart.y, eventPlayer.getPosition().z)) > 2
    kill(eventPlayer, null)


rule "Velocity Counter (red)":
    @Event eachPlayer
    @Condition eventPlayer.getHorizontalSpeed() <= 6.88
    @Condition eventPlayer.Spawned
    destroyHudText(getLastCreatedText())
    hudHeader(eventPlayer, l"{0} m/s".format(eventPlayer.getHorizontalSpeed()), HudPosition.TOP, 2, Color.RED, HudReeval.STRING)


rule "Velocity Counter (Orange)":
    @Event eachPlayer
    @Condition eventPlayer.getHorizontalSpeed() > 6.88 and eventPlayer.getHorizontalSpeed() < 11
    @Condition eventPlayer.Spawned
    destroyHudText(getLastCreatedText())
    hudHeader(eventPlayer, l"{0} m/s".format(eventPlayer.getHorizontalSpeed()), HudPosition.TOP, 2, Color.ORANGE, HudReeval.STRING)


rule "Velocity Counter (Yellow)":
    @Event eachPlayer
    @Condition eventPlayer.getHorizontalSpeed() >= 11 and eventPlayer.getHorizontalSpeed() < 13.75
    @Condition eventPlayer.Spawned
    destroyHudText(getLastCreatedText())
    hudHeader(eventPlayer, l"{0} m/s".format(eventPlayer.getHorizontalSpeed()), HudPosition.TOP, 2, Color.YELLOW, HudReeval.STRING)


rule "Velocity Counter (Green)":
    @Event eachPlayer
    @Condition eventPlayer.getHorizontalSpeed() >= 13.75
    @Condition eventPlayer.Spawned
    destroyHudText(getLastCreatedText())
    hudHeader(eventPlayer, l"{0} m/s".format(eventPlayer.getHorizontalSpeed()), HudPosition.TOP, 2, Color.GREEN, HudReeval.STRING)


rule  "Toggle Invisibility (Host only)":
	@Event eachPlayer
	@Condition eventPlayer.isCommunicating(Comms.NEED_HEALING) and eventPlayer == hostPlayer
    if Visible:
        smallMessage(eventPlayer, l"{0} {1}".format(l"Players", l"Invisible"))
        getAllPlayers().setInvisibility(Invis.ALL)
        Visible = false
        return
    smallMessage(eventPlayer, "{0} {1}".format(l"Players", l"Visible"))
    [player for player in getAllPlayers() if eventPlayer.Mode == 0 and distance(PosStart, player.getPosition()) > 2].setInvisibility(Invis.NONE)
    Visible = true


rule  "Toggle Help":
	@Event eachPlayer
	@Condition eventPlayer.isCommunicating(Comms.ULTIMATE_STATUS)
    if eventPlayer.HideHelp:
        eventPlayer.HideHelp = false
        return
    eventPlayer.HideHelp = true


rule  "Cycle Auto Reset":
	@Event eachPlayer
	@Condition eventPlayer.Mode == 0 and eventPlayer.isHoldingButton(Button.PRIMARY_FIRE)
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


rule  "Auto Reset (Personal Best)":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 0
    @Condition eventPlayer.AutoReset == 1
	@Condition eventPlayer.TimeCurrent > eventPlayer.TimeBest
    smallMessage(eventPlayer, "Reset by 'Auto Reset'")
    kill(eventPlayer, null)


rule  "Auto Reset (Record)":
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
    if not eventPlayer.isOnGround() or distance(PosStart, vect(eventPlayer.getPosition().x, PosStart.y, eventPlayer.getPosition().z)) <= 4 or distance(PosFinish, vect(eventPlayer.getPosition().x, PosFinish.y, eventPlayer.getPosition().z)) <= 6:
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
    eventPlayer.setMoveSpeed(250)
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
    if not eventPlayer.isOnGround() or distance(PosStart, vect(eventPlayer.getPosition().x, PosStart.y, eventPlayer.getPosition().z)) <= 4 or distance(PosFinish, vect(eventPlayer.getPosition().x, PosFinish.y, eventPlayer.getPosition().z)) <= 6:
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
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE)
    @Condition eventPlayer.Mode >= 7 and eventPlayer.Mode <= 9
    eventPlayer.setMoveSpeed(175)
    if eventPlayer.getHorizontalSpeed() <= 12.03:
        return
    eventPlayer.applyImpulse(eventPlayer.getVelocity() * -0.001, 1, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.applyImpulse(eventPlayer.getVelocity() * 1, 12.03, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)


rule "Spectator Mode (slow movement disabled)":
    @Event eachPlayer
    @Condition not eventPlayer.isHoldingButton(Button.SECONDARY_FIRE)
    @Condition eventPlayer.Mode >= 7 and eventPlayer.Mode <= 9
    eventPlayer.setMoveSpeed(250)


rule "Circle Fix":
    @Event eachPlayer
    @Condition distance(PosStart, eventPlayer) <= 2
    @Condition eventPlayer.getHorizontalSpeed() <= 6.88
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


