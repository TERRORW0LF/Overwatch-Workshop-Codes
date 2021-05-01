#Global variables

globalvar TimeFirst 0
globalvar TimeSecond 1
globalvar TimeThird 2
globalvar PlayerFirst 3
globalvar PlayerSecond 4
globalvar PlayerThird 5
globalvar Checkpoint 6
globalvar Visible 7
globalvar ForLoop 8
globalvar SizeTarget 9
globalvar HeightJumpPad 17
globalvar SpeedSpeedRing 18
globalvar PosJumpPad 19
globalvar PosSpeedRing 20
globalvar PosTarget 21
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
playervar Target 5
playervar AutoReset 6
playervar HideHelp 7
playervar Mode 8
playervar Attempts 9
playervar Spawned 10
playervar ForLoop 11
playervar IndexCheckpoint 12
playervar IndexJumpPad 13
playervar IndexSpeedRing 14
playervar IndexTarget 15
playervar StatusCheckpoint 16
playervar StatusTarget 17
playervar StatusTargetPreHit 18
playervar TargetDifference 19
playervar Temp 20
playervar TargetHitInUse 22
playervar PosPracticeCheckpoint 23
playervar FacingPracticeCheckpoint 24
playervar VelocityPracticeCheckpoint 25
playervar SpeedPracticeCheckpoint 26
playervar PosCamera 27
playervar FacingCamera 28


#Subroutines

subroutine StartPlayer 0
subroutine SpeedRing 1
subroutine TargetHit1 2
subroutine TargetHit2 3
subroutine TargetHit3 4
subroutine TargetHit4 5



#   INCORPORATE MULTIPLE TARGETHIT()
#   INCORPORATE STATUSTARGETPREHIT IN TARGETHIT()
#   RESET STATUSTARGETPREHIT IN "RESPAWN"



#Debug
rule "Debug (Global)":
	@Disabled
	@Event global


rule "Debug (Player)":
	@Disabled
	@Event eachPlayer
    hudHeader(eventPlayer, "Mode: {0}".format(eventPlayer.Mode), HudPosition.LEFT, -10, Color.WHITE, HudReeval.STRING)
    hudHeader(eventPlayer, "Checkpoints: {0}".format(len(PosCheckpoint)), HudPosition.LEFT, -9, Color.WHITE, HudReeval.STRING)
    hudHeader(eventPlayer, "Checkpoint: {0}".format(eventPlayer.Checkpoint), HudPosition.LEFT, -8, Color.WHITE, HudReeval.STRING)


#Subroutines
def StartPlayer():
    @Name "StartPlayer"
    hudSubtext(eventPlayer, "{0}\n{1}".format(l"{0}: {1}".format(l"Checkpoints", l"{0} / {1}".format(eventPlayer.Checkpoint, len(PosCheckpoint))), l"{0}: {1}".format(l"Targets", l"{0} / {1}".format(eventPlayer.Target, len(PosTarget)))), HudPosition.TOP, 4, Color.BLUE, HudReeval.STRING)
    hudHeader(eventPlayer, l"{0} sec".format(eventPlayer.TimeCurrent), HudPosition.TOP, 2, Color.WHITE, HudReeval.STRING, SpecVisibility.DEFAULT)
    hudHeader(eventPlayer, l"{0}: {1}".format(l"Best", l"{0} sec".format(eventPlayer.TimeBest)), HudPosition.LEFT, 1, Color.WHITE, HudReeval.STRING, SpecVisibility.DEFAULT)
    hudHeader(eventPlayer, l"{0}: {1}".format(l"Attempts", eventPlayer.Attempts), HudPosition.LEFT, 2, Color.WHITE, HudReeval.STRING, SpecVisibility.DEFAULT)
    createInWorldText(eventPlayer, l"{0} m".format(distance(PosFinish, eventPlayer)), PosFinish + vect(0, 5, 0), 2, Clip.NONE, WorldTextReeval.STRING, Color.WHITE, SpecVisibility.DEFAULT)
    if Checkpoint:
        goto loc+10-len(PosCheckpoint)
        createInWorldText(eventPlayer, l"{0} m".format(distance(PosCheckpoint[9], eventPlayer)), PosCheckpoint[9] + vect(0, 5, 0), 2, Clip.NONE, WorldTextReeval.STRING, Color.SKY_BLUE, SpecVisibility.DEFAULT)
        createInWorldText(eventPlayer, l"{0} m".format(distance(PosCheckpoint[8], eventPlayer)), PosCheckpoint[8] + vect(0, 5, 0), 2, Clip.NONE, WorldTextReeval.STRING, Color.SKY_BLUE, SpecVisibility.DEFAULT)
        createInWorldText(eventPlayer, l"{0} m".format(distance(PosCheckpoint[7], eventPlayer)), PosCheckpoint[7] + vect(0, 5, 0), 2, Clip.NONE, WorldTextReeval.STRING, Color.SKY_BLUE, SpecVisibility.DEFAULT)
        createInWorldText(eventPlayer, l"{0} m".format(distance(PosCheckpoint[6], eventPlayer)), PosCheckpoint[6] + vect(0, 5, 0), 2, Clip.NONE, WorldTextReeval.STRING, Color.SKY_BLUE, SpecVisibility.DEFAULT)
        createInWorldText(eventPlayer, l"{0} m".format(distance(PosCheckpoint[5], eventPlayer)), PosCheckpoint[5] + vect(0, 5, 0), 2, Clip.NONE, WorldTextReeval.STRING, Color.SKY_BLUE, SpecVisibility.DEFAULT)
        createInWorldText(eventPlayer, l"{0} m".format(distance(PosCheckpoint[4], eventPlayer)), PosCheckpoint[4] + vect(0, 5, 0), 2, Clip.NONE, WorldTextReeval.STRING, Color.SKY_BLUE, SpecVisibility.DEFAULT)
        createInWorldText(eventPlayer, l"{0} m".format(distance(PosCheckpoint[3], eventPlayer)), PosCheckpoint[3] + vect(0, 5, 0), 2, Clip.NONE, WorldTextReeval.STRING, Color.SKY_BLUE, SpecVisibility.DEFAULT)
        createInWorldText(eventPlayer, l"{0} m".format(distance(PosCheckpoint[2], eventPlayer)), PosCheckpoint[2] + vect(0, 5, 0), 2, Clip.NONE, WorldTextReeval.STRING, Color.SKY_BLUE, SpecVisibility.DEFAULT)
        createInWorldText(eventPlayer, l"{0} m".format(distance(PosCheckpoint[1], eventPlayer)), PosCheckpoint[1] + vect(0, 5, 0), 2, Clip.NONE, WorldTextReeval.STRING, Color.SKY_BLUE, SpecVisibility.DEFAULT)
        createInWorldText(eventPlayer, l"{0} m".format(distance(PosCheckpoint[0], eventPlayer)), PosCheckpoint[0] + vect(0, 5, 0), 2, Clip.NONE, WorldTextReeval.STRING, Color.SKY_BLUE, SpecVisibility.DEFAULT)
    wait()
    hudHeader(eventPlayer, l"{0} m/s".format(eventPlayer.getHorizontalSpeed()), HudPosition.TOP, 1, Color.RED, HudReeval.STRING, SpecVisibility.DEFAULT)
    eventPlayer.Mode = 0
    eventPlayer.Spawned = true
    eventPlayer.allowButton(Button.PRIMARY_FIRE)
    eventPlayer.clearStatusEffect(Status.ROOTED)
    eventPlayer.setGravity(100)
    eventPlayer.setMoveSpeed(100)
    kill(eventPlayer, null)


def SpeedRing():
    @Name "Speed Ring"
    if SpeedSpeedRing[1]:
        eventPlayer.IndexSpeedRing = PosSpeedRing.index([ring for ring in PosSpeedRing if distance(ring, eventPlayer.getPosition()) < 3])
        eventPlayer.applyImpulse(10*eventPlayer.getVelocity(), SpeedSpeedRing[eventPlayer.IndexSpeedRing]*eventPlayer.getHorizontalSpeed(), Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
        eventPlayer.setMoveSpeed(100*SpeedSpeedRing[eventPlayer.IndexSpeedRing])
    else:
        eventPlayer.applyImpulse(10*eventPlayer.getVelocity(), SpeedSpeedRing*eventPlayer.getHorizontalSpeed(), Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
        eventPlayer.setMoveSpeed(100*SpeedSpeedRing)
    wait(0.5)
    eventPlayer.setMoveSpeed(100)


def TargetHit1():
    @Name "Player Hit Target (bullet 1)"
    eventPlayer.Temp[0] = eventPlayer.IndexTarget
    wait(1/50*distance(eventPlayer.getEyePosition(), PosTarget[eventPlayer.Temp[0]]))
    if not eventPlayer.StatusTargetPreHit[0]:
        return
    eventPlayer.StatusTarget[eventPlayer.Temp[0]] = true
    eventPlayer.Target++
    playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer.getPosition(), 200)
    smallMessage(eventPlayer, l"{0}: {1}".format(l"{0} {1}".format(l"Targets", l"Hit"), l"{0} / {1}".format(eventPlayer.Target, len(PosTarget))))
    eventPlayer.TargetHitInUse[0] = false


def TargetHit2():
    @Name "Player Hit Target (bullet 2)"
    eventPlayer.Temp[1] = eventPlayer.IndexTarget
    wait(1/50*distance(eventPlayer.getEyePosition(), PosTarget[eventPlayer.Temp[1]]))
    if not eventPlayer.StatusTargetPreHit[1]:
        return
    playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer.getPosition(), 200)
    eventPlayer.StatusTarget[eventPlayer.Temp[1]] = true
    eventPlayer.Target++
    smallMessage(eventPlayer, l"{0}: {1}".format(l"{0} {1}".format(l"Targets", l"Hit"), l"{0} / {1}".format(eventPlayer.Target, len(PosTarget))))
    eventPlayer.TargetHitInUse[1] = false


def TargetHit3():
    @Name "Player Hit Target (bullet 3)"
    eventPlayer.Temp[2] = eventPlayer.IndexTarget
    wait(1/50*distance(eventPlayer.getEyePosition(), PosTarget[eventPlayer.Temp[2]]))
    if not eventPlayer.StatusTargetPreHit[2]:
        return
    playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer.getPosition(), 200)
    eventPlayer.StatusTarget[eventPlayer.Temp[2]] = true
    eventPlayer.Target++
    smallMessage(eventPlayer, l"{0}: {1}".format(l"{0} {1}".format(l"Targets", l"Hit"), l"{0} / {1}".format(eventPlayer.Target, len(PosTarget))))
    eventPlayer.TargetHitInUse[2] = false


def TargetHit4():
    @Name "Player Hit Target (bullet 4)"
    eventPlayer.Temp[3] = eventPlayer.IndexTarget
    wait(1/50*distance(eventPlayer.getEyePosition(), PosTarget[eventPlayer.Temp[3]]))
    if not eventPlayer.StatusTargetPreHit[3]:
        return
    playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer.getPosition(), 200)
    eventPlayer.StatusTarget[eventPlayer.Temp[3]] = true
    eventPlayer.Target++
    smallMessage(eventPlayer, l"{0}: {1}".format(l"{0} {1}".format(l"Targets", l"Hit"), l"{0} / {1}".format(eventPlayer.Target, len(PosTarget))))
    eventPlayer.TargetHitInUse[3] = false


#Maps
rule "Start - Assault - Every Map Is In Order (a - z)":
    @Event global
    HeightJumpPad = 18
    SpeedSpeedRing = 1.2
    SizeTarget = [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5]
    if getCurrentMap() == Map.HANAMURA:
        PosJumpPad = []
        PosSpeedRing = []
        PosTarget = []
        PosStart = vect(85.867, -1.847, 16.524)
        PosCheckpoint = [vect(64.123, -3.111, 84.188)]
        PosFinish = vect(30.542, 2.173, 40.845)
        Checkpoint = true
        return
    if getCurrentMap() == Map.HORIZON_LUNAR_COLONY:
        PosJumpPad = []
        PosSpeedRing = []
        PosTarget = []
        PosStart = vect(-38.253, 10.174, -122.811)
        PosCheckpoint = [vect(43.183, 14.173, -77.129)]
        PosFinish = vect(25.671, 7.174, -15.62)
        Checkpoint = true
        return
    if getCurrentMap() == Map.PARIS:
        PosJumpPad = []
        PosSpeedRing = []
        PosTarget = []
        PosStart = vect(-119.964, 10.036, -51.908)
        PosCheckpoint = [vect(-44.044, 11.232, -33.258)]
        PosFinish = vect(15.807, 10.1, -57.496)
        Checkpoint = true
        return
    if getCurrentMap() == Map.TEMPLE_OF_ANUBIS:
        PosJumpPad = []
        PosSpeedRing = []
        PosTarget = []
        PosStart = vect(9.122, 5.587, 124.801)
        PosCheckpoint = [vect(0, 0, 0)]
        PosFinish = vect(14.464, 10.246, 12.459)
        Checkpoint = false
        return
    if getCurrentMap() == Map.VOLSKAYA:
        PosJumpPad = []
        PosSpeedRing = []
        PosTarget = []
        PosStart = vect(-96.722, -2.303, 24.146)
        PosCheckpoint = [vect(-37.356, 2.194, 98.043)]
        PosFinish = vect(-30.133, 2.294, 38.232)
        Checkpoint = true


rule "Start - Escort":
    @Event global
    if getCurrentMap() == Map.DORADO:
        PosJumpPad = []
        PosSpeedRing = []
        PosTarget = []
        PosStart = vect(62.246, 13.594, 21.758)
        PosCheckpoint = [vect(117.076, 18.107, 5.438)]
        PosFinish = vect(26.047, 5.274, -41.35)
        Checkpoint = true
        return
    if getCurrentMap() == Map.HAVANA:
        PosJumpPad = []
        PosSpeedRing = []
        PosTarget = []
        PosStart = vect(-107.317, 4.173, -59.178)
        PosCheckpoint = [vect(0, 0, 0)]
        PosFinish = vect(65.054, 12.174, -83.635)
        Checkpoint = false
        return
    if getCurrentMap() == Map.JUNKERTOWN:
        PosJumpPad = []
        PosSpeedRing = []
        PosTarget = []
        PosStart = vect(-49.399, 9.662, -42.145)
        PosCheckpoint = [vect(-46.378, 19.653, -90.257)]
        PosFinish = vect(40.235, 9.176, -51.024)
        Checkpoint = true
        return
    if getCurrentMap() == Map.RIALTO:
        PosJumpPad = []
        PosSpeedRing = []
        PosTarget = []
        PosStart = vect(-31.663, 1.924, -115.564)
        PosCheckpoint = [vect(0, 0, 0)]
        PosFinish = vect(160.704, -3.678, -62.886)
        Checkpoint = false
        return
    if getCurrentMap() == Map.ROUTE66:
        PosJumpPad = []
        PosSpeedRing = []
        PosTarget = []
        PosStart = vect(71.704, 0.114, 11.87)
        PosCheckpoint = [vect(-42.605, 3.614, 5.206)]
        PosFinish = vect(-100.763, 8.673, 8.128)
        Checkpoint = true
        return
    if getCurrentMap() == Map.WATCHPOINT_GIBRALTAR:
        PosJumpPad = []
        PosSpeedRing = []
        PosTarget = []
        PosStart = vect(83.581, 3.21, -31.786)
        PosCheckpoint = [vect(66.186, -1.827, -114.804)]
        PosFinish = vect(22.688, -5.9, -159.187)
        Checkpoint = true


rule "Start - Hybrid":
    @Event global
    if getCurrentMap() == Map.BLIZZ_WORLD:
        PosJumpPad = []
        PosSpeedRing = []
        PosTarget = []
        PosStart = vect(52.118, -1.362, -7.795)
        PosCheckpoint = [vect(53.816, -5.205, -87.717)]
        PosFinish = vect(-57.568, -3.929, -5.401)
        Checkpoint = true
        return
    if getCurrentMap() == Map.EICHENWALDE:
        PosJumpPad = []
        PosSpeedRing = []
        PosTarget = []
        PosStart = vect(2.656, 7.176, 0.346)
        PosCheckpoint = [vect(31.753, 14.173, -79.386)]
        PosFinish = vect(83.903, 12.856, -87.977)
        Checkpoint = true
        return
    if getCurrentMap() == Map.HOLLYWOOD:
        PosJumpPad = []
        PosSpeedRing = []
        PosTarget = []
        PosStart = vect(-25.875, 1.924, 21.201)
        PosCheckpoint = [vect(12.661, 1.923, -86.28)]
        PosFinish = vect(-38.232, 9.923, -116.867)
        Checkpoint = true
        return
    if getCurrentMap() == Map.KINGS_ROW:
        PosJumpPad = []
        PosSpeedRing = []
        PosTarget = []
        PosStart = vect(4.83, 7.175, -1.205)
        PosCheckpoint = [vect(-83.851, 0.682, 4.438)]
        PosFinish = vect(-118.429, -1.208, 24.984)
        Checkpoint = true
        return
    if getCurrentMap() == Map.NUMBANI:
        PosJumpPad = []
        PosSpeedRing = []
        PosTarget = []
        PosStart = vect(144.571, 2.424, 29.313)
        PosCheckpoint = [vect(49.435, 4.372, -6.419)]
        PosFinish = vect(163.628, 4.551, -0.052)
        Checkpoint = true


rule "Start - Control - Busan":
    @Event global
    @Condition getCurrentMap() == Map.BUSAN
    #Downtown
    if getCurrentObjective() == 0:
        PosJumpPad = []
        PosSpeedRing = []
        PosTarget = []
        PosStart = vect(84.198, 15.173, -142.989)
        PosCheckpoint = [vect(22.583, 8.173, -81.736)]
        PosFinish = vect(-12.436, 16.173, -117.693)
        Checkpoint = true
        return
    #MEKA Base
    if getCurrentObjective() == 2:
        PosJumpPad = []
        PosSpeedRing = []
        PosTarget = []
        PosStart = vect(165.682, 10.268, 271.056)
        PosCheckpoint = [vect(0, 0, 0)]
        PosFinish = vect(247.878, 13.269, 199.614)
        Checkpoint = false
        return
    #Sanctuary
    if getCurrentObjective() == 1:
        PosJumpPad = []
        PosSpeedRing = []
        PosTarget = []
        PosStart = vect(-284.514, 12.224, 174.822)
        PosCheckpoint = [vect(-382.463, 9.223, 138.889)]
        PosFinish = vect(-271.677, 10.456, 137.999)
        Checkpoint = true


rule "Start - Control - Ilios":
    @Event global
    @Condition getCurrentMap() == Map.ILIOS
    #Lighthouse
    if getCurrentObjective() == 0:
        PosJumpPad = []
        PosSpeedRing = []
        PosTarget = []
        PosStart = vect(284.738, -17.767, -75.819)
        PosCheckpoint = [vect(363.517, -18.172, -53.426)]
        PosFinish = vect(336.947, -24.402, 22.725)
        Checkpoint = true
        return
    #Ruins
    if getCurrentObjective() == 2:
        PosJumpPad = []
        PosSpeedRing = []
        PosTarget = []
        PosStart = vect(111.647, 66.563, -177.77)
        PosCheckpoint = [vect(28.446, 61.562, -143.87)]
        PosFinish = vect(-55.178, 65.562, -178.229)
        Checkpoint = true
        return
    #Well
    if getCurrentObjective() == 1:
        PosJumpPad = []
        PosSpeedRing = []
        PosTarget = []
        PosStart = vect(-258.986, -1.673, 48.481)
        PosCheckpoint = [vect(-224.969, 5.51, -33.21)]
        PosFinish = vect(-141.105, 13.206, -87.497)
        Checkpoint = true


rule "Start - Control - Lijiang Tower":
    @Event global
    @Condition getCurrentMap() == Map.LIJIANG_TOWER
    #Control Tower
    if getCurrentObjective() == 2:
        PosJumpPad = []
        PosSpeedRing = []
        PosTarget = []
        PosStart = vect(-26.497, 270.173, 340.286)
        PosCheckpoint = [vect(10.656, 270.173, 261.943)]
        PosFinish = vect(27.763, 270.173, 355.578)
        Checkpoint = true
        return
    #Garden
    if getCurrentObjective() == 1:
        PosJumpPad = []
        PosSpeedRing = []
        PosTarget = []
        PosStart = vect(61.321, 98.173, 161.408)
        PosCheckpoint = [vect(-0.067, 96.173, 107.872)]
        PosFinish = vect(-68.698, 98.173, 163.209)
        Checkpoint = true
        return
    #Night Market
    if getCurrentObjective() == 0:
        PosJumpPad = []
        PosSpeedRing = []
        PosTarget = []
        PosStart = vect(61.03, 6.174, -10.232)
        PosCheckpoint = [vect(1.479, -0.673, -59.482)]
        PosFinish = vect(-58.911, 6.173, -10.302)
        Checkpoint = true


rule "Start - Control - Nepal":
    @Event global
    @Condition getCurrentMap() == Map.NEPAL
    #Sanctum
    if getCurrentObjective() == 2:
        PosJumpPad = []
        PosSpeedRing = []
        PosTarget = []
        PosStart = vect(107.495, 133.277, -73.174)
        PosCheckpoint = [vect(55.295, 129.981, 0.52)]
        PosFinish = vect(102.618, 136.173, 78.165)
        Checkpoint = true
        return
    #Shrine
    if getCurrentObjective() == 1:
        PosJumpPad = []
        PosSpeedRing = []
        PosTarget = []
        PosStart = vect(-22.294, 22.173, 76.936)
        PosCheckpoint = [vect(0, 0, 0)]
        PosFinish = vect(-50.994, 15.16, -77.311)
        Checkpoint = false
        return
    #Village
    if getCurrentObjective() == 0:
        PosJumpPad = []
        PosSpeedRing = []
        PosTarget = []
        PosStart = vect(-168.653, -97.361, -48.431)
        PosCheckpoint = [vect(-221.123, -88.032, 0.323)]
        PosFinish = vect(-147.782, -91.897, 62.105)
        Checkpoint = true


rule "Start - Control - Oasis":
    @Event global
    @Condition getCurrentMap() == Map.OASIS
    #City Center
    if getCurrentObjective() == 0:
        PosJumpPad = []
        PosSpeedRing = []
        PosTarget = []
        PosStart = vect(84.599, 2.177, 298.498)
        PosCheckpoint = [vect(157.26, 4.174, 264.225)]
        PosFinish = vect(157.23, 1.176, 205.119)
        Checkpoint = true
        return
    #Gardens
    if getCurrentObjective() == 1:
        PosJumpPad = []
        PosSpeedRing = []
        PosTarget = []
        PosStart = vect(73.282, 7.673, -285.746)
        PosCheckpoint = [vect(0, 0, 0)]
        PosFinish = vect(155.223, 10.178, -186.502)
        Checkpoint = false
        return
    #University
    if getCurrentObjective() == 2:
        PosJumpPad = []
        PosSpeedRing = []
        PosTarget = []
        PosStart = vect(-208.867, 20.506, -71.688)
        PosCheckpoint = [vect(-172.403, 17.173, 2.078)]
        PosFinish = vect(-188.53, 18.173, 60.728)
        Checkpoint = true


#Gamemode
rule "Start - Global":
    @Event global
    #Targets / JumpPad / SpeedRing / Start / Checkpoint / Finish effects
    goto loc+20-(len(PosTarget)*2)
    createEffect([player for player in getAllPlayers() if not player.StatusTarget[9]], Effect.SPHERE, Color.RED, PosTarget[9], SizeTarget[9], EffectReeval.VISIBILITY)
    createEffect([player for player in getAllPlayers() if player.StatusTarget[9]], Effect.SPHERE, Color.GREEN, PosTarget[9], SizeTarget[9], EffectReeval.VISIBILITY)
    createEffect([player for player in getAllPlayers() if not player.StatusTarget[8]], Effect.SPHERE, Color.RED, PosTarget[8], SizeTarget[8], EffectReeval.VISIBILITY)
    createEffect([player for player in getAllPlayers() if player.StatusTarget[8]], Effect.SPHERE, Color.GREEN, PosTarget[8], SizeTarget[8], EffectReeval.VISIBILITY)
    createEffect([player for player in getAllPlayers() if not player.StatusTarget[7]], Effect.SPHERE, Color.RED, PosTarget[7], SizeTarget[7], EffectReeval.VISIBILITY)
    createEffect([player for player in getAllPlayers() if player.StatusTarget[7]], Effect.SPHERE, Color.GREEN, PosTarget[7], SizeTarget[7], EffectReeval.VISIBILITY)
    createEffect([player for player in getAllPlayers() if not player.StatusTarget[6]], Effect.SPHERE, Color.RED, PosTarget[6], SizeTarget[6], EffectReeval.VISIBILITY)
    createEffect([player for player in getAllPlayers() if player.StatusTarget[6]], Effect.SPHERE, Color.GREEN, PosTarget[6], SizeTarget[6], EffectReeval.VISIBILITY)
    createEffect([player for player in getAllPlayers() if not player.StatusTarget[5]], Effect.SPHERE, Color.RED, PosTarget[5], SizeTarget[5], EffectReeval.VISIBILITY)
    createEffect([player for player in getAllPlayers() if player.StatusTarget[5]], Effect.SPHERE, Color.GREEN, PosTarget[5], SizeTarget[5], EffectReeval.VISIBILITY)
    createEffect([player for player in getAllPlayers() if not player.StatusTarget[4]], Effect.SPHERE, Color.RED, PosTarget[4], SizeTarget[4], EffectReeval.VISIBILITY)
    createEffect([player for player in getAllPlayers() if player.StatusTarget[4]], Effect.SPHERE, Color.GREEN, PosTarget[4], SizeTarget[4], EffectReeval.VISIBILITY)
    createEffect([player for player in getAllPlayers() if not player.StatusTarget[3]], Effect.SPHERE, Color.RED, PosTarget[3], SizeTarget[3], EffectReeval.VISIBILITY)
    createEffect([player for player in getAllPlayers() if player.StatusTarget[3]], Effect.SPHERE, Color.GREEN, PosTarget[3], SizeTarget[3], EffectReeval.VISIBILITY)
    createEffect([player for player in getAllPlayers() if not player.StatusTarget[2]], Effect.SPHERE, Color.RED, PosTarget[2], SizeTarget[2], EffectReeval.VISIBILITY)
    createEffect([player for player in getAllPlayers() if player.StatusTarget[2]], Effect.SPHERE, Color.GREEN, PosTarget[2], SizeTarget[2], EffectReeval.VISIBILITY)
    createEffect([player for player in getAllPlayers() if not player.StatusTarget[1]], Effect.SPHERE, Color.RED, PosTarget[1], SizeTarget[1], EffectReeval.VISIBILITY)
    createEffect([player for player in getAllPlayers() if player.StatusTarget[1]], Effect.SPHERE, Color.GREEN, PosTarget[1], SizeTarget[1], EffectReeval.VISIBILITY)
    createEffect([player for player in getAllPlayers() if not player.StatusTarget[0]], Effect.SPHERE, Color.RED, PosTarget[0], SizeTarget[0], EffectReeval.VISIBILITY)
    createEffect([player for player in getAllPlayers() if player.StatusTarget[0]], Effect.SPHERE, Color.GREEN, PosTarget[0], SizeTarget[0], EffectReeval.VISIBILITY)
    for ForLoop in range(0, len(PosJumpPad), 1):
        createEffect(getAllPlayers(), Effect.RING, Color.BLUE, PosJumpPad[ForLoop], 3, EffectReeval.VISIBILITY)
    for ForLoop in range(0, len(PosSpeedRing), 1):
        createEffect(getAllPlayers(), Effect.GOOD_AURA, Color.GREEN, PosSpeedRing[ForLoop], 3, EffectReeval.VISIBILITY)
    createEffect(getAllPlayers(), Effect.RING, Color.GREEN, PosStart, 2, EffectReeval.VISIBILITY)
    createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, Color.WHITE, PosFinish, 5, EffectReeval.VISIBILITY)
    createEffect(getAllPlayers(), Effect.RING, Color.WHITE, PosFinish, 5, EffectReeval.VISIBILITY)
    createIcon(getAllPlayers(), PosFinish + vect(0, 6, 0), Icon.FLAG, IconReeval.VISIBILITY, Color.WHITE, true)
    if Checkpoint:
        for ForLoop in range(0, len(PosCheckpoint), 1):    
            createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, Color.SKY_BLUE, PosCheckpoint[ForLoop], 3.5, EffectReeval.VISIBILITY)
            createEffect(getAllPlayers(), Effect.RING, Color.SKY_BLUE, PosCheckpoint[ForLoop], 3.5, EffectReeval.VISIBILITY)
            createIcon(getAllPlayers(), PosCheckpoint[ForLoop] + vect(0, 6, 0), Icon.ARROW_DOWN, IconReeval.VISIBILITY, Color.SKY_BLUE, true)
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
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "- Workshop Code: KFWF0", PosExplanation + vect(cosDeg(-60) * 5, 2.5, sinDeg(-60) * 5), 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.TURQUOISE, SpecVisibility.DEFAULT)
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "- Surfing Discord: https://discord.gg/G9QBCDY", PosExplanation + vect(cosDeg(-60) * 5, 2.25, sinDeg(-60) * 5), 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.TURQUOISE, SpecVisibility.DEFAULT)
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "- Wallriding Discord: https://discord.gg/{0}".format(w"nfURYvy"), PosExplanation + vect(cosDeg(-60) * 5, 2, sinDeg(-60) * 5), 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.TURQUOISE, SpecVisibility.DEFAULT)
    createInWorldText([player for player in getAllPlayers() if player.Mode == -1], "- Leaderboards: https://bit.ly/{0}".format(w"2XyaN9D"), PosExplanation + vect(cosDeg(-60) * 5, 1.75, sinDeg(-60) * 5), 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.TURQUOISE, SpecVisibility.DEFAULT)


rule "Start - Player":
    @Event eachPlayer
    @Condition eventPlayer.hasSpawned()
    hudHeader(eventPlayer, eventPlayer, HudPosition.LEFT, 0, Color.YELLOW, HudReeval.NONE, SpecVisibility.DEFAULT)
    eventPlayer.TimeBest = 9999
    eventPlayer.Finished = false
    eventPlayer.Checkpoint = 0
    eventPlayer.Target = 0
    eventPlayer.StatusCheckpoint = []
    eventPlayer.Temp = [0, 0, 0, 0]
    eventPlayer.TargetHitInUse = [false, false, false, false]
    for eventPlayer.ForLoop in range(0, len(PosCheckpoint), 1):
        eventPlayer.StatusCheckpoint.append(false)
    eventPlayer.StatusTarget = []
    for eventPlayer.ForLoop in range(0, len(PosTarget), 1):
        eventPlayer.StatusTarget.append(false)
    eventPlayer.Mode = -1
    eventPlayer.Attempts = -1
    eventPlayer.enableDeathSpectateAllPlayers()
    eventPlayer.enableDeathSpectateTargetHud()
    eventPlayer.disallowButton(Button.PRIMARY_FIRE)
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
    if Checkpoint:
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
    @Condition distance(PosStart, vect(eventPlayer.getPosition().x, PosStart.y, eventPlayer.getPosition().z)) > 2 or (distance(PosStart, vect(eventPlayer.getPosition().x, PosStart.y, eventPlayer.getPosition().z)) < 2 and not eventPlayer.isOnGround())
    chase(eventPlayer.TimeCurrent, 5000, rate=1, ChaseReeval.NONE)
    eventPlayer.allowButton(Button.PRIMARY_FIRE)
    if not Visible:
        return
    eventPlayer.setInvisibility(Invis.NONE)


rule "Checkpoint":
	@Event eachPlayer
    @Condition Checkpoint
    @Condition not eventPlayer.Finished
    @Condition eventPlayer.Mode == 0
    @Condition any([distance(checkpoint, vect(eventPlayer.getPosition().x, checkpoint.y, eventPlayer.getPosition().z)) <= 3.5 and isInLoS(eventPlayer.getPosition(), vect(eventPlayer.getPosition().x, checkpoint.y, eventPlayer.getPosition().z), BarrierLos.PASS_THROUGH_BARRIERS) and eventPlayer.getEyePosition().y >= checkpoint.y for checkpoint in PosCheckpoint])
    @Condition eventPlayer.TimeCurrent > 1
    #Get Index to check for other conditions
    eventPlayer.IndexCheckpoint = PosCheckpoint.index([checkpoint for checkpoint in PosCheckpoint if distance(checkpoint, vect(eventPlayer.getEyePosition().x, checkpoint.y, eventPlayer.getPosition().z)) <= 3.5])
    #Check extra conditions
    if eventPlayer.StatusCheckpoint[eventPlayer.IndexCheckpoint]:
        smallMessage(eventPlayer, "Checkpoint already collected")
        return
    eventPlayer.Checkpoint += 1
    eventPlayer.StatusCheckpoint[eventPlayer.IndexCheckpoint] = true
    playEffect(eventPlayer, DynamicEffect.DEBUFF_IMPACT_SOUND, Color.WHITE, eventPlayer.getPosition(), 200)
    bigMessage(eventPlayer, eventPlayer.TimeCurrent)
    if eventPlayer.Checkpoint == len(PosCheckpoint):
        smallMessage(eventPlayer, l"{0} {1}".format(l"Finish", l"Unlocked"))
        return
    smallMessage(eventPlayer, l"{0} {1}".format(l"Checkpoints", l"{0} / {1}".format(eventPlayer.Checkpoint, len(PosCheckpoint))))


rule "Checkpoint (no LoS)":
    @Event eachPlayer
    @Condition Checkpoint
    @Condition not eventPlayer.Finished
    @Condition eventPlayer.Mode == 0
    @Condition any([distance(checkpointArray, vect(eventPlayer.getPosition().x, checkpointArray.y, eventPlayer.getPosition().z)) <= 3.5 and (not isInLoS(eventPlayer.getPosition(), vect(eventPlayer.getPosition().x, checkpointArray.y, eventPlayer.getPosition().z), BarrierLos.PASS_THROUGH_BARRIERS) or eventPlayer.getEyePosition().y < checkpointArray.y) for checkpointArray in PosCheckpoint])
    smallMessage(eventPlayer, l"{0} {1}".format(l"Checkpoint", l"Out of View"))


rule "Finish":
	@Event eachPlayer
    @Condition not Checkpoint or eventPlayer.Checkpoint == len(PosCheckpoint)
    @Condition not eventPlayer.Finished
    @Condition eventPlayer.Mode == 0
    @Condition distance(PosFinish, vect(eventPlayer.getPosition().x, PosFinish.y, eventPlayer.getPosition().z)) <= 5
    @Condition isInLoS(eventPlayer.getPosition(), vect(eventPlayer.getPosition().x, PosFinish.y, eventPlayer.getPosition().z), BarrierLos.PASS_THROUGH_BARRIERS)
    @Condition eventPlayer.getEyePosition().y >= PosFinish.y
    stopChasingVariable(eventPlayer.TimeCurrent)
    if eventPlayer.TimeCurrent <= 1:
        return
    if len(PosTarget) - eventPlayer.Target:
        eventPlayer.TimeCurrent += (len(PosTarget) - eventPlayer.Target)/2
        smallMessage(eventPlayer, "Missed {0} Targets - Added {1} secs to your time.".format(len(PosTarget) - eventPlayer.Target, (len(PosTarget) - eventPlayer.Target)/2))
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


rule "Finish (no LoS)":
	@Event eachPlayer
    @Condition not eventPlayer.Finished
    @Condition eventPlayer.Mode == 0
    @Condition distance(PosFinish, vect(eventPlayer.getPosition().x, PosFinish.y, eventPlayer.getPosition().z)) <= 5
    @Condition not isInLoS(eventPlayer.getPosition(), vect(eventPlayer.getPosition().x, PosFinish.y, eventPlayer.getPosition().z), BarrierLos.PASS_THROUGH_BARRIERS) or eventPlayer.getEyePosition().y < PosFinish.y
    @Condition eventPlayer.TimeCurrent > 1
    smallMessage(eventPlayer, l"{0} {1}".format(l"Finish", l"Out of View"))


rule "Finish (no Checkpoint)":
	@Event eachPlayer
    @Condition Checkpoint
    @Condition eventPlayer.Checkpoint != len(PosCheckpoint)
    @Condition not eventPlayer.Finished
    @Condition eventPlayer.Mode == 0
    @Condition distance(PosFinish, vect(eventPlayer.getPosition().x, PosFinish.y, eventPlayer.getPosition().z)) <= 5
    @Condition eventPlayer.TimeCurrent > 1
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


rule "Jump Pads":
    @Event eachPlayer
    @Condition eventPlayer.isOnGround()
    @Condition any([distance(pad, vect(eventPlayer.getPosition().x, pad.y, eventPlayer.getPosition().z)) <= 3 for pad in PosJumpPad])
    if HeightJumpPad[1]:
        eventPlayer.IndexJumpPad = PosJumpPad.index([pad for pad in PosJumpPad if distance(pad, vect(eventPlayer.getPosition().x, pad.y, eventPlayer.getPosition().z)) <= 3])
        eventPlayer.applyImpulse(Vector.UP, HeightJumpPad[eventPlayer.IndexJumpPad], Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
        return
    eventPlayer.applyImpulse(Vector.UP, HeightJumpPad, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)


rule "Speed Rings":
    @Event eachPlayer
    @Condition any([distance(ring, eventPlayer.getPosition()) < 3 for ring in PosSpeedRing])
    async(SpeedRing(), AsyncBehavior.RESTART)

    
rule "Targets":
    @Event eachPlayer
    @Condition eventPlayer.isFiringPrimaryFire()
    @Condition eventPlayer.Mode >= 0 and eventPlayer.Mode <= 3
    for eventPlayer.ForLoop in range(0, 4):
        eventPlayer.IndexTarget = PosTarget.index(sorted([targethit for targethit in PosTarget if distance(targethit, raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection()*distance(eventPlayer.getEyePosition(), targethit), null, eventPlayer, false).getHitPosition()) <= SizeTarget and not eventPlayer.StatusTargetPreHit[PosTarget.index(targethit)]], lambda target: distance(eventPlayer.getEyePosition(), target)))
        if eventPlayer.IndexTarget == -1 or distance(PosTarget[eventPlayer.IndexTarget], raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * distance(eventPlayer.getEyePosition(), PosTarget[eventPlayer.IndexTarget]), null, eventPlayer, false).getHitPosition()) > 2:
            wait(0.125, Wait.ABORT_WHEN_FALSE)
            continue
        eventPlayer.StatusTargetPreHit[eventPlayer.IndexTarget] = true
        if not eventPlayer.TargetHitInUse[0]:
            eventPlayer.TargetHitInUse[0] = true
            async(TargetHit1(), AsyncBehavior.NOOP)
        elif not eventPlayer.TargetHitInUse[1]:
            eventPlayer.TargetHitInUse[1] = true
            async(TargetHit2(), AsyncBehavior.NOOP)
        elif not eventPlayer.TargetHitInUse[2]:
            eventPlayer.TargetHitInUse[2] = true
            async(TargetHit3(), AsyncBehavior.NOOP)
        elif not eventPlayer.TargetHitInUse[3]:
            eventPlayer.TargetHitInUse[3] = true
            async(TargetHit4(), AsyncBehavior.NOOP)
        else:
            eventPlayer.TargetHitInUse[0] = true
            async(TargetHit1(), AsyncBehavior.RESTART)
            for eventPlayer.ForLoop in range(0, len(PosTarget)):
                if eventPlayer.StatusTargetPreHit[eventPlayer.ForLoop] and not eventPlayer.StatusTarget[eventPlayer.ForLoop]:
                    eventPlayer.StatusTarget[eventPlayer.ForLoop] = true
                    eventPlayer.Target++
                    eventPlayer.TargetDifference++
            if eventPlayer.TargetDifference:
                playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer.getPosition(), 200)
                smallMessage(eventPlayer, l"{0}: {1}".format(l"{0} {1}".format(l"Targets", l"Hit"), l"{0} / {1}".format(eventPlayer.Target, len(PosTarget))))
                eventPlayer.TargetDifference = 0
        wait(0.125, Wait.ABORT_WHEN_FALSE)



rule "Floor":
	@Event eachPlayer
    @Condition eventPlayer.isOnGround()
    @Condition eventPlayer.Mode == 0
    @Condition distance(PosStart, vect(eventPlayer.getPosition().x, PosStart.y, eventPlayer.getPosition().z)) > 2
    @Condition distance(PosFinish, vect(eventPlayer.getPosition().x, PosFinish.y, eventPlayer.getPosition().z)) > 5
    @Condition all([distance(checkpointArray, vect(eventPlayer.getPosition().x, checkpointArray.y, eventPlayer.getPosition().z)) > 3.5 for checkpointArray in PosCheckpoint]) or not Checkpoint
    @Condition all([distance(padArray, vect(eventPlayer.getPosition().x, padArray.y, eventPlayer.getPosition().z)) > 3 for padArray in PosJumpPad])
    kill(eventPlayer, null)


rule "Ult Reset":
	@Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition eventPlayer.Mode == 0
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
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE)
    eventPlayer.AutoReset += 1
    if eventPlayer.AutoReset == 3:
        eventPlayer.AutoReset = 0
    if eventPlayer.AutoReset == 0:
        smallMessage(eventPlayer, "Auto Reset - Disabled")
        return
    if eventPlayer.AutoReset == 1:
        smallMessage(eventPlayer, "Auto Reset - Personal Best")
        return
    if eventPlayer.AutoReset == 2:
        smallMessage(eventPlayer, "Auto Reset - Record")


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
    @Condition eventPlayer.Mode == 0
	@Condition eventPlayer.isHoldingButton(Button.INTERACT)
    stopChasingVariable(eventPlayer.TimeCurrent)
    eventPlayer.TimeCurrent = 0
    eventPlayer.Attempts = 0
    eventPlayer.Mode = 1
    createIcon(eventPlayer, eventPlayer.PosPracticeCheckpoint, Icon.FLAG, IconReeval.POSITION, Color.GREEN, true)
    bigMessage(eventPlayer, "Entering Practice Mode")
    eventPlayer.setInvisibility(Invis.ALL)
    eventPlayer.clearStatusEffect(Status.PHASED_OUT)
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)


rule "Practice Mode (Button Held - Enabled)":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 1
	@Condition not eventPlayer.isHoldingButton(Button.INTERACT)
    eventPlayer.Mode = 2


rule "Fire status (Enabled)":
    @Event eachPlayer
    @Condition eventPlayer.Mode >= 1
    @Condition eventPlayer.Mode <= 3
    eventPlayer.setStatusEffect(null, Status.BURNING, 9999)
    eventPlayer.setStatusEffect(null, Status.INVINCIBLE, 9999)


rule "Practice Mode (disabled)":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 2
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)
    eventPlayer.Mode = 3


rule "Practice Mode (Button Held - disabled)":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 3
	@Condition not eventPlayer.isHoldingButton(Button.INTERACT)
    destroyIcon(getLastCreatedEntity())
    eventPlayer.PosPracticeCheckpoint = 0
    bigMessage(eventPlayer, "Leaving Practice Mode")
    eventPlayer.Attempts = -1
    eventPlayer.Mode = 0
    if not eventPlayer.isOnGround() or distance(PosStart, vect(eventPlayer.getPosition().x, PosStart.y, eventPlayer.getPosition().z)) <= 2 or distance(PosFinish, vect(eventPlayer.getPosition().x, PosFinish.y, eventPlayer.getPosition().z)) <= 5 or any([distance(checkpointArray, vect(eventPlayer.getPosition().x, checkpointArray.y, eventPlayer.getPosition().z)) <= 3.5 for checkpointArray in PosCheckpoint]):
        kill(eventPlayer, null)


rule "Fire status (Disabled)":
	@Event eachPlayer
    @Condition eventPlayer.Mode != 1
    @Condition eventPlayer.Mode != 2
    @Condition eventPlayer.Mode != 3
    eventPlayer.clearStatusEffect(Status.BURNING)
    eventPlayer.clearStatusEffect(Status.INVINCIBLE)


rule "Practice Checkpoints":
	@Event eachPlayer
    @Condition eventPlayer.Mode == 2
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE)
    eventPlayer.PosPracticeCheckpoint = eventPlayer.getPosition()
    eventPlayer.FacingPracticeCheckpoint = eventPlayer.getFacingDirection()
    eventPlayer.VelocityPracticeCheckpoint = eventPlayer.getVelocity()
    eventPlayer.SpeedPracticeCheckpoint = eventPlayer.getSpeed()
    smallMessage(eventPlayer, l"{0} {1}".format(l"Checkpoint", l"Saved"))


rule "Ult Reset Checkpoint":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 2
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    kill(eventPlayer, null)
    eventPlayer.Attempts += 1


rule "Player Spectator Mode enabled":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 0
	@Condition eventPlayer.isHoldingButton(Button.ABILITY_2)
    eventPlayer.Mode = 4
    stopChasingVariable(eventPlayer.TimeCurrent)
    eventPlayer.TimeCurrent = 0
    eventPlayer.setRespawnTime(9999)
    bigMessage(eventPlayer, "Entering Player Spectator Mode")
    wait(0.1)
    kill(eventPlayer, null)


rule "Player Spectator Mode enabled (Button Held)":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 4
	@Condition not eventPlayer.isHoldingButton(Button.ABILITY_2)
    stopChasingVariable(eventPlayer.TimeCurrent)
    eventPlayer.TimeCurrent = 0
    eventPlayer.Mode = 5


rule "Player Spectator Mode disabled":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 5
	@Condition eventPlayer.isHoldingButton(Button.ABILITY_2)
    eventPlayer.Mode = 6


rule "Player Specator Mode disabled (Button Held)":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 6
	@Condition not eventPlayer.isHoldingButton(Button.ABILITY_2)
    eventPlayer.teleport(PosStart)
    eventPlayer.resurrect()
    eventPlayer.setStatusEffect(null, Status.ROOTED, 0.5)
    eventPlayer.Attempts = 0
    wait(0.1)
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
    @Condition eventPlayer.Mode == 7
	@Condition not eventPlayer.isHoldingButton(Button.ABILITY_1)
    eventPlayer.Mode = 8


rule "Spectator Mode disabled":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 8
	@Condition eventPlayer.isHoldingButton(Button.ABILITY_1)
    eventPlayer.Mode = 9


rule "Specator Mode disabled (Button Held)":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 9
	@Condition not eventPlayer.isHoldingButton(Button.ABILITY_1)
    eventPlayer.setGravity(100)
    eventPlayer.setMoveSpeed(100)
    eventPlayer.Attempts = -1
    eventPlayer.Mode = 0
    bigMessage(eventPlayer, "Leaving Spectator Mode")
    if not eventPlayer.isOnGround() or distance(PosStart, vect(eventPlayer.getPosition().x, PosStart.y, eventPlayer.getPosition().z)) <= 2 or distance(PosFinish, vect(eventPlayer.getPosition().x, PosFinish.y, eventPlayer.getPosition().z)) <= 5 or any([distance(checkpointArray, vect(eventPlayer.getPosition().x, checkpointArray.y, eventPlayer.getPosition().z)) <= 3.5 for checkpointArray in PosCheckpoint]):
        kill(eventPlayer, null)


rule "Spectator Mode (move up enabled)":
	@Event eachPlayer
    @Condition eventPlayer.Mode >= 7
    @Condition eventPlayer.Mode <= 9
    @Condition eventPlayer.isHoldingButton(Button.JUMP)
    eventPlayer.applyImpulse(Vector.UP, 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)


rule "Spectator Mode (move up disabled)":
	@Event eachPlayer
    @Condition eventPlayer.Mode >= 7
    @Condition eventPlayer.Mode <= 9
    @Condition not eventPlayer.isHoldingButton(Button.JUMP)
    eventPlayer.applyImpulse(Vector.DOWN, 0.001, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.applyImpulse(Vector.UP, 0.001, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)


rule "Spectator Mode (move down enabled)":
	@Event eachPlayer
    @Condition eventPlayer.Mode >= 7
    @Condition eventPlayer.Mode <= 9
    @Condition eventPlayer.isHoldingButton(Button.CROUCH)
    eventPlayer.applyImpulse(Vector.DOWN, 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)


rule "Spectator Mode (move down disabled)":
	@Event eachPlayer
    @Condition eventPlayer.Mode >= 7
    @Condition eventPlayer.Mode <= 9
    @Condition not eventPlayer.isHoldingButton(Button.CROUCH)
    eventPlayer.applyImpulse(Vector.UP, 0.001, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.applyImpulse(Vector.DOWN, 0.001, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)


rule "Spectator Mode (stop movement)":
    @Event eachPlayer
    @Condition eventPlayer.Mode >= 7
    @Condition eventPlayer.Mode <= 9
	@Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE)
    eventPlayer.applyImpulse(eventPlayer.getVelocity() * -0.001, 0.001, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.applyImpulse(eventPlayer.getVelocity() * 0.001, 0.001, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)


rule "Spectator Mode (slow movement enabled)":
    @Event eachPlayer
    @Condition eventPlayer.Mode >= 7
    @Condition eventPlayer.Mode <= 9
	@Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE)
    eventPlayer.setMoveSpeed(150)
    if eventPlayer.getHorizontalSpeed() <= 12.89:
        return
    eventPlayer.applyImpulse(eventPlayer.getVelocity() * -0.001, 1, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.applyImpulse(eventPlayer.getVelocity() * 1, 12.89, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)


rule "Spectator Mode (slow movement disabled)":
    @Event eachPlayer
    @Condition eventPlayer.Mode >= 7
    @Condition eventPlayer.Mode <= 9
	@Condition not eventPlayer.isHoldingButton(Button.SECONDARY_FIRE)
    eventPlayer.setMoveSpeed(200)


rule "Circle Fix":
	@Event eachPlayer
    @Condition distance(PosStart, vect(eventPlayer.getPosition().x, PosStart.y, eventPlayer.getPosition().z)) <= 1.88
    @Condition eventPlayer.isOnGround()
    @Condition eventPlayer.Checkpoint == false
    @Condition eventPlayer.Target == false
    @Condition eventPlayer.getHorizontalSpeed() <= 8.6
    for eventPlayer.ForLoop in range(0, len(PosCheckpoint)):
        eventPlayer.StatusTargetPreHit[eventPlayer.ForLoop] = false
    stopChasingVariable(eventPlayer.TimeCurrent)
    eventPlayer.TimeCurrent = 0
    eventPlayer.disallowButton(Button.PRIMARY_FIRE)
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
        eventPlayer.Checkpoint = 0
        eventPlayer.Target = 0
        for eventPlayer.ForLoop in range(0, len(PosCheckpoint), 1):
            eventPlayer.StatusCheckpoint[eventPlayer.ForLoop] = false
        for eventPlayer.ForLoop in range(0, len(PosTarget), 1):
            eventPlayer.StatusTarget[eventPlayer.ForLoop] = false
            eventPlayer.StatusTargetPreHit[eventPlayer.ForLoop] = false
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

