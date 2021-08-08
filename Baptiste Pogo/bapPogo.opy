playervar speed 0
playervar velocity 1
playervar raycastHitpos 2
playervar distRayhitPlayerfoot 3
playervar distRayhitPlayereye 4
playervar addedSpeed 5
playervar practiceRaycastHitpos 6
playervar mode 15
playervar shotsFired 16


#========== OG idea by ĴewelƁutt ==========
rule "Pogo":
    @Event eachPlayer
    @Condition eventPlayer.isFiringSecondaryFire() == true
    
    eventPlayer.speed = eventPlayer.getHorizontalSpeed()
    eventPlayer.velocity = eventPlayer.getVelocity()
    eventPlayer.raycastHitpos = raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 4.36, getAllPlayers(), eventPlayer, true).getHitPosition()
    eventPlayer.distRayhitPlayerfoot = distance(eventPlayer, eventPlayer.raycastHitpos)
    eventPlayer.distRayhitPlayereye = distance(eventPlayer.getEyePosition(), eventPlayer.raycastHitpos)
    eventPlayer.addedSpeed = 0

    if eventPlayer.distRayhitPlayerfoot > 4.35:
        return

    eventPlayer.addedSpeed = 5.5
    if not eventPlayer.isHoldingButton(Button.CROUCH):
        eventPlayer.addedSpeed = 21
        if eventPlayer.distRayhitPlayerfoot > 0.6:
            eventPlayer.addedSpeed = 22
            if eventPlayer.distRayhitPlayereye > 0.9:
                eventPlayer.addedSpeed = 22 - eventPlayer.distRayhitPlayerfoot * 4
    eventPlayer.applyImpulse(directionTowards(eventPlayer.raycastHitpos, eventPlayer.getEyePosition()), eventPlayer.addedSpeed, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.applyImpulse(vect(eventPlayer.velocity.x, 0, eventPlayer.velocity.z), eventPlayer.speed, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    wait(0.25)
    eventPlayer.setMoveSpeed(ceil(150 + eventPlayer.getHorizontalSpeed() * (eventPlayer.getHorizontalSpeed() / 2)))


rule "Practice raycast":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.mode >= 1
    
    while true:
    eventPlayer.practiceRaycastHitpos = raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 4.36, getAllPlayers(), eventPlayer, true).getHitPosition()
    wait(Wait.ABORT_WHEN_FALSE)


rule "Pogo practice":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.mode >= 1
    
    createEffect(eventPlayer, Effect.SPHERE, Color.RED, eventPlayer.practiceRaycastHitpos, 4.35, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(eventPlayer, Effect.SPHERE, Color.GREEN, eventPlayer.practiceRaycastHitpos, 0.6, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(eventPlayer, Effect.SPHERE, Color.PURPLE, eventPlayer.practiceRaycastHitpos, 0.9, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)


rule "Pogo exit practice":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.mode == 0
    
    destroyEffect(getLastCreatedEntity())
    destroyEffect(getLastCreatedEntity())
    destroyEffect(getLastCreatedEntity())


rule "Pogo number of shots":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isFiringSecondaryFire() == true
    @Condition eventPlayer.F != true
    
    eventPlayer.shotsFired += 1


rule "Baptiste speed in air":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isOnGround() == false
    
    eventPlayer.setMoveSpeed(150)


rule "Set speed to 150 if below 8.25":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isOnGround() == false
    @Condition eventPlayer.getHorizontalSpeed() < 8.25
    
    eventPlayer.setMoveSpeed(150)


rule "track speed":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.getHorizontalSpeed() > eventPlayer.V[9]
    
    wait(0.5)
    if not RULE_CONDITION:
        return
    eventPlayer.V[9] = eventPlayer.getHorizontalSpeed()
    wait()
    if RULE_CONDITION:
        goto RULE_START


rule "Slow down if too slow":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isOnGround() == false
    @Condition eventPlayer.getHorizontalSpeed() > 8.25
    @Condition eventPlayer.getHorizontalSpeed() < 19
    @Condition eventPlayer.getHorizontalSpeed() < eventPlayer.V[9] - 2
    
    wait()
    if not RULE_CONDITION:
        return
    eventPlayer.V[9] = eventPlayer.getHorizontalSpeed()
    eventPlayer.setMoveSpeed(ceil(ceil(eventPlayer.getHorizontalSpeed()) * 16.666))
    wait(0.25)
    if RULE_CONDITION:
        goto RULE_START


rule "Baptiste speed on ground to avoid insta stun when moving in circle":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isOnGround() == true
    
    eventPlayer.setMoveSpeed(125)
    eventPlayer.V[8] = 150
    eventPlayer.V[9] = 0
    wait(1)
    if RULE_CONDITION:
        goto RULE_START


