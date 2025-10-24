rule "Start timer (Practice)":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 1
    @Condition eventPlayer.PracticeCheckpoint
    @Condition eventPlayer.SpeedPracticeCheckpoint == 0
    @Condition updateEveryTick(distance(eventPlayer.PosPracticeCheckpoint, vect(eventPlayer.getPosition().x, eventPlayer.PosPracticeCheckpoint.y, eventPlayer.getPosition().z)) > 2 or abs(eventPlayer.getPosition().y - eventPlayer.PosPracticeCheckpoint.y) > 3)
    
    chase(eventPlayer.TimeCurrent, 5000, rate=1, ChaseReeval.NONE)

    
rule "Enable Practice Mode":
    @Event eachPlayer
    @Condition not eventPlayer.Mode
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) and not eventPlayer.isHoldingButton(Button.CROUCH)
    @Condition not eventPlayer.ExecutingMenu
    
    eventPlayer.ExecutingMenu = true
    stopChasingVariable(eventPlayer.TimeCurrent)
    eventPlayer.Finished = false
    eventPlayer.TimeCurrent = 0
    eventPlayer.TimeExtra = 0
    eventPlayer.Attempts = 0
    eventPlayer.Mode = 1
    bigMessage(eventPlayer, "Entering Practice Mode")
    eventPlayer.setInvisibility(Invis.ALL)
    waitUntil(not eventPlayer.isHoldingButton(Button.INTERACT), 9999)
    eventPlayer.ExecutingMenu = false


rule "Enable Fire status":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 1
    
    eventPlayer.setStatusEffect(null, Status.BURNING, 9999)
    eventPlayer.setStatusEffect(null, Status.INVINCIBLE, 9999)


rule "Disable Practice Mode":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 1
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) and not eventPlayer.isHoldingButton(Button.CROUCH)
    @Condition not eventPlayer.ExecutingMenu
    
    eventPlayer.ExecutingMenu = true
    if eventPlayer.PracticeCheckpoint:
        if eventPlayer.SpeedPracticeCheckpoint == 0:
            destroyEffect(getLastCreatedEntity())
        else:
            destroyIcon(getLastCreatedEntity())
        eventPlayer.PracticeCheckpoint = false
    eventPlayer.Mode = 99
    bigMessage(eventPlayer, "Leaving Practice Mode")
    async(Respawn, AsyncBehavior.NOOP)
    waitUntil(not eventPlayer.isHoldingButton(Button.INTERACT), 9999)
    eventPlayer.ExecutingMenu = false


rule "Disable Fire status":
    @Event eachPlayer
    @Condition eventPlayer.Mode != 1
    
    eventPlayer.clearStatusEffect(Status.BURNING)
    eventPlayer.clearStatusEffect(Status.INVINCIBLE)


rule "Set Practice Checkpoint":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 1
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE)
    
    if eventPlayer.PracticeCheckpoint:
        if eventPlayer.SpeedPracticeCheckpoint == 0:
            destroyEffect(getLastCreatedEntity())
        else:
            destroyIcon(getLastCreatedEntity())
    eventPlayer.PosPracticeCheckpoint = eventPlayer.getPosition()
    eventPlayer.FacingPracticeCheckpoint = eventPlayer.getFacingDirection()
    eventPlayer.VelocityPracticeCheckpoint = eventPlayer.getVelocity()
    eventPlayer.SpeedPracticeCheckpoint = eventPlayer.getSpeed()
    
    eventPlayer.PracticeCheckpoint = true
    if eventPlayer.SpeedPracticeCheckpoint == 0:
        createEffect(eventPlayer, Effect.RING, Color.GREEN, eventPlayer.PosPracticeCheckpoint, 2, EffectReeval.NONE)
    else:
        createIcon(eventPlayer, eventPlayer.PosPracticeCheckpoint, Icon.FLAG, IconReeval.POSITION, Color.GREEN, true)
    smallMessage(eventPlayer, l"{0} {1}".format(l"Checkpoint", l"Saved"))


rule "Delete Practice Checkpoint":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 1
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2)

    if (eventPlayer.PracticeCheckpoint):
        eventPlayer.PracticeCheckpoint = false
        if eventPlayer.SpeedPracticeCheckpoint == 0:
            destroyEffect(getLastCreatedEntity())
        else:
            destroyIcon(getLastCreatedEntity())
        smallMessage(eventPlayer, "{0} {1}".format(l"Checkpoint", l"Destroyed"))


rule "Ult Reset Checkpoint":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 1
    @Condition not Edit or eventPlayer != hostPlayer
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    
    async(Respawn, AsyncBehavior.NOOP)


rule "Circle Fix (Practice)":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 1
    @Condition eventPlayer.PracticeCheckpoint
    @Condition updateEveryTick(distance(eventPlayer.PosPracticeCheckpoint, vect(eventPlayer.getPosition().x, eventPlayer.PosPracticeCheckpoint.y, eventPlayer.getPosition().z)) <= 2)
    @Condition updateEveryTick(abs(eventPlayer.getPosition().y - eventPlayer.PosPracticeCheckpoint.y) <= 3)
    @Condition eventPlayer.isOnGround()
    @Condition not eventPlayer.Reset
    @Condition updateEveryTick((eventPlayer.Category == 0 and eventPlayer.getHorizontalSpeed() <= 6.88) or (eventPlayer.Category == 1 and eventPlayer.getHorizontalSpeed() <= 8.6))
    
    stopChasingVariable(eventPlayer.TimeCurrent)
    eventPlayer.TimeCurrent = 0
    eventPlayer.TimeExtra = 0
    wait(0.05)
    eventPlayer.allowButton(Button.JUMP)

