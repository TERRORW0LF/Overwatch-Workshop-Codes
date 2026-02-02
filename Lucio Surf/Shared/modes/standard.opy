rule "Start timer":
    @Event eachPlayer
    @Condition not eventPlayer.Mode or (eventPlayer.Mode == 1 and not eventPlayer.PracticeCheckpoint)
    @Condition not any([checkpoint for checkpoint in eventPlayer.Checkpoint]) or eventPlayer.Mode == 1
    @Condition updateEveryTick(distance(PosStart, vect(eventPlayer.getPosition().x, PosStart.y, eventPlayer.getPosition().z)) > 2 or abs(eventPlayer.getPosition().y - PosStart.y) > 3)
    
    chase(eventPlayer.TimeCurrent, 5000, rate=1, ChaseReeval.NONE)
    eventPlayer.TimeExtra = -9999
    eventPlayer.TimeExtra2 = -9999
    eventPlayer.TimeDiff = eventPlayer.TimePrev - eventPlayer.TimeNow
    if eventPlayer.TimeDiff > 0.05 or eventPlayer.TimeDiff < 0:
        smallMessage(eventPlayer, "Package loss too high")
        async(Respawn, AsyncBehavior.NOOP)
        return

    /*2 methods of starting timer: either further than 2 m away, or more than 3 m up. Start is a cylinder.*/
    if distance(vect(eventPlayer.PosPrev.x, PosStart.y, eventPlayer.PosPrev.z), PosStart) <= 2 and distance(vect(eventPlayer.PosNow.x, PosStart.y, eventPlayer.PosNow.z), PosStart) > 2:
        /*Get angle between the travel line and (1, 0, 0) and add 180°. I don't know why the 180°s are necessary, but they are.*/
        eventPlayer.Angle = horizontalAngleOfDirection(Vector.RIGHT) + horizontalAngleOfDirection(vect(eventPlayer.PosNow.x - eventPlayer.PosPrev.x, 0, eventPlayer.PosNow.z - eventPlayer.PosPrev.z))
        /*Translate the travel line so that PosStart is considered the origin, then rotate by the calculated angle.
          This will result in the travel line being of the from y = c, with c being the z-coordinate of a point on the line.
          For optimization purposes only PosNow gets transformed, bc we know that the slope is 0.*/
        eventPlayer.PosNorm = vect((eventPlayer.PosPrev.x - PosStart.x) * cosDeg(eventPlayer.Angle) - (eventPlayer.PosPrev.z - PosStart.z) * sinDeg(eventPlayer.Angle), 0, (eventPlayer.PosPrev.x - PosStart.x) * sinDeg(eventPlayer.Angle) + (eventPlayer.PosPrev.z - PosStart.z) * cosDeg(eventPlayer.Angle))
        /*calculate extra time with
            0.016 - (1/speed) x
          with x being the dinstance between PosNow and the intersection of the travel line and the start circle (x^2 + c^2 = r^2 => x = sqrt(r^2 - c^2).
          This formula is a near perfect approximation for the actual formula in the relevant area (0 <= y <= 0.016).
          The rotation leaves the intersect and posNow always in the positive for x, with PosNow.x >= sqrt(...).*/
        eventPlayer.TimeExtra = eventPlayer.TimeDiff - (sqrt(4 - eventPlayer.PosNorm.z*eventPlayer.PosNorm.z) - eventPlayer.PosNorm.x) / eventPlayer.SpeedPrev

    if eventPlayer.PosNow.y - PosStart.y > 3 and eventPlayer.PosPrev.y - PosStart.y <= 3:
        /*Crude approximation with disregard to speed. This case will not happen in 99% of the starts.*/
        eventPlayer.TimeExtra2 = eventPlayer.TimeDiff * ((eventPlayer.PosNow.y - PosStart.y - 3) / (eventPlayer.PosNow.y - eventPlayer.PosPrev.y))
    /*If both cases happen chose the higher extra time.*/

    eventPlayer.TimeExtra = max(eventPlayer.TimeExtra, eventPlayer.TimeExtra2)
    eventPlayer.TimeCurrent += eventPlayer.TimeExtra

    if not Visible or eventPlayer.Mode == 1:
        return
    eventPlayer.setInvisibility(Invis.NONE)


rule "Checkpoint":
    @Event eachPlayer
    @Condition Checkpoint
    @Condition not eventPlayer.Finished
    @Condition eventPlayer.Mode <= 1
    @Condition updateEveryTick(any([distance(checkpoint, vect(eventPlayer.getPosition().x, checkpoint.y, eventPlayer.getPosition().z)) <= 3.5 and eventPlayer.getPosition().y >= checkpoint.y for checkpoint in PosCheckpoint]))
    
    eventPlayer.CurrCheckpoint = PosCheckpoint.index([checkpoint for checkpoint in PosCheckpoint if distance(checkpoint, vect(eventPlayer.getPosition().x, checkpoint.y, eventPlayer.getPosition().z)) <= 3.5 and eventPlayer.getPosition().y >= checkpoint.y][0])
    
    if eventPlayer.CurrCheckpoint == -1:
        return
    
    if eventPlayer.Mode == 0:
        if eventPlayer.TimeCurrent < 0.1:
            smallMessage(eventPlayer, "No timer start.")
            async(Respawn, AsyncBehavior.NOOP)
            return
        
        if eventPlayer.Checkpoint[eventPlayer.CurrCheckpoint]:
            smallMessage(eventPlayer, "Checkpoint already collected")
            return

        eventPlayer.Checkpoint[eventPlayer.CurrCheckpoint] = true
        
    eventPlayer.TimeExtra = 9999
    eventPlayer.TimeExtra2 = 9999
    eventPlayer.TimeDiff = eventPlayer.TimePrev - eventPlayer.TimeNow
    if eventPlayer.TimeDiff > 0.05 or eventPlayer.TimeDiff < 0:
        smallMessage(eventPlayer, "Package loss too high")
        return

    eventPlayer.CurrCheckpoint = PosCheckpoint[eventPlayer.CurrCheckpoint]

    if distance(vect(eventPlayer.PosPrev.x, eventPlayer.CurrCheckpoint.y, eventPlayer.PosPrev.z), eventPlayer.CurrCheckpoint) > 3.5 and distance(vect(eventPlayer.PosNow.x, eventPlayer.CurrCheckpoint.y, eventPlayer.PosNow.z), eventPlayer.CurrCheckpoint) <= 3.5:
    /*Get angle between the travel line and (-1, 0, 0) (OW's coordinate system is left handed).*/
        eventPlayer.Angle = horizontalAngleOfDirection(Vector.RIGHT) + horizontalAngleOfDirection(vect(eventPlayer.PosNow.x - eventPlayer.PosPrev.x, 0, eventPlayer.PosNow.z - eventPlayer.PosPrev.z))
        /*Translate the travel line so that PosFinish is considered the origin, then rotate by the calculated angle.
        This will result in the travel line being of the from y = c, with c being the z-coordinate of a point on the line.
        For optimization purposes only PosPrev gets transformed, bc we know that the slope is 0.*/
        eventPlayer.PosNorm = vect((eventPlayer.PosPrev.x - eventPlayer.CurrCheckpoint.x) * cosDeg(eventPlayer.Angle) - (eventPlayer.PosPrev.z - eventPlayer.CurrCheckpoint.z) * sinDeg(eventPlayer.Angle), 0, (eventPlayer.PosPrev.x - eventPlayer.CurrCheckpoint.x) * sinDeg(eventPlayer.Angle) + (eventPlayer.PosPrev.z - eventPlayer.CurrCheckpoint.z) * cosDeg(eventPlayer.Angle))
        /*calculate extra time with
            (1/speed) x
        with x being the dinstance between PosPrev and the intersection of the travel line and the start circle (x^2 + c^2 = r^2 => x = sqrt(r^2 - c^2).
        This formula is a near perfect approximation for the actual formula in the relevant area (0 <= y <= 0.016).
        The rotation leaves the intersect always in the negative. Sqrt(...) returns the positive intersection point.
        We therefore need the negative of the root to get an accureate result [0.016 - (-sqrt(...) - PosNorm.x) / SpeedPrev => 0.016 + (sqrt(...) + PosNorm.x) / SpeedPrev].
        PosNorm.x <= -sqrt(...)*/
        eventPlayer.TimeExtra = eventPlayer.TimeDiff + (sqrt(12.25 - eventPlayer.PosNorm.z*eventPlayer.PosNorm.z) + eventPlayer.PosNorm.x) / eventPlayer.SpeedPrev

    if eventPlayer.PosNow.y >= eventPlayer.CurrCheckpoint.y and eventPlayer.PosPrev.y < eventPlayer.CurrCheckpoint.y:
        /*Crude approximation with disregard to speed. This case will not happen in 99% of the starts.*/
        eventPlayer.TimeExtra2 = eventPlayer.TimeDiff * ((eventPlayer.PosNow.y - eventPlayer.CurrCheckpoint.y) / (eventPlayer.PosNow.y - eventPlayer.PosPrev.y))

    /*If both cases happen chose the higher extra time.*/
    eventPlayer.TimeExtra = min(eventPlayer.TimeExtra, eventPlayer.TimeExtra2)
    eventPlayer.TimeExtra = eventPlayer.TimeCurrent - eventPlayer.TimeExtra

    if eventPlayer.Mode == 1:
        smallMessage(eventPlayer, "{0}.{1} sec".format(floor(eventPlayer.TimeExtra + 0.001 / 1000), "{0}".format(floor((1000 * eventPlayer.TimeExtra + 0.001)) % 1000 + 1000).substring(1, 4)))
        return

    if all([checkpoint for checkpoint in eventPlayer.Checkpoint]):
        smallMessage(eventPlayer, l"{0} - {1}".format(l"{0} {1}".format(l"Finish", l"Unlocked"), "{0}.{1} sec".format(floor(eventPlayer.TimeExtra + 0.001 / 1000), "{0}".format(floor((1000 * eventPlayer.TimeExtra + 0.001)) % 1000 + 1000).substring(1, 4))))
        return
    
    smallMessage(eventPlayer, l"{0}: {1}".format(l"Checkpoints", "{0}/{1} - {2}".format(len([checkpoint for checkpoint in eventPlayer.Checkpoint if checkpoint]), len(PosCheckpoint), "{0}.{1} sec".format(floor(eventPlayer.TimeExtra + 0.001 / 1000), "{0}".format(floor((1000 * eventPlayer.TimeExtra + 0.001)) % 1000 + 1000).substring(1, 4)))))


rule "Checkpoint (no LoS)":
    @Event eachPlayer
    @Condition Checkpoint
    @Condition not eventPlayer.Finished
    @Condition eventPlayer.Mode <= 1
    @Condition any([distance(checkpoint, vect(eventPlayer.getPosition().x, checkpoint.y, eventPlayer.getPosition().z)) <= 3.5 and eventPlayer.getPosition().y < checkpoint.y for checkpoint in PosCheckpoint])
    
    eventPlayer.CurrCheckpoint = PosCheckpoint.index([checkpoint for checkpoint in PosCheckpoint if distance(checkpoint, vect(eventPlayer.getPosition().x, checkpoint.y, eventPlayer.getPosition().z)) <= 3.5 and eventPlayer.getPosition().y < checkpoint.y][0])
    if (eventPlayer.CurrCheckpoint == -1 or eventPlayer.Checkpoint[eventPlayer.CurrCheckpoint]):
        return

    smallMessage(eventPlayer, l"{0} {1}".format(l"Checkpoint", l"Out of View"))


rule "Finish":
    @Event eachPlayer
    @Condition all([checkpoint for checkpoint in eventPlayer.Checkpoint]) or eventPlayer.Mode == 1
    @Condition not eventPlayer.Finished
    @Condition eventPlayer.Mode <= 1
    @Condition updateEveryTick(distance(PosFinish, vect(eventPlayer.getPosition().x, PosFinish.y, eventPlayer.getPosition().z)) <= 5)
    @Condition updateEveryTick(eventPlayer.getPosition().y >= PosFinish.y)
    @Condition eventPlayer.FFAReset
    
    if eventPlayer.Mode == 1:
        stopChasingVariable(eventPlayer.TimeCurrent)
        return

    if eventPlayer.TimeCurrent < 0.1:
        smallMessage(eventPlayer, "No timer start")
        async(Respawn, AsyncBehavior.NOOP)
        return

    stopChasingVariable(eventPlayer.TimeCurrent)
    eventPlayer.Attempts += 1
    eventPlayer.TimeExtra = 9999
    eventPlayer.TimeExtra2 = 9999
    eventPlayer.TimeDiff = eventPlayer.TimePrev - eventPlayer.TimeNow
    if eventPlayer.TimeDiff > 0.05 or eventPlayer.TimeDiff < 0:
        smallMessage(eventPlayer, "Package loss too high")
        async(Respawn, AsyncBehavior.NOOP)
        return

    if distance(vect(eventPlayer.PosPrev.x, PosFinish.y, eventPlayer.PosPrev.z), PosFinish) > 5 and distance(vect(eventPlayer.PosNow.x, PosFinish.y, eventPlayer.PosNow.z), PosFinish) <= 5:
    /*Get angle between the travel line and (-1, 0, 0) (OW's coordinate system is left handed).*/
        eventPlayer.Angle = horizontalAngleOfDirection(Vector.RIGHT) + horizontalAngleOfDirection(vect(eventPlayer.PosNow.x - eventPlayer.PosPrev.x, 0, eventPlayer.PosNow.z - eventPlayer.PosPrev.z))
        /*Translate the travel line so that PosFinish is considered the origin, then rotate by the calculated angle.
        This will result in the travel line being of the from y = c, with c being the z-coordinate of a point on the line.
        For optimization purposes only PosPrev gets transformed, bc we know that the slope is 0.*/
        eventPlayer.PosNorm = vect((eventPlayer.PosPrev.x - PosFinish.x) * cosDeg(eventPlayer.Angle) - (eventPlayer.PosPrev.z - PosFinish.z) * sinDeg(eventPlayer.Angle), 0, (eventPlayer.PosPrev.x - PosFinish.x) * sinDeg(eventPlayer.Angle) + (eventPlayer.PosPrev.z - PosFinish.z) * cosDeg(eventPlayer.Angle))
        /*calculate extra time with
            (1/speed) x
        with x being the dinstance between PosPrev and the intersection of the travel line and the start circle (x^2 + c^2 = r^2 => x = sqrt(r^2 - c^2).
        This formula is a near perfect approximation for the actual formula in the relevant area (0 <= y <= 0.016).
        The rotation leaves the intersect always in the negative. Sqrt(...) returns the positive intersection point.
        We therefore need the negative of the root to get an accureate result [0.016 - (-sqrt(...) - PosNorm.x) / SpeedPrev => 0.016 + (sqrt(...) + PosNorm.x) / SpeedPrev].
        PosNorm.x <= -sqrt(...)*/
        eventPlayer.TimeExtra = eventPlayer.TimeDiff + (sqrt(25 - eventPlayer.PosNorm.z*eventPlayer.PosNorm.z) + eventPlayer.PosNorm.x) / eventPlayer.SpeedPrev

    if eventPlayer.PosNow.y >= PosFinish.y and eventPlayer.PosPrev.y < PosFinish.y:
        /*Crude approximation with disregard to speed. This case will not happen in 99% of the starts.*/
        eventPlayer.TimeExtra2 = eventPlayer.TimeDiff * ((eventPlayer.PosNow.y - PosFinish.y) / (eventPlayer.PosNow.y - eventPlayer.PosPrev.y))

    /*If both cases happen chose the higher extra time.*/
    eventPlayer.TimeExtra = min(eventPlayer.TimeExtra, eventPlayer.TimeExtra2)
    eventPlayer.TimeCurrent -= eventPlayer.TimeExtra

    if eventPlayer.Category == 0:
        if eventPlayer.TimeCurrent < eventPlayer.TimeBestStan:
            if eventPlayer.TimeCurrent < TimeThirdStan and eventPlayer != PlayerSecondStan and eventPlayer != PlayerFirstStan:
                TimeThirdStan = eventPlayer.TimeCurrent
                PlayerThirdStan = eventPlayer
            if eventPlayer.TimeCurrent < TimeSecondStan and eventPlayer != PlayerFirstStan:
                if eventPlayer != PlayerSecondStan:
                    TimeThirdStan = TimeSecondStan
                    PlayerThirdStan = PlayerSecondStan
                TimeSecondStan = eventPlayer.TimeCurrent
                PlayerSecondStan = eventPlayer
            if eventPlayer.TimeCurrent < TimeFirstStan:
                if eventPlayer != PlayerFirstStan:
                    TimeSecondStan = TimeFirstStan
                    PlayerSecondStan = PlayerFirstStan
                TimeFirstStan = eventPlayer.TimeCurrent
                PlayerFirstStan = eventPlayer
            eventPlayer.TimeBestStan = eventPlayer.TimeCurrent
            eventPlayer.NewBest = true
        else:
            bigMessage(eventPlayer, l"{0}!!!".format(l"Finished"))

    elif eventPlayer.Category == 1:
        if eventPlayer.TimeCurrent < eventPlayer.TimeBestGrav:
            if eventPlayer.TimeCurrent < TimeThirdGrav and eventPlayer != PlayerSecondGrav and eventPlayer != PlayerFirstGrav:
                TimeThirdGrav = eventPlayer.TimeCurrent
                PlayerThirdGrav = eventPlayer
            if eventPlayer.TimeCurrent < TimeSecondGrav and eventPlayer != PlayerFirstGrav:
                if eventPlayer != PlayerSecondGrav:
                    TimeThirdGrav = TimeSecondGrav
                    PlayerThirdGrav = PlayerSecondGrav
                TimeSecondGrav = eventPlayer.TimeCurrent
                PlayerSecondGrav = eventPlayer
            if eventPlayer.TimeCurrent < TimeFirstGrav:
                if eventPlayer != PlayerFirstGrav:
                    TimeSecondGrav = TimeFirstGrav
                    PlayerSecondGrav = PlayerFirstGrav
                TimeFirstGrav = eventPlayer.TimeCurrent
                PlayerFirstGrav = eventPlayer
            eventPlayer.TimeBestGrav = eventPlayer.TimeCurrent
            eventPlayer.NewBest = true
        else:
            bigMessage(eventPlayer, l"{0}!!!".format(l"Finished"))
    /*This wait is needed so that the "Finish Messages" rules announce the correct player. Otherwise the messages would have the old player's name in them instead.*/
    wait()
    eventPlayer.Finished = true


rule "Finish (no LoS)":
    @Event eachPlayer
    @Condition not eventPlayer.Finished
    @Condition eventPlayer.Mode <= 1
    @Condition distance(PosFinish, vect(eventPlayer.getPosition().x, PosFinish.y, eventPlayer.getPosition().z)) <= 5
    @Condition eventPlayer.getPosition().y < PosFinish.y

    smallMessage(eventPlayer, l"{0} {1}".format(l"Finish", l"Out of View"))


rule "Finish (no Checkpoint)":
    @Event eachPlayer
    @Condition not all([checkpoint for checkpoint in eventPlayer.Checkpoint])
    @Condition not eventPlayer.Finished
    @Condition not eventPlayer.Mode
    @Condition distance(PosFinish, vect(eventPlayer.getPosition().x, PosFinish.y, eventPlayer.getPosition().z)) <= 5
    @Condition eventPlayer.getPosition().y >= PosFinish.y

    bigMessage(eventPlayer, l"{0} {1}".format(l"No", l"Checkpoint"))


rule "Floor":
    @Event eachPlayer
    @Condition eventPlayer.isOnGround()
    @Condition not eventPlayer.Mode
    @Condition distance(PosStart, vect(eventPlayer.getPosition().x, PosStart.y, eventPlayer.getPosition().z)) > 4
    @Condition distance(PosFinish, vect(eventPlayer.getPosition().x, PosFinish.y, eventPlayer.getPosition().z)) > 6
    @Condition not any([distance(checkpoint, vect(eventPlayer.getPosition().x, checkpoint.y, eventPlayer.getPosition().z)) <= 6 for checkpoint in PosCheckpoint]) or not Checkpoint
    
    async(Respawn, AsyncBehavior.NOOP)


rule "Ult Reset":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition not eventPlayer.Mode
    
    async(Respawn, AsyncBehavior.NOOP)


rule "Barrier":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 0
    @Condition any([distance(eventPlayer, barrier) <= 5 or distance(eventPlayer.getEyePosition(), barrier) <= 5 for barrier in PosBarrier])

    async(Respawn, AsyncBehavior.NOOP)


rule "Cycle Auto Reset":
    @Event eachPlayer
    @Condition not eventPlayer.Mode
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2) 
    @Condition eventPlayer.isHoldingButton(Button.CROUCH)
    @Condition not eventPlayer.ExecutingMenu
    
    eventPlayer.ExecutingMenu = true
    eventPlayer.AutoReset += 1
    if eventPlayer.AutoReset == 3:
        eventPlayer.AutoReset = 0
    if not eventPlayer.AutoReset:
        smallMessage(eventPlayer, "Auto Reset - Disabled")
    elif eventPlayer.AutoReset == 1:
        smallMessage(eventPlayer, "Auto Reset - Personal Best")
    elif eventPlayer.AutoReset == 2:
        smallMessage(eventPlayer, "Auto Reset - Record")
    waitUntil(not eventPlayer.isHoldingButton(Button.ABILITY_2), 9999)
    eventPlayer.ExecutingMenu = false


rule "Auto Reset (Personal Best)":
    @Event eachPlayer
    @Condition not eventPlayer.Mode
    @Condition eventPlayer.AutoReset == 1
    @Condition eventPlayer.TimeCurrent > (eventPlayer.TimeBestStan if eventPlayer.Category == 0 else eventPlayer.TimeBestGrav)
    
    smallMessage(eventPlayer, "Reset by 'Auto Reset'")
    async(Respawn, AsyncBehavior.NOOP)


rule "Auto Reset (Record)":
    @Event eachPlayer
    @Condition not eventPlayer.Mode
    @Condition eventPlayer.AutoReset == 2
    @Condition eventPlayer.TimeCurrent > (TimeFirstStan if eventPlayer.Category == 0 else TimeFirstGrav)
    
    smallMessage(eventPlayer, "Reset by 'Auto Reset'")
    async(Respawn, AsyncBehavior.NOOP)


rule "Cycle Category":
    @Event eachPlayer
    @Condition not eventPlayer.Mode
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)
    @Condition eventPlayer.isHoldingButton(Button.CROUCH)
    @Condition not eventPlayer.ExecutingMenu

    eventPlayer.ExecutingMenu = true
    eventPlayer.Category += 1
    if eventPlayer.Category > 1:
        eventPlayer.Category = 0
    if eventPlayer.Category == 0:
        eventPlayer.setMoveSpeed(100)
        eventPlayer.setGravity(100)
        smallMessage(eventPlayer, "Now playing Standard")
    elif eventPlayer.Category == 1:
        eventPlayer.setMoveSpeed(125)
        eventPlayer.setGravity(80)
        smallMessage(eventPlayer, "Now playing Gravspeed")
    async(Respawn(), AsyncBehavior.NOOP)
    wait(0.2, Wait.IGNORE_CONDITION)
    eventPlayer.allowButton(Button.JUMP)
    waitUntil(not eventPlayer.isHoldingButton(Button.INTERACT), 9999)
    eventPlayer.ExecutingMenu = false


rule "Circle Fix":
    @Event eachPlayer
    @Condition updateEveryTick(distance(PosStart, vect(eventPlayer.getPosition().x, PosStart.y, eventPlayer.getPosition().z)) <= 2)
    @Condition updateEveryTick(abs(eventPlayer.getPosition().y - PosStart.y) <= 3)
    @Condition eventPlayer.isOnGround()
    @Condition not eventPlayer.Reset
    @Condition eventPlayer.Mode <= 1
    @Condition not eventPlayer.PracticeCheckpoint
    @Condition not any([checkpoint for checkpoint in eventPlayer.Checkpoint])
    @Condition updateEveryTick((eventPlayer.Category == 0 and eventPlayer.getHorizontalSpeed() <= 6.88) or (eventPlayer.Category == 1 and eventPlayer.getHorizontalSpeed() <= 8.6))
    
    stopChasingVariable(eventPlayer.TimeCurrent)
    eventPlayer.TimeCurrent = 0
    eventPlayer.setInvisibility(Invis.ALL)
    wait(0.05)
    eventPlayer.allowButton(Button.JUMP)

