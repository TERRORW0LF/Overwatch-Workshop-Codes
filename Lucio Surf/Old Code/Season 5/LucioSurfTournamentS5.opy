#Global variables

globalvar PlayerFirst 0
globalvar PlayerSecond 1
globalvar PlayerThird 2
globalvar PlayerFourth 3
globalvar PlayerFith 4
globalvar PlayerSixth 5
globalvar PlayerSeventh 6
globalvar PlayerEighth 7
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
globalvar PosSpawn 27
globalvar EndScreen 28
globalvar PlayerArray 29
globalvar TeamFirst 30
globalvar TeamSecond 31


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
playervar SettingRun 21
playervar TargetHitInUse 22
playervar PosPracticeCheckpoint 23
playervar FacingPracticeCheckpoint 24
playervar VelocityPracticeCheckpoint 25
playervar SpeedPracticeCheckpoint 26


#Subroutines
subroutine SpeedRing 1
subroutine TargetHit1 2
subroutine TargetHit2 3
subroutine TargetHit3 4
subroutine TargetHit4 5
subroutine TeleportSpawn 6


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
    if not eventPlayer.StatusTargetPreHit[eventPlayer.Temp[0]]:
        eventPlayer.TargetHitInUse[0] = false
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
    if not eventPlayer.StatusTargetPreHit[eventPlayer.Temp[1]]:
        eventPlayer.TargetHitInUse[1] = false
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
    if not eventPlayer.StatusTargetPreHit[eventPlayer.Temp[2]]:
        eventPlayer.TargetHitInUse[2] = false
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
    if not eventPlayer.StatusTargetPreHit[eventPlayer.Temp[3]]:
        eventPlayer.TargetHitInUse[3] = false
        return
    playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer.getPosition(), 200)
    eventPlayer.StatusTarget[eventPlayer.Temp[3]] = true
    eventPlayer.Target++
    smallMessage(eventPlayer, l"{0}: {1}".format(l"{0} {1}".format(l"Targets", l"Hit"), l"{0} / {1}".format(eventPlayer.Target, len(PosTarget))))
    eventPlayer.TargetHitInUse[3] = false


def TeleportSpawn():
    @Name "Teleport to Spawn (End of Heat)"
    eventPlayer.SettingRun = false
    eventPlayer.Mode = 0
    stopChasingVariable(eventPlayer.TimeCurrent)
    eventPlayer.TimeCurrent = 0
    eventPlayer.setInvisibility(Invis.NONE)
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)
    eventPlayer.disallowButton(Button.PRIMARY_FIRE)
    eventPlayer.teleport(PosSpawn)


#Maps
rule "Start - Maps - Setup":
    @Event global
    HeightJumpPad = 18
    SpeedSpeedRing = 1.2
    SizeTarget = [0.75, 0.75, 0.75, 0.75, 0.75, 0.75, 0.75, 0.75, 0.75, 0.75]


rule "Start - Assault - Every Map Is In Order (a - z)":
    if getCurrentMap() == Map.PARIS:
        PosJumpPad = []
        SpeedSpeedRing = [1.4, 1.1, 1.15]
        PosSpeedRing = [vect(-86.259, 17.101, -19.71), vect(-89.094, 16.561, -104.79), vect(-40.862, 17.201, -8.947)]
        PosTarget = [vect(-42.919, 19.249, 4.78), vect(-26.089, 19.249, -27.091), vect(-96.885, 20.53, -30.404), vect(-50.397, 20.53, -56.284), vect(-94.579, 22.14, -81.971), vect(-106.255, 16.716, -99.468)]
        PosStart = vect(-27.132, 13.165, 6.412)
        PosCheckpoint = [vect(7.458, 10.199, -58.2), vect(-53.175, 12.201, 12.32), vect(-73.074, 15.175, -86.629), vect(-118.024, 13.175, -92.921), vect(-83.325, 12.175, -58.477)]
        PosFinish = vect(-58.73, 12.028, -13.232)
        PosSpawn = vect(29.061, 16.164, -83.73)
        return
    if getCurrentMap() == Map.TEMPLE_OF_ANUBIS:
        PosJumpPad = []
        PosSpeedRing = [vect(-21.877, 9.137, 66.208)]
        PosTarget = [vect(-27.283, 11.221, 46.704), vect(-8.013, 8.178, 109.634), vect(-4.317, 8.338, 4.733)]
        PosStart = vect(-47.474, 9.684, 18.968)
        PosCheckpoint = [vect(-30.065, 3.812, 107.13), vect(17.017, 2.574, 97.256), vect(17.407, 0.551, 1.138), vect(-21.014, 4.684, 35.175), vect(-20.446, -2.082, -22.555)]
        PosFinish = vect(-34.967, 1.516, 35.235)
        PosSpawn = vect(-11.155, 9.174, 148.457)
        return
    if getCurrentMap() == Map.VOLSKAYA:
        PosJumpPad = [vect(-7.989, 18.014, 38.256)]
        SpeedSpeedRing = 1.4
        PosSpeedRing = [vect(-49.071, -0.524, 76.893), vect(-48.03, -0.885, 64.626)]
        PosTarget = [vect(-11.959, 5.859, 77.69), vect(-93.577, 4.898, 49.575), vect(-47.418, 3.456, 72.482), vect(-9.568, -0.724, 49.063)]
        PosStart = vect(-43.782, -2.805, 52.785)
        PosCheckpoint = [vect(-98.926, -2.305, 23.314), vect(-104.674, -3.805, 68.186), vect(-32.689, -3.308, 72.356), vect(27.113, -3.871, 77.489), vect(-29.813, 2.185, 38.063)]
        PosFinish = vect(-56.662, -3.986, 71.855)
        PosSpawn = vect(29.14, 0.781, -11.31)


rule "Start - Hybrid":
    if getCurrentMap() == Map.KINGS_ROW:
        PosJumpPad = [vect(-151.962, -1.679, 20.489)]
        PosSpeedRing = [vect(-84.567, 1.748, -24.01)]
        PosTarget = [vect(4.228, 12.199, -43.217), vect(-133.06, 0.246, 10.817), vect(-16.876, 1.175, -16.765)]
        PosStart = vect(-56.613, -0.1, -42.469)
        PosCheckpoint = [vect(-154.342, -2.983, 24.929), vect(-80.861, 0.314, 2.81), vect(5.901, 6.285, -28.012), vect(-25.228, 0.061, 15.6)]
        PosFinish = vect(-77.907, 0.294, -22.495)
        PosSpawn = vect(0.359, 5.356, 39.519)
        return
    if getCurrentMap() == Map.NUMBANI:
        PosJumpPad = []
        PosSpeedRing = []
        PosTarget = [vect(27.218, 7.828, 19.343), vect(87.045, 7.828, -2.748), vect(157.917, 7.956, -11.199), vect(123.86, 4.698, 18.46), vect(207.032, 2.616, 22.724)]
        PosStart = vect(155.325, -3.575, 23.509)
        PosCheckpoint = [vect(219.739, 0.367, 22.441), vect(205.1, -3.626, -5.822), vect(120.67, -5.59, -17.039), vect(131.903, -3.575, 40.896), vect(59.889, -0.75, -25.254), vect(8.506, 0.425, 37.804)]
        PosFinish = vect(139.784, -4.005, 17.222)
        PosSpawn = vect(-34.72, 6.789, 6.122)


rule "Start Escort":
    if getCurrentMap() == Map.DORADO:
        PosJumpPad = [vect(25.379, 3.68, -9.698)]
        PosSpeedRing = [vect(63.088, 21.316, 41.735)]
        PosTarget = [vect(32.48, 6.077, -6.712), vect(109.978, 20.231, 13.867), vect(155.323, 18.932, 56.909), vect(60.479, 16.748, -22.246)]
        PosStart = vect(138.184, 11.187, 16.06)
        PosCheckpoint = [vect(174.171, 11.175, 37.596), vect(127.679, 12.187, 52.141), vect(35.461, 10.175, -33.067), vect(110.839, 10.175, 1.102), vect(3.741, -0.2, -7.493)]
        PosFinish = vect(107.157, 18.175, -3.186)
        return
    if getCurrentMap() == Map.WATCHPOINT_GIBRALTAR:
        HeightJumpPad = 14
        SpeedSpeedRing = 1.3
        PosJumpPad = [vect(66.019, -2.964, -34.936)]
        PosSpeedRing = [vect(24.004, 5.261, -76.554), vect(32.249, -7.552, -103.262)]
        PosTarget = [vect(41.547, 6.062, -127.541), vect(14.44, 4.971, -84.559), vect(37.323, 4.01, -61.927), vect(59.167, 5.611, 15.744), vect(84.51, 10.416, 8.546)]
        PosStart = vect(41.299, -4.837, -47.009)
        PosCheckpoint = [vect(82.004, -0.3, 39.69), vect(88.537, 3.175, -26.408), vect(28.308, -5.595, -158.458), vect(66.1, -1.825, -114.92)]
        PosFinish = vect(60.147, 10.201, -38.682)
        PosSpawn = vect(77.748, -5.721, 44.734)


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
    for ForLoop in range(0, len(PosCheckpoint), 1):    
        createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, Color.SKY_BLUE, PosCheckpoint[ForLoop], 3.5, EffectReeval.VISIBILITY)
        createEffect(getAllPlayers(), Effect.RING, Color.SKY_BLUE, PosCheckpoint[ForLoop], 3.5, EffectReeval.VISIBILITY)
        createIcon(getAllPlayers(), PosCheckpoint[ForLoop] + vect(0, 6, 0), Icon.ARROW_DOWN, IconReeval.VISIBILITY, Color.SKY_BLUE, true)
    #Vars
    PlayerArray = [PlayerFirst, PlayerSecond, PlayerThird, PlayerFourth, PlayerFith, PlayerSixth, PlayerSeventh, PlayerEighth]
    setMatchTime(1820)
    #Leaderboards
    hudHeader(getAllPlayers(), Team.1, HudPosition.RIGHT, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
    hudSubtext(getAllPlayers(), l"{0} - {1} - {2}".format(PlayerArray.index([player for player in PlayerArray if player.getTeam() == Team.1][0])+1, [player for player in PlayerArray if player.getTeam() == Team.1][0], [player for player in PlayerArray if player.getTeam() == Team.1][0].TimeBest if [player for player in PlayerArray if player.getTeam() == Team.1][0].TimeBest else 9999), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
    hudSubtext(getAllPlayers(), l"{0} - {1} - {2}".format(PlayerArray.index([player for player in PlayerArray if player.getTeam() == Team.1][1])+1, [player for player in PlayerArray if player.getTeam() == Team.1][1], [player for player in PlayerArray if player.getTeam() == Team.1][1].TimeBest if [player for player in PlayerArray if player.getTeam() == Team.1][1].TimeBest else 9999), HudPosition.RIGHT, 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
    hudSubtext(getAllPlayers(), l"{0} - {1} - {2}".format(PlayerArray.index([player for player in PlayerArray if player.getTeam() == Team.1][2])+1, [player for player in PlayerArray if player.getTeam() == Team.1][2], [player for player in PlayerArray if player.getTeam() == Team.1][2].TimeBest if [player for player in PlayerArray if player.getTeam() == Team.1][2].TimeBest else 9999), HudPosition.RIGHT, 3, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
    hudSubtext(getAllPlayers(), l"{0} - {1} - {2}".format(PlayerArray.index([player for player in PlayerArray if player.getTeam() == Team.1][3])+1, [player for player in PlayerArray if player.getTeam() == Team.1][3], [player for player in PlayerArray if player.getTeam() == Team.1][3].TimeBest if [player for player in PlayerArray if player.getTeam() == Team.1][3].TimeBest else 9999), HudPosition.RIGHT, 4, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
    hudHeader(getAllPlayers(), "{0}".format(Team.2), HudPosition.RIGHT, 5, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
    hudSubtext(getAllPlayers(), l"{0} - {1} - {2}".format(PlayerArray.index([player for player in PlayerArray if player.getTeam() == Team.2][0])+1, [player for player in PlayerArray if player.getTeam() == Team.2][0], [player for player in PlayerArray if player.getTeam() == Team.2][0].TimeBest if [player for player in PlayerArray if player.getTeam() == Team.2][0].TimeBest else 9999), HudPosition.RIGHT, 6, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
    hudSubtext(getAllPlayers(), l"{0} - {1} - {2}".format(PlayerArray.index([player for player in PlayerArray if player.getTeam() == Team.2][1])+1, [player for player in PlayerArray if player.getTeam() == Team.2][1], [player for player in PlayerArray if player.getTeam() == Team.2][1].TimeBest if [player for player in PlayerArray if player.getTeam() == Team.2][1].TimeBest else 9999), HudPosition.RIGHT, 7, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
    hudSubtext(getAllPlayers(), l"{0} - {1} - {2}".format(PlayerArray.index([player for player in PlayerArray if player.getTeam() == Team.2][2])+1, [player for player in PlayerArray if player.getTeam() == Team.2][2], [player for player in PlayerArray if player.getTeam() == Team.2][2].TimeBest if [player for player in PlayerArray if player.getTeam() == Team.2][2].TimeBest else 9999), HudPosition.RIGHT, 8, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
    hudSubtext(getAllPlayers(), l"{0} - {1} - {2}".format(PlayerArray.index([player for player in PlayerArray if player.getTeam() == Team.2][3])+1, [player for player in PlayerArray if player.getTeam() == Team.2][3], [player for player in PlayerArray if player.getTeam() == Team.2][3].TimeBest if [player for player in PlayerArray if player.getTeam() == Team.2][3].TimeBest else 9999), HudPosition.RIGHT, 9, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)


rule "Start - Player":
    @Event eachPlayer
    @Condition eventPlayer.hasSpawned()
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
    eventPlayer.Attempts = -1
    eventPlayer.disallowButton(Button.ABILITY_1)
    eventPlayer.disallowButton(Button.ABILITY_2)
    eventPlayer.disallowButton(Button.ULTIMATE)
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)
    hudSubtext(eventPlayer, "{0}\n{1}".format(l"{0}: {1}".format(l"Checkpoints", l"{0} / {1}".format(eventPlayer.Checkpoint, len(PosCheckpoint))), l"{0}: {1}".format(l"Targets", l"{0} / {1}".format(eventPlayer.Target, len(PosTarget)))), HudPosition.TOP, 4, Color.BLUE, HudReeval.STRING)
    hudHeader(eventPlayer, eventPlayer, HudPosition.LEFT, 0, Color.YELLOW, HudReeval.NONE, SpecVisibility.DEFAULT)
    hudHeader(eventPlayer, l"{0} sec".format(eventPlayer.TimeCurrent), HudPosition.TOP, 2, Color.WHITE, HudReeval.STRING, SpecVisibility.DEFAULT)
    hudHeader(eventPlayer, l"{0}: {1}".format(l"Best", l"{0} sec".format(eventPlayer.TimeBest)), HudPosition.LEFT, 1, Color.WHITE, HudReeval.STRING, SpecVisibility.DEFAULT)
    hudHeader(eventPlayer, l"{0}: {1}".format(l"Attempts", eventPlayer.Attempts), HudPosition.LEFT, 2, Color.WHITE, HudReeval.STRING, SpecVisibility.DEFAULT)
    createInWorldText(eventPlayer, l"{0} m".format(distance(PosFinish, eventPlayer)), PosFinish + vect(0, 5, 0), 2, Clip.NONE, WorldTextReeval.STRING, Color.WHITE, SpecVisibility.DEFAULT)
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
    eventPlayer.SettingRun = true
    kill(eventPlayer, null)
    

rule "Start timer":
	@Event eachPlayer
    @Condition eventPlayer.Mode == 0
    @Condition eventPlayer.SettingRun
    @Condition not eventPlayer.Checkpoint
    @Condition all([target == false for target in eventPlayer.StatusTargetPreHit])
    @Condition distance(PosStart, vect(eventPlayer.getPosition().x, PosStart.y, eventPlayer.getPosition().z)) > 2 or (distance(PosStart, vect(eventPlayer.getPosition().x, PosStart.y, eventPlayer.getPosition().z)) < 2 and not eventPlayer.isOnGround())
    chase(eventPlayer.TimeCurrent, 5000, rate=1, ChaseReeval.NONE)
    eventPlayer.allowButton(Button.PRIMARY_FIRE)
    eventPlayer.setInvisibility(Invis.NONE)


rule "Checkpoint":
	@Event eachPlayer
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
    @Condition not eventPlayer.Finished
    @Condition eventPlayer.Mode == 0
    @Condition any([distance(checkpointArray, vect(eventPlayer.getPosition().x, checkpointArray.y, eventPlayer.getPosition().z)) <= 3.5 and (not isInLoS(eventPlayer.getPosition(), vect(eventPlayer.getPosition().x, checkpointArray.y, eventPlayer.getPosition().z), BarrierLos.PASS_THROUGH_BARRIERS) or eventPlayer.getEyePosition().y < checkpointArray.y) for checkpointArray in PosCheckpoint])
    smallMessage(eventPlayer, l"{0} {1}".format(l"Checkpoint", l"Out of View"))


rule "Finish":
	@Event eachPlayer
    @Condition eventPlayer.Checkpoint == len(PosCheckpoint)
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
    # Check if new Personal Best is achieved
    if eventPlayer.TimeCurrent < eventPlayer.TimeBest:
        eventPlayer.TimeBest = eventPlayer.TimeCurrent
        eventPlayer.NewBest = true
        # Order new places
        if (eventPlayer.TimeCurrent < PlayerEighth.TimeBest or not PlayerEighth) and all([eventPlayer != player for player in PlayerArray.slice(0, 7)]):
            PlayerEighth = eventPlayer
        if (eventPlayer.TimeCurrent < PlayerSeventh.TimeBest or not PlayerSeventh) and all([eventPlayer != player for player in PlayerArray.slice(0, 6)]):
            if eventPlayer != PlayerSeventh:
                PlayerEighth = PlayerSeventh
            PlayerSeventh = eventPlayer
        if (eventPlayer.TimeCurrent < PlayerSixth.TimeBest or not PlayerSixth) and all([eventPlayer != player for player in PlayerArray.slice(0, 5)]):
            if eventPlayer != PlayerSixth:
                PlayerSeventh = PlayerSixth
            PlayerSixth = eventPlayer
        if (eventPlayer.TimeCurrent < PlayerFith.TimeBest or not PlayerFith) and all([eventPlayer != player for player in PlayerArray.slice(0, 4)]):
            if eventPlayer != PlayerFith:
                PlayerSixth = PlayerFith
            PlayerFith = eventPlayer
        if (eventPlayer.TimeCurrent < PlayerFourth.TimeBest or not PlayerFourth) and all([eventPlayer != player for player in PlayerArray.slice(0, 3)]):
            if eventPlayer != PlayerFourth:
                PlayerFith = PlayerFourth
            PlayerFourth = eventPlayer
        if (eventPlayer.TimeCurrent < PlayerThird.TimeBest or not PlayerThird) and all([eventPlayer != player for player in PlayerArray.slice(0, 2)]):
            if eventPlayer != PlayerThird:
                PlayerFourth = PlayerThird
            PlayerThird = eventPlayer
        if (eventPlayer.TimeCurrent < PlayerSecond.TimeBest or not PlayerSecond) and all([eventPlayer != player for player in PlayerArray.slice(0, 1)]):
            if eventPlayer != PlayerSecond:
                PlayerThird = PlayerSecond
            PlayerSecond = eventPlayer
        if eventPlayer.TimeCurrent < PlayerFirst.TimeBest or not PlayerFirst:
            if eventPlayer != PlayerFirst:
                PlayerSecond = PlayerFirst
            PlayerFirst = eventPlayer
    else:
        bigMessage(eventPlayer, l"{0}!!!".format(l"Finished"))
    wait()
    PlayerArray = [PlayerFirst, PlayerSecond, PlayerThird, PlayerFourth, PlayerFith, PlayerSixth, PlayerSeventh, PlayerEighth]
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
    @Condition eventPlayer.Mode >= 0 and eventPlayer.Mode <= 3
    @Condition any([distance(pad, vect(eventPlayer.getPosition().x, pad.y, eventPlayer.getPosition().z)) <= 3 and eventPlayer.getPosition().y - pad.y < 0 and eventPlayer.getPosition().y > pad.y - 0.2 for pad in PosJumpPad])
    eventPlayer.IndexJumpPad = PosJumpPad.index([pad for pad in PosJumpPad if distance(pad, vect(eventPlayer.getPosition().x, pad.y, eventPlayer.getPosition().z)) <= 3 and eventPlayer.getPosition().y - pad.y < 0 and eventPlayer.getPosition().y > pad.y - 0.2])
    if eventPlayer.IndexJumpPad == -1:
        return
    if HeightJumpPad[1]:
        eventPlayer.applyImpulse(Vector.UP, HeightJumpPad[eventPlayer.IndexJumpPad], Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
        return
    eventPlayer.applyImpulse(Vector.UP, HeightJumpPad, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)


rule "Speed Rings":
    @Event eachPlayer
    @Condition eventPlayer.Mode >= 0 and eventPlayer.Mode <= 3
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
    @Condition eventPlayer.SettingRun
    @Condition distance(PosStart, vect(eventPlayer.getPosition().x, PosStart.y, eventPlayer.getPosition().z)) > 2
    @Condition distance(PosFinish, vect(eventPlayer.getPosition().x, PosFinish.y, eventPlayer.getPosition().z)) > 5
    @Condition all([distance(checkpointArray, vect(eventPlayer.getPosition().x, checkpointArray.y, eventPlayer.getPosition().z)) > 3.5 for checkpointArray in PosCheckpoint])
    @Condition all([distance(padArray, vect(eventPlayer.getPosition().x, padArray.y, eventPlayer.getPosition().z)) > 3 for padArray in PosJumpPad])
    kill(eventPlayer, null)


rule "Ult Reset":
	@Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition eventPlayer.Mode == 0
    @Condition eventPlayer.SettingRun
    @Condition distance(PosStart, vect(eventPlayer.getPosition().x, PosStart.y, eventPlayer.getPosition().z)) > 2
    kill(eventPlayer, null)


rule "Velocity Counter (red)":
	@Event eachPlayer
    @Condition eventPlayer.getHorizontalSpeed() <= 8.6
    @Condition eventPlayer.SettingRun
    destroyHudText(getLastCreatedText())
    hudHeader(eventPlayer, l"{0} m/s".format(eventPlayer.getHorizontalSpeed()), HudPosition.TOP, 2, Color.RED, HudReeval.STRING)


rule "Velocity Counter (Orange)":
	@Event eachPlayer
    @Condition eventPlayer.getHorizontalSpeed() > 8.6
    @Condition eventPlayer.getHorizontalSpeed() < 13.15
    @Condition eventPlayer.SettingRun
    destroyHudText(getLastCreatedText())
    hudHeader(eventPlayer, l"{0} m/s".format(eventPlayer.getHorizontalSpeed()), HudPosition.TOP, 2, Color.ORANGE, HudReeval.STRING)


rule "Velocity Counter (Yellow)":
	@Event eachPlayer
    @Condition eventPlayer.getHorizontalSpeed() >= 13.15
    @Condition eventPlayer.getHorizontalSpeed() < 17.2
    @Condition eventPlayer.SettingRun
    destroyHudText(getLastCreatedText())
    hudHeader(eventPlayer, l"{0} m/s".format(eventPlayer.getHorizontalSpeed()), HudPosition.TOP, 2, Color.YELLOW, HudReeval.STRING)


rule "Velocity Counter (Green)":
    @Event eachPlayer
    @Condition eventPlayer.getHorizontalSpeed() >= 17.2
    @Condition eventPlayer.SettingRun
    destroyHudText(getLastCreatedText())
    hudHeader(eventPlayer, l"{0} m/s".format(eventPlayer.getHorizontalSpeed()), HudPosition.TOP, 2, Color.GREEN, HudReeval.STRING)


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
    if EndScreen:
        TeleportSpawn()
        return
    kill(eventPlayer, null)


rule "Auto Reset (Record)":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 0
    @Condition eventPlayer.AutoReset == 2
    @Condition PlayerFirst
    @Condition eventPlayer.TimeCurrent > PlayerFirst.TimeBest
    smallMessage(eventPlayer, "Reset by 'Auto Reset'")
    if EndScreen:
        TeleportSpawn()
        return
    kill(eventPlayer, null)


rule "Practice Mode (Enabled)":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 0
    @Condition eventPlayer.SettingRun
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
    if not eventPlayer.isOnGround() or distance(PosStart, vect(eventPlayer.getPosition().x, PosStart.y, eventPlayer.getPosition().z)) <= 2 or distance(PosFinish, vect(eventPlayer.getPosition().x, PosFinish.y, eventPlayer.getPosition().z)) <= 5 or any([distance(checkpoint, vect(eventPlayer.getPosition().x, checkpoint.y, eventPlayer.getPosition().z)) <= 3.5 for checkpoint in PosCheckpoint]) or any([distance(pad, vect(eventPlayer.getPosition().x, pad.y, eventPlayer.getPosition().z)) <= 2 for pad in PosJumpPad]):
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
    @Condition eventPlayer.SettingRun
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    kill(eventPlayer, null)
    eventPlayer.Attempts += 1


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


rule "Respawn":
    @Event playerDied
    if not eventPlayer.SettingRun:
        return
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
    if eventPlayer.Mode >= 1 and eventPlayer.Mode <= 3:
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


rule "Clear Player from leaderboards if left":
    @Event playerLeft
    if PlayerArray.index(eventPlayer) == -1:
        return
    goto loc+PlayerArray.index(eventPlayer)
    PlayerFirst = PlayerSecond
    PlayerSecond = PlayerThird
    PlayerThird = PlayerFourth
    PlayerFourth = PlayerFith
    PlayerFith = PlayerSixth
    PlayerSixth = PlayerSeventh
    PlayerSeventh = PlayerEighth
    PlayerEighth = 0
    PlayerArray = [PlayerFirst, PlayerSecond, PlayerThird, PlayerFourth, PlayerFith, PlayerSixth, PlayerSeventh, PlayerEighth]


rule "End Screen":
    @Event global
    @Condition isGameInProgress()
    @Condition getMatchTime() < 20
    pauseMatchTime()
    EndScreen = true
    TeamFirst = Team.1 if (PlayerArray.index(getPlayersInSlot(0, Team.1)) if PlayerArray.index(getPlayersInSlot(0, Team.1)) != -1 else PlayerArray.index(0)) + (PlayerArray.index(getPlayersInSlot(1, Team.1)) if PlayerArray.index(getPlayersInSlot(1, Team.1)) != -1 else PlayerArray.index(0)) + (PlayerArray.index(getPlayersInSlot(2, Team.1)) if PlayerArray.index(getPlayersInSlot(2, Team.1)) != -1 else PlayerArray.index(0)) + (PlayerArray.index(getPlayersInSlot(3, Team.1)) if PlayerArray.index(getPlayersInSlot(3, Team.1)) != -1 else PlayerArray.index(0)) + 4 < (PlayerArray.index(getPlayersInSlot(0, Team.2)) if PlayerArray.index(getPlayersInSlot(0, Team.2)) != -1 else PlayerArray.index(0)) + (PlayerArray.index(getPlayersInSlot(1, Team.2)) if PlayerArray.index(getPlayersInSlot(1, Team.2)) != -1 else PlayerArray.index(0)) + (PlayerArray.index(getPlayersInSlot(2, Team.2)) if PlayerArray.index(getPlayersInSlot(2, Team.2)) != -1 else PlayerArray.index(0)) + (PlayerArray.index(getPlayersInSlot(3, Team.2)) if PlayerArray.index(getPlayersInSlot(3, Team.2)) != -1 else PlayerArray.index(0)) + 4 else Team.2
    TeamSecond = getOppositeTeam(TeamFirst)
    createInWorldText(getAllPlayers(), "{0} - {1} Points".format(TeamFirst, (PlayerArray.index(getPlayersInSlot(0, TeamFirst)) if PlayerArray.index(getPlayersInSlot(0, TeamFirst)) != -1 else PlayerArray.index(0)) + (PlayerArray.index(getPlayersInSlot(1, TeamFirst)) if PlayerArray.index(getPlayersInSlot(1, TeamFirst)) != -1 else PlayerArray.index(0)) + (PlayerArray.index(getPlayersInSlot(2, TeamFirst)) if PlayerArray.index(getPlayersInSlot(2, TeamFirst)) != -1 else PlayerArray.index(0)) + (PlayerArray.index(getPlayersInSlot(3, TeamFirst)) if PlayerArray.index(getPlayersInSlot(3, TeamFirst)) != -1 else PlayerArray.index(0)) + 4), PosSpawn, 2.5, Clip.SURFACES, HudReeval.STRING, Color.GREEN, SpecVisibility.DEFAULT)
    createInWorldText(getAllPlayers(), "{0} - {1} - {2} sec".format(PlayerArray.index([player for player in PlayerArray if player.getTeam() == TeamFirst][0])+1 if [player for player in PlayerArray if player.getTeam() == TeamFirst][0] else PlayerArray.index(0)+1, [player for player in PlayerArray if player.getTeam() == TeamFirst][0] if [player for player in PlayerArray if player.getTeam() == TeamFirst][0] else "Place holder", [player for player in PlayerArray if player.getTeam() == TeamFirst][0].TimeBest if [player for player in PlayerArray if player.getTeam() == TeamFirst][0] else 9999), vect(PosSpawn.x, PosSpawn.y - 0.3, PosSpawn.z), 2, Clip.SURFACES, HudReeval.STRING, Color.WHITE, SpecVisibility.DEFAULT)
    createInWorldText(getAllPlayers(), "{0} - {1} - {2} sec".format(PlayerArray.index([player for player in PlayerArray if player.getTeam() == TeamFirst][1])+1 if [player for player in PlayerArray if player.getTeam() == TeamFirst][1] else PlayerArray.index(0)+1, [player for player in PlayerArray if player.getTeam() == TeamFirst][1] if [player for player in PlayerArray if player.getTeam() == TeamFirst][1] else "Place holder", [player for player in PlayerArray if player.getTeam() == TeamFirst][1].TimeBest if [player for player in PlayerArray if player.getTeam() == TeamFirst][1] else 9999), vect(PosSpawn.x, PosSpawn.y - 0.6, PosSpawn.z), 2, Clip.SURFACES, HudReeval.STRING, Color.WHITE, SpecVisibility.DEFAULT)
    createInWorldText(getAllPlayers(), "{0} - {1} - {2} sec".format(PlayerArray.index([player for player in PlayerArray if player.getTeam() == TeamFirst][2])+1 if [player for player in PlayerArray if player.getTeam() == TeamFirst][2] else PlayerArray.index(0)+1, [player for player in PlayerArray if player.getTeam() == TeamFirst][2] if [player for player in PlayerArray if player.getTeam() == TeamFirst][2] else "Place holder", [player for player in PlayerArray if player.getTeam() == TeamFirst][2].TimeBest if [player for player in PlayerArray if player.getTeam() == TeamFirst][2] else 9999), vect(PosSpawn.x, PosSpawn.y - 0.9, PosSpawn.z), 2, Clip.SURFACES, HudReeval.STRING, Color.WHITE, SpecVisibility.DEFAULT)
    createInWorldText(getAllPlayers(), "{0} - {1} - {2} sec".format(PlayerArray.index([player for player in PlayerArray if player.getTeam() == TeamFirst][3])+1 if [player for player in PlayerArray if player.getTeam() == TeamFirst][3] else PlayerArray.index(0)+1, [player for player in PlayerArray if player.getTeam() == TeamFirst][3] if [player for player in PlayerArray if player.getTeam() == TeamFirst][3] else "Place holder", [player for player in PlayerArray if player.getTeam() == TeamFirst][3].TimeBest if [player for player in PlayerArray if player.getTeam() == TeamFirst][3] else 9999), vect(PosSpawn.x, PosSpawn.y - 1.2, PosSpawn.z), 2, Clip.SURFACES, HudReeval.STRING, Color.WHITE, SpecVisibility.DEFAULT)
    createInWorldText(getAllPlayers(), "{0} - {1} Points".format(TeamSecond, (PlayerArray.index(getPlayersInSlot(0, TeamSecond)) if PlayerArray.index(getPlayersInSlot(0, TeamSecond)) != -1 else PlayerArray.index(0)) + (PlayerArray.index(getPlayersInSlot(1, TeamSecond)) if PlayerArray.index(getPlayersInSlot(1, TeamSecond)) != -1 else PlayerArray.index(0)) + (PlayerArray.index(getPlayersInSlot(2, TeamSecond)) if PlayerArray.index(getPlayersInSlot(2, TeamSecond)) != -1 else PlayerArray.index(0)) + (PlayerArray.index(getPlayersInSlot(3, TeamSecond)) if PlayerArray.index(getPlayersInSlot(3, TeamSecond)) != -1 else PlayerArray.index(0)) + 4), vect(PosSpawn.x, PosSpawn.y - 1.8, PosSpawn.z), 2.5, Clip.SURFACES, HudReeval.STRING, Color.RED, SpecVisibility.DEFAULT)
    createInWorldText(getAllPlayers(), "{0} - {1} - {2} sec".format(PlayerArray.index([player for player in PlayerArray if player.getTeam() == TeamSecond][0])+1 if [player for player in PlayerArray if player.getTeam() == TeamSecond][0] else PlayerArray.index(0)+1, [player for player in PlayerArray if player.getTeam() == TeamSecond][0] if [player for player in PlayerArray if player.getTeam() == TeamSecond][0] else "Place holder", [player for player in PlayerArray if player.getTeam() == TeamSecond][0].TimeBest if [player for player in PlayerArray if player.getTeam() == TeamSecond][0] else 9999), vect(PosSpawn.x, PosSpawn.y - 2.1, PosSpawn.z), 2, Clip.SURFACES, HudReeval.STRING, Color.WHITE, SpecVisibility.DEFAULT)
    createInWorldText(getAllPlayers(), "{0} - {1} - {2} sec".format(PlayerArray.index([player for player in PlayerArray if player.getTeam() == TeamSecond][1])+1 if [player for player in PlayerArray if player.getTeam() == TeamSecond][1] else PlayerArray.index(0)+1, [player for player in PlayerArray if player.getTeam() == TeamSecond][1] if [player for player in PlayerArray if player.getTeam() == TeamSecond][1] else "Place holder", [player for player in PlayerArray if player.getTeam() == TeamSecond][1].TimeBest if [player for player in PlayerArray if player.getTeam() == TeamSecond][1] else 9999), vect(PosSpawn.x, PosSpawn.y - 2.4, PosSpawn.z), 2, Clip.SURFACES, HudReeval.STRING, Color.WHITE, SpecVisibility.DEFAULT)
    createInWorldText(getAllPlayers(), "{0} - {1} - {2} sec".format(PlayerArray.index([player for player in PlayerArray if player.getTeam() == TeamSecond][2])+1 if [player for player in PlayerArray if player.getTeam() == TeamSecond][2] else PlayerArray.index(0)+1, [player for player in PlayerArray if player.getTeam() == TeamSecond][2] if [player for player in PlayerArray if player.getTeam() == TeamSecond][2] else "Place holder", [player for player in PlayerArray if player.getTeam() == TeamSecond][2].TimeBest if [player for player in PlayerArray if player.getTeam() == TeamSecond][2] else 9999), vect(PosSpawn.x, PosSpawn.y - 2.7, PosSpawn.z), 2, Clip.SURFACES, HudReeval.STRING, Color.WHITE, SpecVisibility.DEFAULT)
    createInWorldText(getAllPlayers(), "{0} - {1} - {2} sec".format(PlayerArray.index([player for player in PlayerArray if player.getTeam() == TeamSecond][3])+1 if [player for player in PlayerArray if player.getTeam() == TeamSecond][3] else PlayerArray.index(0)+1, [player for player in PlayerArray if player.getTeam() == TeamSecond][3] if [player for player in PlayerArray if player.getTeam() == TeamSecond][3] else "Place holder", [player for player in PlayerArray if player.getTeam() == TeamSecond][3].TimeBest if [player for player in PlayerArray if player.getTeam() == TeamSecond][3] else 9999), vect(PosSpawn.x, PosSpawn.y - 3, PosSpawn.z), 2, Clip.SURFACES, HudReeval.STRING, Color.WHITE, SpecVisibility.DEFAULT)
    

rule "EndScreen forbid spawn leave":
    @Event eachPlayer
    @Condition EndScreen
    @Condition not eventPlayer.SettingRun
    @Condition not eventPlayer.isInSpawnRoom()
    eventPlayer.teleport(PosSpawn)


rule "Teleport to EndScreen":
    @Event eachPlayer
    @Condition EndScreen
    TeleportSpawn()