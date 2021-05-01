#Global variables

globalvar TimeFirst 0
globalvar TimeSecond 1
globalvar TimeThird 2
globalvar TimeFourth 3
globalvar PlayerFirst 4
globalvar PlayerSecond 5
globalvar PlayerThird 6
globalvar PlayerFourth 7
globalvar Checkpoint 8
globalvar Visible 9
globalvar EndScreen 10
globalvar TimeArray 11
globalvar PosObj 21
globalvar PosSpawn 22
globalvar PosCheckpoint 24
globalvar PosFinish 25
globalvar PosStart 23


#Player variables

playervar TimeCurrent 0
playervar TimeBest 1
playervar Checkpoint 3
playervar AutoReset 5
playervar Finished 4
playervar UltReset 6
playervar SpeedTag 11
playervar PracticeCheckpointIcon 12
playervar Mode 7
playervar NewBest 2
playervar PosPracticeCheckpoint 13
playervar FacingPracticeCheckpoint 14
playervar VelocityPracticeCheckpoint 15
playervar SpeedPracticeCheckpoint 16
playervar Spawned 8
playervar SettingRun 9
playervar Attempts 10


#Subroutine names

subroutine Sub0 0


def Sub0():
    @Name "EndScreenTeleport"
    eventPlayer.SettingRun = false
    eventPlayer.teleport(PosSpawn)
    eventPlayer.setInvisibility(Invis.NONE)
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)
    wait(0.05)
    eventPlayer.Finished = false
    TimeArray = sorted(getAllPlayers(), key=lambda player: player.TimeBest)
    stopChasingVariable(eventPlayer.TimeCurrent)
    eventPlayer.TimeCurrent = 0
    destroyHudText(eventPlayer.SpeedTag)


rule "Start - Assault - Every Map Is In Order (a - z)":
    @Event global
    #Horizon Lunar Colony
    if getCurrentMap() == Map.HORIZON_LUNAR_COLONY:
        PosSpawn = vect(-32, 13, 14)
        PosStart = vect(-38.253, 10.174, -122.811)
		PosCheckpoint = vect(43.183, 14.173, -77.129)
		PosFinish = vect(25.671, 7.174, -15.620)
		Checkpoint = true
        return
    #Volskaya Industries
    if getCurrentMap() == Map.VOLSKAYA:
        PosSpawn = vect(28.5, 0.5, -11.5)
        PosStart = vect(-96.722, -2.303, 24.146)
		PosCheckpoint = vect(-37.356, 2.194, 98.043)
		PosFinish = vect(-30.133, 2.294, 38.232)
		Checkpoint = true


rule "Start - Escort":
    @Event global
    #Rialto
    if getCurrentMap() == Map.RIALTO:
        PosSpawn = vect(157.549, 3.5, -20.976)
        PosStart = vect(-31.663, 1.924, -115.564)
	    PosCheckpoint = vect(24.407, 2.155, -132.750)
	    PosFinish = vect(160.704, -3.678, -62.886)
	    Checkpoint = false
        return
    #Route 66
    if getCurrentMap() == Map.ROUTE66:
        PosSpawn = vect(61.336, 5.141, -24.946)
        PosStart = vect(71.704, 0.114, 11.870)
        PosCheckpoint = vect(-42.605, 3.614, 5.206)
        PosFinish = vect(-100.763, 8.673, 8.128)
        Checkpoint = true


rule "Start - Hybrid":
    @Event global
    #Blizzard World
    if getCurrentMap() == Map.BLIZZ_WORLD:
        PosSpawn = vect(3.18, -1.957, -41.914)
        PosStart = vect(-5.806, -4.726, -37.260)
        PosCheckpoint = vect(-57.041, -3.729, -2.099)
        PosFinish = vect(27.459, -5.668, -25.653)
        Checkpoint = true
        return
    #King's row
    if getCurrentMap() == Map.KINGS_ROW:
        PosSpawn = vect(0.449, 4.307, 39.147)
        PosStart = vect(4.830, 7.175, -1.205)
	    PosCheckpoint = vect(-83.851, 0.682, 4.438)
	    PosFinish = vect(-118.429, -1.208, 24.984)
	    Checkpoint = true


rule "Start - Global":
    @Event global
    #Start / Checkpoint / Finish effects
    createEffect([player for player in getAllPlayers() if player.SettingRun], Effect.RING, Color.GREEN, PosStart, 2, EffectReeval.VISIBILITY)
    createEffect([player for player in getAllPlayers() if player.SettingRun], Effect.LIGHT_SHAFT, Color.WHITE, PosFinish, 5, EffectReeval.VISIBILITY)
    createEffect([player for player in getAllPlayers() if player.SettingRun], Effect.RING, Color.WHITE, PosFinish, 5, EffectReeval.VISIBILITY)
    createEffect([player for player in getAllPlayers() if player.SettingRun], Effect.LIGHT_SHAFT, Color.SKY_BLUE, PosCheckpoint, 3.5, EffectReeval.VISIBILITY)
    createEffect([player for player in getAllPlayers() if player.SettingRun], Effect.RING, Color.SKY_BLUE, PosCheckpoint, 3.5, EffectReeval.VISIBILITY)
    setMatchTime(1220)
    TimeFirst = 9999
    TimeSecond = 9999
    TimeThird = 9999
    TimeFourth = 9999
    Visible = true
    EndScreen = false
    hudHeader([player for player in getAllPlayers() if player.SettingRun], l"{0} - {1} - {2}".format("4", l"{0} sec".format(TimeFourth), PlayerFourth), HudPosition.RIGHT, 3, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudHeader([player for player in getAllPlayers() if player.SettingRun], l"{0} - {1} - {2}".format("3", l"{0} sec".format(TimeThird), PlayerThird), HudPosition.RIGHT, 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudHeader([player for player in getAllPlayers() if player.SettingRun], l"{0} - {1} - {2}".format("2", l"{0} sec".format(TimeSecond), PlayerSecond), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudHeader([player for player in getAllPlayers() if player.SettingRun], l"{0} - {1} - {2}".format(l"Record", l"{0} sec".format(TimeFirst), PlayerFirst), HudPosition.RIGHT, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)


rule "Start - Player":
    @Event eachPlayer
    #Player hud
    hudHeader([i for i in eventPlayer if eventPlayer.SettingRun], l"{0} sec".format(eventPlayer.TimeCurrent), HudPosition.TOP, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudHeader([i for i in eventPlayer if eventPlayer.SettingRun], l"{0} - {1}".format(l"Best", eventPlayer.TimeBest), HudPosition.LEFT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudHeader([i for i in eventPlayer if eventPlayer.SettingRun], l"{0}: {1}".format(l"Attempts", eventPlayer.Attempts), HudPosition.LEFT, 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    #Checkpoint / Finish icons
    createInWorldText([i for i in eventPlayer if eventPlayer.SettingRun], l"{0} m".format(distance(PosFinish, eventPlayer)), PosFinish + vect(0, 5, 0), 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
    createIcon([i for i in eventPlayer if eventPlayer.SettingRun], PosFinish + vect(0, 6, 0), Icon.FLAG, IconReeval.VISIBILITY_AND_POSITION, Color.WHITE, true)
    createInWorldText([i for i in eventPlayer if eventPlayer.SettingRun], l"{0} m".format(distance(PosCheckpoint, eventPlayer)), PosCheckpoint + vect(0, 5, 0), 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.SKY_BLUE, SpecVisibility.DEFAULT)
    createIcon([i for i in eventPlayer if eventPlayer.SettingRun], PosCheckpoint + vect(0, 6, 0), Icon.ARROW_DOWN, IconReeval.VISIBILITY_AND_POSITION, Color.SKY_BLUE, true)
    #Vars
    eventPlayer.TimeBest = 9999
    eventPlayer.Finished = false
    eventPlayer.Checkpoint = false
    eventPlayer.SettingRun = true
    eventPlayer.Attempts = -1
    #Setup
    eventPlayer.enableDeathSpectateAllPlayers()
    eventPlayer.enableDeathSpectateTargetHud()
    eventPlayer.disallowButton(Button.ABILITY_1)
    eventPlayer.disallowButton(Button.ABILITY_2)
    eventPlayer.disallowButton(Button.PRIMARY_FIRE)
    eventPlayer.disallowButton(Button.SECONDARY_FIRE)
    eventPlayer.disallowButton(Button.ULTIMATE)


rule "Start timer":
    @Event eachPlayer
    @Condition eventPlayer.SettingRun
    @Condition eventPlayer.Mode == 0
    @Condition not eventPlayer.Checkpoint
    @Condition distance(PosStart, eventPlayer) > 2 or not eventPlayer.isOnGround()
    chase(eventPlayer.TimeCurrent, 5000, rate=1, ChaseReeval.NONE)
    if not Visible:
        return
    eventPlayer.setInvisibility(Invis.NONE)


rule"Checkpoint":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 0
    @Condition Checkpoint
    @Condition not eventPlayer.Finished
    @Condition not eventPlayer.Checkpoint
    @Condition distance(PosCheckpoint, vect(eventPlayer.getPosition().x, PosCheckpoint.y, eventPlayer.getPosition().z)) <= 3.5
    @Condition isInLoS(eventPlayer.getPosition(), vect(eventPlayer.getPosition().x, PosCheckpoint.y, eventPlayer.getPosition().z), BarrierLos.PASS_THROUGH_BARRIERS)
    @Condition eventPlayer.getEyePosition().y >= PosCheckpoint.y
    eventPlayer.Checkpoint = true
    smallMessage(eventPlayer, l"{0} {1}".format(l"Finish", l"Unlocked"))
    eventPlayer.communicate(Comms.VOICE_LINE_LEFT)
    bigMessage(eventPlayer, eventPlayer.TimeCurrent)
    
    
rule"Checkpoint (no LoS)":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 0
    @Condition Checkpoint
    @Condition not eventPlayer.Finished
    @Condition not eventPlayer.Checkpoint
    @Condition distance(PosCheckpoint, vect(eventPlayer.getPosition().x, PosCheckpoint.y, eventPlayer.getPosition().z)) <= 3.5
    @Condition not isInLoS(eventPlayer.getPosition(), vect(eventPlayer.getPosition().x, PosCheckpoint.y, eventPlayer.getPosition().z), BarrierLos.PASS_THROUGH_BARRIERS) or eventPlayer.getEyePosition().y < PosCheckpoint.y
    smallMessage(eventPlayer, "No LoS to Checkpoint")
    
    
rule"Finish":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 0
    @Condition not eventPlayer.Finished
    @Condition eventPlayer.Checkpoint or not Checkpoint
    @Condition distance(PosFinish, vect(eventPlayer.getPosition().x, PosFinish.y, eventPlayer.getPosition().z)) <= 5
    @Condition isInLoS(eventPlayer.getPosition(), vect(eventPlayer.getPosition().x, PosFinish.y, eventPlayer.getPosition().z), BarrierLos.PASS_THROUGH_BARRIERS)
    @Condition eventPlayer.getEyePosition().y >= PosFinish.y
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
    if eventPlayer.TimeCurrent >= TimeFourth:
        goto lbl_2
    if eventPlayer.TimeCurrent >= TimeThird:
        TimeFourth = eventPlayer.TimeCurrent
        PlayerFourth = eventPlayer
        goto lbl_3
    if eventPlayer.TimeCurrent >= TimeSecond:
        if eventPlayer != PlayerThird:
            TimeFourth = TimeThird
            PlayerFourth = PlayerThird
        TimeThird = eventPlayer.TimeCurrent
        PlayerThird = eventPlayer
        goto lbl_4
    if eventPlayer.TimeCurrent >= TimeFirst:
        if eventPlayer != PlayerSecond:
            if eventPlayer != PlayerThird:
                TimeFourth = TimeThird
                PlayerFourth = PlayerThird
            TimeThird = TimeSecond
            PlayerThird = PlayerSecond
        TimeSecond = eventPlayer.TimeCurrent
        PlayerSecond = eventPlayer
        goto lbl_5
    if eventPlayer.TimeCurrent < TimeFirst:
        if eventPlayer != PlayerFirst:
            if eventPlayer != PlayerSecond:
                if eventPlayer != PlayerThird:
                    TimeFourth = TimeThird
                    PlayerFourth = PlayerThird
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
    lbl_5:
    wait()
    eventPlayer.Finished = true


rule"Finish (no LoS)":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 0
    @Condition not eventPlayer.Finished
    @Condition distance(PosFinish, vect(eventPlayer.getPosition().x, PosFinish.y, eventPlayer.getPosition().z)) <= 5
    @Condition not isInLoS(eventPlayer.getPosition(), vect(eventPlayer.getPosition().x, PosFinish.y, eventPlayer.getPosition().z), BarrierLos.PASS_THROUGH_BARRIERS) or eventPlayer.getEyePosition().y < PosFinish.y
    smallMessage(eventPlayer, "No LoS to Finish")


rule"Finish (no Checkpoint)":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 0
    @Condition not eventPlayer.Finished
    @Condition Checkpoint
    @Condition not eventPlayer.Checkpoint
    @Condition distance(PosFinish, vect(eventPlayer.getPosition().x, PosFinish.y, eventPlayer.getPosition().z)) <= 5
    bigMessage(eventPlayer, "You did not hit the checkpoint")


rule"Finish Message (Best Time)":
    @Event eachPlayer
    @Condition eventPlayer.Finished
    @Condition eventPlayer.NewBest == true
    @Condition eventPlayer != PlayerFirst
    bigMessage(eventPlayer, l"{0} - {1}".format(l"{0} {1}".format(l"Best", l"Time"), eventPlayer.TimeBest))


rule"Finish Message (Record Time)":
    @Event eachPlayer
    @Condition eventPlayer.Finished
    @Condition eventPlayer.NewBest == true
    @Condition eventPlayer == PlayerFirst
    bigMessage(getAllPlayers(), l"{0} {1}".format(l"{0}!!!".format(l"New Record"), l"{0} - {1}".format(l"{0} sec".format(eventPlayer.TimeBest), eventPlayer)))


rule"Floor":
    @Event eachPlayer
    @Condition eventPlayer.SettingRun
    @Condition eventPlayer.isOnGround()
    @Condition eventPlayer.Mode == 0
    @Condition distance(PosStart, vect(eventPlayer.getPosition().x, PosStart.y, eventPlayer.getPosition().z)) > 2
    @Condition distance(PosFinish, vect(eventPlayer.getPosition().x, PosFinish.y, eventPlayer.getPosition().z)) > 5
    @Condition not Checkpoint or distance(PosCheckpoint, vect(eventPlayer.getPosition().x, PosCheckpoint.y, eventPlayer.getPosition().z)) > 3.5
    if EndScreen:
        Sub0()
        return
    kill(eventPlayer, null)


rule"Ult Reset":
    @Event eachPlayer
    @Condition eventPlayer.SettingRun
    @Condition eventPlayer.Mode == 0
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition distance(PosStart, vect(eventPlayer.getPosition().x, PosStart.y, eventPlayer.getPosition().z)) > 2
    if EndScreen:
        Sub0()
        return
    kill(eventPlayer, null)


rule"Velocity Counter (red)":
    @Event eachPlayer
    @Condition eventPlayer.SettingRun
    @Condition eventPlayer.Spawned
    @Condition eventPlayer.getHorizontalSpeed() <= 8.6
    @Condition eventPlayer.getCurrentHero() == Hero.LUCIO
    destroyHudText(eventPlayer.SpeedTag)
    hudHeader(eventPlayer, l"{0} m/s".format(eventPlayer.getHorizontalSpeed()), HudPosition.TOP, 2, Color.RED, HudReeval.VISIBILITY_AND_STRING)
    eventPlayer.SpeedTag = getLastCreatedText()


rule"Velocity Counter (Orange)":
    @Event eachPlayer
    @Condition eventPlayer.SettingRun
    @Condition eventPlayer.Spawned
    @Condition eventPlayer.getHorizontalSpeed() > 8.6 and eventPlayer.getHorizontalSpeed() < 13.15 and eventPlayer.getCurrentHero() == Hero.LUCIO
    destroyHudText(eventPlayer.SpeedTag)
    hudHeader(eventPlayer, l"{0} m/s".format(eventPlayer.getHorizontalSpeed()), HudPosition.TOP, 2, Color.ORANGE, HudReeval.VISIBILITY_AND_STRING)
    eventPlayer.SpeedTag = getLastCreatedText()


rule"Velocity Counter (Yellow)":
    @Event eachPlayer
    @Condition eventPlayer.SettingRun
    @Condition eventPlayer.Spawned
    @Condition eventPlayer.getHorizontalSpeed() >= 13.15 
    @Condition eventPlayer.getHorizontalSpeed() < 17.2
    @Condition eventPlayer.getCurrentHero() == Hero.LUCIO
    destroyHudText(eventPlayer.SpeedTag)
    hudHeader(eventPlayer, l"{0} m/s".format(eventPlayer.getHorizontalSpeed()), HudPosition.TOP, 2, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING)
    eventPlayer.SpeedTag = getLastCreatedText()


rule"Velocity Counter (Green)":
    @Event eachPlayer
    @Condition eventPlayer.SettingRun
    @Condition eventPlayer.Spawned
    @Condition eventPlayer.getHorizontalSpeed() >= 17.2
    @Condition eventPlayer.getCurrentHero() == Hero.LUCIO
    destroyHudText(eventPlayer.SpeedTag)
    hudHeader(eventPlayer, l"{0} m/s".format(eventPlayer.getHorizontalSpeed()), HudPosition.TOP, 2, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING)
    eventPlayer.SpeedTag = getLastCreatedText()


rule"Cycle Auto Reset":
    @Event eachPlayer
    @Condition eventPlayer.SettingRun
    @Condition eventPlayer.Mode == 0
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE)
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
        return


rule"Auto Reset (Personal Best)":
    @Event eachPlayer
    @Condition eventPlayer.TimeCurrent > eventPlayer.TimeBest
    @Condition eventPlayer.Mode == 0
    @Condition eventPlayer.AutoReset == 1
    @Condition eventPlayer.TimeBest != TimeFirst
    if EndScreen:
        Sub0()
        return
    kill(eventPlayer, null)


rule"Auto Reset (Record)":
    @Event eachPlayer
    @Condition eventPlayer.TimeCurrent > TimeFirst
    @Condition eventPlayer.Mode == 0
    @Condition eventPlayer.AutoReset == 2
    if EndScreen:
        Sub0()
        return
    kill(eventPlayer, null)


rule"Practice Mode (Enabled)":
    @Event eachPlayer
    @Condition eventPlayer.SettingRun
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)
    @Condition eventPlayer.Mode == 0
    eventPlayer.Attempts = 0
    eventPlayer.Mode = 1
    createIcon(eventPlayer, eventPlayer.PosPracticeCheckpoint, Icon.FLAG, IconReeval.VISIBILITY_AND_POSITION, Color.GREEN, true)
    bigMessage(eventPlayer, "Entering Practice Mode")
    eventPlayer.setInvisibility(Invis.ALL)
    eventPlayer.clearStatusEffect(Status.PHASED_OUT)
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)


rule"Practice Mode (Button Held - Enabled)":
    @Event eachPlayer
    @Condition eventPlayer.SettingRun
    @Condition not eventPlayer.isHoldingButton(Button.INTERACT)
    @Condition eventPlayer.Mode == 1
    eventPlayer.Mode = 2


rule"Fire status (Enabled)":
    @Event eachPlayer
    @Condition eventPlayer.SettingRun
    @Condition eventPlayer.Mode <= 3
    @Condition eventPlayer.Mode >= 1
    eventPlayer.setStatusEffect(null, Status.BURNING, 9999)
    eventPlayer.setStatusEffect(null, Status.INVINCIBLE, 9999)


rule"Practice Mode (disabled)":
    @Event eachPlayer
    @Condition eventPlayer.SettingRun
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)
    @Condition eventPlayer.Mode == 2
    eventPlayer.Mode = 3


rule"Practice Mode(Button Held - disabled)":
    @Event eachPlayer
    @Condition eventPlayer.SettingRun
    @Condition not eventPlayer.isHoldingButton(Button.INTERACT)
    @Condition eventPlayer.Mode == 3
    destroyIcon(getLastCreatedEntity())
    eventPlayer.PosPracticeCheckpoint = 0
    bigMessage(eventPlayer, "Leaving Practice Mode")
    eventPlayer.Attempts = -1
    eventPlayer.Mode = 0
    if not eventPlayer.isOnGround() or eventPlayer.isOnGround() and (distance(PosStart, vect(eventPlayer.getPosition().x, PosStart.y, eventPlayer.getPosition().z)) <= 2 or distance(PosFinish, vect(eventPlayer.getPosition().x, PosFinish.y, eventPlayer.getPosition().z)) <= 5 or distance(PosCheckpoint, vect(eventPlayer.getPosition().x, PosCheckpoint.y, eventPlayer.getPosition().z)) <= 3.5):
        kill(eventPlayer, null)


rule"Fire status (Disabled)":
    @Event eachPlayer
    @Condition eventPlayer.SettingRun
    @Condition eventPlayer.Mode != 1
    @Condition eventPlayer.Mode != 2
    @Condition eventPlayer.Mode != 3
    eventPlayer.clearStatusEffect(Status.BURNING)
    eventPlayer.clearStatusEffect(Status.INVINCIBLE)


rule"Practice Checkpoints":
    @Event eachPlayer
    @Condition eventPlayer.SettingRun
    @Condition eventPlayer.Mode == 2
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE)
    eventPlayer.PosPracticeCheckpoint = eventPlayer.getPosition()
    eventPlayer.FacingPracticeCheckpoint = eventPlayer.getFacingDirection()
    eventPlayer.VelocityPracticeCheckpoint = eventPlayer.getVelocity()
    eventPlayer.SpeedPracticeCheckpoint = eventPlayer.getSpeed()
    smallMessage(eventPlayer, "Checkpoint Set")
    return


rule"Ult Reset Checkpoint":
    @Event eachPlayer
    @Condition eventPlayer.SettingRun
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition eventPlayer.Mode == 2
    kill(eventPlayer, null)
    eventPlayer.Attempts = eventPlayer.Attempts + 1


rule"Circle Fix":
    @Event eachPlayer
    @Condition distance(PosStart, eventPlayer) <= 2
    @Condition eventPlayer.isOnGround()
    @Condition eventPlayer.getHorizontalSpeed() <= 8.6
    stopChasingVariable(eventPlayer.TimeCurrent)
    eventPlayer.TimeCurrent = 0
    eventPlayer.Finished = false
    eventPlayer.Checkpoint = false
    eventPlayer.clearStatusEffect(Status.PHASED_OUT)
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)
    eventPlayer.setInvisibility(Invis.ALL)


rule"Player Hud Tag Verification":
    @Event eachPlayer
    @Condition eventPlayer.SettingRun
    @Condition eventPlayer.getCurrentHero() == Hero.LUCIO
    
    hudHeader([i for i in eventPlayer if eventPlayer.SettingRun], eventPlayer, HudPosition.LEFT, 0, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING)
    hudHeader(eventPlayer, l"{0} m/s".format(eventPlayer.getHorizontalSpeed()), HudPosition.TOP, 2, Color.RED, HudReeval.VISIBILITY_AND_STRING)
    eventPlayer.SpeedTag = getLastCreatedText()
    eventPlayer.Spawned = true


rule"End Screen":
    @Event global
    @Condition isGameInProgress()
    @Condition getMatchTime() < 20
    pauseMatchTime()
    EndScreen = true
    TimeArray = sorted(getAllPlayers(), key=lambda player: player.TimeBest)
    createInWorldText(getAllPlayers(), "QUALIFIED", PosSpawn, 2.5, Clip.SURFACES, HudReeval.STRING, Color.GREEN, SpecVisibility.DEFAULT)
    createInWorldText(getAllPlayers(), l"{0} - {1} - {2}".format("1", TimeArray[0], l"{0} sec".format(TimeArray[0].TimeBest)), vect(PosSpawn.x, PosSpawn.y - 0.3, PosSpawn.z), 2, Clip.SURFACES, HudReeval.STRING, Color.WHITE, SpecVisibility.DEFAULT)
    createInWorldText(getAllPlayers(), l"{0} - {1} - {2}".format("2", TimeArray[1], l"{0} sec".format(TimeArray[1].TimeBest)), vect(PosSpawn.x, PosSpawn.y - 0.6, PosSpawn.z), 2, Clip.SURFACES, HudReeval.STRING, Color.WHITE, SpecVisibility.DEFAULT)
    createInWorldText(getAllPlayers(), l"{0} - {1} - {2}".format("3", TimeArray[2], l"{0} sec".format(TimeArray[2].TimeBest)), vect(PosSpawn.x, PosSpawn.y - 0.9, PosSpawn.z), 2, Clip.SURFACES, HudReeval.STRING, Color.WHITE, SpecVisibility.DEFAULT)
    createInWorldText(getAllPlayers(), l"{0} - {1} - {2}".format("4", TimeArray[3], l"{0} sec".format(TimeArray[3].TimeBest)), vect(PosSpawn.x, PosSpawn.y - 1.2, PosSpawn.z), 2, Clip.SURFACES, HudReeval.STRING, Color.WHITE, SpecVisibility.DEFAULT)
    createInWorldText(getAllPlayers(), "ELIMINATED", vect(PosSpawn.x, PosSpawn.y - 1.8, PosSpawn.z), 2.5, Clip.SURFACES, HudReeval.STRING, Color.RED, SpecVisibility.DEFAULT)
    createInWorldText(getAllPlayers(), l"{0} - {1} - {2}".format("5", TimeArray[4], l"{0} sec".format(TimeArray[4].TimeBest)), vect(PosSpawn.x, PosSpawn.y - 2.1, PosSpawn.z), 2, Clip.SURFACES, HudReeval.STRING, Color.WHITE, SpecVisibility.DEFAULT)
    createInWorldText(getAllPlayers(), l"{0} - {1} - {2}".format("6", TimeArray[5], l"{0} sec".format(TimeArray[5].TimeBest)), vect(PosSpawn.x, PosSpawn.y - 2.4, PosSpawn.z), 2, Clip.SURFACES, HudReeval.STRING, Color.WHITE, SpecVisibility.DEFAULT)
    createInWorldText(getAllPlayers(), l"{0} - {1} - {2}".format("7", TimeArray[6], l"{0} sec".format(TimeArray[6].TimeBest)), vect(PosSpawn.x, PosSpawn.y - 2.7, PosSpawn.z), 2, Clip.SURFACES, HudReeval.STRING, Color.WHITE, SpecVisibility.DEFAULT)
    createInWorldText(getAllPlayers(), l"{0} - {1} - {2}".format("8", TimeArray[7], l"{0} sec".format(TimeArray[7].TimeBest)), vect(PosSpawn.x, PosSpawn.y - 3, PosSpawn.z), 2, Clip.SURFACES, HudReeval.STRING, Color.WHITE, SpecVisibility.DEFAULT)


rule"Respawn":
    @Event playerDied
    @Condition eventPlayer.SettingRun
    if eventPlayer.Mode == 0:
        if not eventPlayer.Finished:
            eventPlayer.Attempts += 1
        if eventPlayer.NewBest:
            eventPlayer.NewBest = false
            eventPlayer.Attempts = 0
        eventPlayer.teleport(PosStart)
        eventPlayer.resurrect()
        eventPlayer.setStatusEffect(null, Status.ROOTED, 0.5)
        return
    if eventPlayer.Mode == 1 or eventPlayer.Mode == 2 or eventPlayer.Mode == 3:
        if eventPlayer.PosPracticeCheckpoint == 0:
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


rule"Teleport to EndScreen if time too long":
    @Event eachPlayer
    @Condition EndScreen
    @Condition eventPlayer.TimeCurrent > 20
    Sub0()


rule"Teleport to EndScreen if in start zone":
    @Event eachPlayer
    @Condition EndScreen
    @Condition distance(eventPlayer, PosStart) < 3
    Sub0()


rule"EndScreen forbid spawn leave":
    @Event eachPlayer
    @Condition not eventPlayer.SettingRun
    @Condition not eventPlayer.isInSpawnRoom()
    eventPlayer.teleport(PosSpawn)


rule"Teleport to EndScreen if in practice mode":
    @Event eachPlayer
    @Condition EndScreen
    @Condition eventPlayer.Mode <= 3
    @Condition eventPlayer.Mode >= 1
    eventPlayer.clearStatusEffect(Status.BURNING)
    eventPlayer.clearStatusEffect(Status.INVINCIBLE)
    destroyIcon(getLastCreatedEntity())
    Sub0()


