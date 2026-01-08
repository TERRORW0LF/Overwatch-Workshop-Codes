rule "Death":
    @Event playerDied
    @Condition eventPlayer.Mode != 2
    
    eventPlayer.resurrect()
    async(Respawn, AsyncBehavior.NOOP)


rule "Last Frame Data - 1":
    @Event eachPlayer
    @Condition not eventPlayer.Timing

    eventPlayer.Skip = false


rule "Last Frame Data - 2":
    @Event eachPlayer
    @Condition eventPlayer.Timing

    eventPlayer.PosPrev = eventPlayer.PosNow
    eventPlayer.SpeedPrev = eventPlayer.SpeedNow
    eventPlayer.TimePrev = eventPlayer.TimeNow
    eventPlayer.PosNow = eventPlayer.getPosition()
    eventPlayer.SpeedNow = eventPlayer.getHorizontalSpeed()
    eventPlayer.TimeNow = getMatchTime()
    eventPlayer.Timing = not eventPlayer.Timing
    eventPlayer.Skip = true


rule "Last Frame Data - 3":
    @Event eachPlayer
    @Condition not eventPlayer.Timing
    @Condition not eventPlayer.Skip

    eventPlayer.PosPrev = eventPlayer.PosNow
    eventPlayer.SpeedPrev = eventPlayer.SpeedNow
    eventPlayer.TimePrev = eventPlayer.TimeNow
    eventPlayer.PosNow = eventPlayer.getPosition()
    eventPlayer.SpeedNow = eventPlayer.getHorizontalSpeed()
    eventPlayer.TimeNow = getMatchTime()
    eventPlayer.Timing = not eventPlayer.Timing


rule "Finish Message (Best Time)":
    @Event eachPlayer
    @Condition eventPlayer.Finished
    @Condition eventPlayer.NewBest
    @Condition (eventPlayer.Category == 0 and eventPlayer != PlayerFirstStan) or (eventPlayer.Category == 1 and eventPlayer != PlayerFirstGrav)
    
    bigMessage(eventPlayer, "New PB: {0}.{1} sec".format(floor((eventPlayer.TimeBestStan if eventPlayer.Category == 0 else eventPlayer.TimeBestGrav) + 0.001 / 1000), "{0}".format(floor((1000 * (eventPlayer.TimeBestStan if eventPlayer.Category == 0 else eventPlayer.TimeBestGrav) + 0.001)) % 1000 + 1000).substring(1, 3)))


rule "Finish Message (Record Time)":
    @Event eachPlayer
    @Condition eventPlayer.Finished
    @Condition eventPlayer.NewBest
    @Condition (eventPlayer.Category == 0 and eventPlayer == PlayerFirstStan) or (eventPlayer.Category == 1 and eventPlayer == PlayerFirstGrav)
    
    bigMessage([player for player in getAllPlayers() if player.Category == eventPlayer.Category], "New Record: {0}.{1} sec - {2}!!!".format(floor((eventPlayer.TimeBestStan if eventPlayer.Category == 0 else eventPlayer.TimeBestGrav) + 0.001 / 1000), "{0}".format(floor((1000 * (eventPlayer.TimeBestStan if eventPlayer.Category == 0 else eventPlayer.TimeBestGrav) + 0.001)) % 1000 + 1000).substring(1, 3), eventPlayer))


rule "Velocity Counter - Standard (Green)":
    @Event eachPlayer
    @Condition eventPlayer.Category == 0
    @Condition eventPlayer.getHorizontalSpeed() > 13.75

    eventPlayer.SpeedColor = Color.GREEN
    
    
rule "Velocity Counter - Standard (Yellow)":
    @Event eachPlayer
    @Condition eventPlayer.Category == 0
    @Condition eventPlayer.getHorizontalSpeed() > 11
    @Condition eventPlayer.getHorizontalSpeed() < 13.75

    eventPlayer.SpeedColor = Color.YELLOW


rule "Velocity Counter - Standard (Orange)":
    @Event eachPlayer
    @Condition eventPlayer.Category  == 0
    @Condition eventPlayer.getHorizontalSpeed() > 6.88
    @Condition eventPlayer.getHorizontalSpeed() < 11

    eventPlayer.SpeedColor = Color.ORANGE
    
    
rule "Velocity Counter - Standard (Red)":
    @Event eachPlayer
    @Condition eventPlayer.Category == 0
    @Condition eventPlayer.getHorizontalSpeed() <= 6.88
    
    eventPlayer.SpeedColor = Color.RED


rule "Velocity Counter - Gravspeed (Green)":
    @Event eachPlayer
    @Condition eventPlayer.Category == 1
    @Condition eventPlayer.getHorizontalSpeed() > 17.2

    eventPlayer.SpeedColor = Color.GREEN


rule "Velocity Counter - Gravspeed (Yellow)":
    @Event eachPlayer
    @Condition eventPlayer.Category == 1
    @Condition eventPlayer.getHorizontalSpeed() > 13.15
    @Condition eventPlayer.getHorizontalSpeed() < 17.2

    eventPlayer.SpeedColor = Color.YELLOW


rule "Velocity Counter - Gravspeed (Orange)":
    @Event eachPlayer
    @Condition eventPlayer.Category == 1
    @Condition eventPlayer.getHorizontalSpeed() > 8.6
    @Condition eventPlayer.getHorizontalSpeed() < 13.15

    eventPlayer.SpeedColor = Color.ORANGE


rule "Velocity Counter - Gravspeed (Red)":
    @Event eachPlayer
    @Condition eventPlayer.Category == 1
    @Condition eventPlayer.getHorizontalSpeed() <= 8.6
    
    eventPlayer.SpeedColor = Color.RED


rule "Vote Map Skip":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.CROUCH) and eventPlayer.isHoldingButton(Button.SECONDARY_FIRE)
    @Condition not eventPlayer.ExecutingMenu

    eventPlayer.ExecutingMenu = true
    eventPlayer.SkipMap = not eventPlayer.SkipMap
    waitUntil(not eventPlayer.isHoldingButton(Button.SECONDARY_FIRE), 9999)
    eventPlayer.ExecutingMenu = false


rule "Toggle Invisibility (Host only)":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.RELOAD) and eventPlayer.isHoldingButton(Button.CROUCH)
    @Condition eventPlayer == hostPlayer
    @Condition not eventPlayer.ExecutingMenu
    
    eventPlayer.ExecutingMenu = true
    if Visible:
        smallMessage(eventPlayer, l"{0} {1}".format(l"Players", l"Invisible"))
        getAllPlayers().setInvisibility(Invis.ALL)
        Visible = false
    else:
        smallMessage(eventPlayer, "{0} {1}".format(l"Players", l"Visible"))
        ([player for player in getAllPlayers() if not player.Mode and not (distance(PosStart, vect(player.getPosition().x, PosStart.y, player.getPosition().z)) <= 2 and abs(player.getPosition().y - PosStart.y) <= 3)]).setInvisibility(Invis.NONE)
        Visible = true
    waitUntil(not eventPlayer.isHoldingButton(Button.RELOAD), 9999)
    eventPlayer.ExecutingMenu = false


rule "Cycle HUD":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) and eventPlayer.isHoldingButton(Button.CROUCH)
    @Condition not eventPlayer.ExecutingMenu
    
    eventPlayer.ExecutingMenu = true
    if eventPlayer.HideHud == 0:
        eventPlayer.HideHud++
    elif eventPlayer.HideHud == 1:
        eventPlayer.disableHeroHUD()
        eventPlayer.HideHud++
    else:
        eventPlayer.enableHeroHud()
        eventPlayer.HideHud = 0
    waitUntil(not eventPlayer.isHoldingButton(Button.INTERACT), 9999)
    eventPlayer.ExecutingMenu = false


rule "Curveboost Prevention":
    @Event eachPlayer
    @Condition updateEveryTick(eventPlayer.isOnWall())

    eventPlayer.SpeedWall = max(eventPlayer.SpeedNow, 8.53 if eventPlayer.Category == 0 else 10.66)

    while true:
        eventPlayer.SpeedDiff = eventPlayer.SpeedNow - eventPlayer.SpeedWall
        if eventPlayer.isOnWall() and eventPlayer.SpeedDiff > 0.01:
            printLog("{0}".format(eventPlayer.SpeedPrev))
            printLog("{0}".format(eventPlayer.SpeedNow))
            printLog("{0}".format(eventPlayer.SpeedDiff))
            eventPlayer.applyImpulse(
                directionTowards(vect(eventPlayer.PosNow.x, eventPlayer.PosPrev.y, eventPlayer.PosNow.z), eventPlayer.PosPrev), 
                eventPlayer.SpeedDiff, 
                Relativity.TO_WORLD,
                Impulse.INCORPORATE_CONTRARY_MOTION
            )
        wait(0.016, Wait.ABORT_WHEN_FALSE)
    
    
rule "Match Time Frozen":
    @Condition isGameInProgress()
    @Condition Infinite
    @Condition getMatchTime() < 10
    
    wait()
    setMatchTime(Time + 10)


rule "Skip Map":
    @Condition len([player for player in getAllPlayers() if player.SkipMap]) >= VoteMin
    @Condition len([player for player in getAllPlayers() if player.SkipMap]) / len(getAllPlayers()) * 100 >= VotePerc - 0.01

    waitUntil(VoteTimer > 35, 9999)
    restartMatch()


rule "End Match FFA":
    @Condition getCurrentGamemode() == Gamemode.FFA
    @Condition isGameInProgress()
    @Condition getMatchTime() == 0

    restartMatch()


def Respawn():
    @Name "Respawn"
    
    if eventPlayer.Mode <= 1:
        if eventPlayer.PracticeCheckpoint:
            eventPlayer.setFacing(eventPlayer.FacingPracticeCheckpoint, Relativity.TO_WORLD)
            if eventPlayer.SpeedPracticeCheckpoint:
                eventPlayer.Attempts += 1
                eventPlayer.teleport(eventPlayer.PosPracticeCheckpoint)
                eventPlayer.applyImpulse(eventPlayer.getVelocity() * -0.001, 0.001, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
                eventPlayer.applyImpulse(eventPlayer.VelocityPracticeCheckpoint, eventPlayer.SpeedPracticeCheckpoint, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
                stopChasingVariable(eventPlayer.TimeCurrent)
                eventPlayer.TimeCurrent = 0
                eventPlayer.TimeExtra = 0
                chase(eventPlayer.TimeCurrent, 5000, rate=1, ChaseReeval.NONE)
                return
        eventPlayer.Reset = true
        wait()
        eventPlayer.Reset = false
        if not eventPlayer.Finished:
            eventPlayer.Attempts += 1
        if eventPlayer.NewBest:
            eventPlayer.NewBest = false
            eventPlayer.Attempts = 0
    eventPlayer.disallowButton(Button.JUMP)
    if eventPlayer.Mode == 1 and eventPlayer.PracticeCheckpoint:
        eventPlayer.teleport(eventPlayer.PosPracticeCheckpoint)
    else:
        eventPlayer.teleport(PosStart)
    eventPlayer.applyImpulse(eventPlayer.getVelocity() * -0.001, 0.001, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.applyImpulse(eventPlayer.getVelocity() * 0.001, 0.001, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
    eventPlayer.setStatusEffect(null, Status.ROOTED, 0.5)
    waitUntil(distance(eventPlayer.getPosition(), PosStart) < 1, 0.4)
    eventPlayer.Finished = false
    for eventPlayer.CheckpointLoop in range(0, len(eventPlayer.Checkpoint)):
        eventPlayer.Checkpoint[eventPlayer.CheckpointLoop] = false
    if eventPlayer.Mode > 1:
        eventPlayer.Attempts = -1
        eventPlayer.Mode = 0
        if eventPlayer.Category == 0:
            eventPlayer.setGravity(100)
            eventPlayer.setMoveSpeed(100)
        elif eventPlayer.Category == 1:
            eventPlayer.setGravity(80)
            eventPlayer.setMoveSpeed(125)

