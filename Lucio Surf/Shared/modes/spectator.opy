rule "Enable Spectator Mode":
    @Event eachPlayer
    @Condition not eventPlayer.Mode
    @Condition eventPlayer.isHoldingButton(Button.RELOAD) and not eventPlayer.isHoldingButton(Button.CROUCH)
    @Condition not eventPlayer.ExecutingMenu
    
    eventPlayer.ExecutingMenu = true
    eventPlayer.Mode = 3
    eventPlayer.setGravity(0)
    if eventPlayer.Category == 0:
        eventPlayer.setMoveSpeed(225)
    elif eventPlayer.Category == 1:
        eventPlayer.setMoveSpeed(275)
    eventPlayer.setInvisibility(Invis.ALL)
    stopChasingVariable(eventPlayer.TimeCurrent)
    eventPlayer.TimeCurrent = 0
    eventPlayer.TimeExtra = 0
    eventPlayer.Attempts = 0
    bigMessage(eventPlayer, "Entering Spectator Mode")
    waitUntil(not eventPlayer.isHoldingButton(Button.RELOAD), 9999)
    eventPlayer.ExecutingMenu = false


rule "Disable Spectator Mode":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 3
    @Condition eventPlayer.isHoldingButton(Button.RELOAD) and not eventPlayer.isHoldingButton(Button.CROUCH)
    @Condition not eventPlayer.ExecutingMenu
    
    eventPlayer.ExecutingMenu = true
    if eventPlayer.Category == 0:
        eventPlayer.setMoveSpeed(100)
        eventPlayer.setGravity(100)
    elif eventPlayer.Category == 1:
        eventPlayer.setMoveSpeed(125)
        eventPlayer.setGravity(80)
    bigMessage(eventPlayer, "Leaving Spectator Mode")
    async(Respawn, AsyncBehavior.NOOP)
    waitUntil(not eventPlayer.isHoldingButton(Button.RELOAD), 9999)
    eventPlayer.ExecutingMenu = false


rule "Spectator Mode (move up enabled)":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 3
    @Condition eventPlayer.isHoldingButton(Button.JUMP)
    
    eventPlayer.applyImpulse(Vector.UP, 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)


rule "Spectator Mode (move up disabled)":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 3
    @Condition not eventPlayer.isHoldingButton(Button.JUMP)
    
    eventPlayer.applyImpulse(Vector.DOWN, 0.001, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.applyImpulse(Vector.UP, 0.001, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)


rule "Spectator Mode (move down enabled)":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 3
    @Condition eventPlayer.isHoldingButton(Button.CROUCH)
    
    eventPlayer.applyImpulse(Vector.DOWN, 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)


rule "Spectator Mode (move down disabled)":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 3
    @Condition not eventPlayer.isHoldingButton(Button.CROUCH)
    
    eventPlayer.applyImpulse(Vector.UP, 0.001, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.applyImpulse(Vector.DOWN, 0.001, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)


rule "Spectator Mode (stop movement)":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 3
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE)
    
    eventPlayer.applyImpulse(eventPlayer.getVelocity() * -0.001, 0.001, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.applyImpulse(eventPlayer.getVelocity() * 0.001, 0.001, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)


rule "Spectator Mode (slow movement enabled)":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 3
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE)
    
    eventPlayer.Speed = eventPlayer.getHorizontalSpeed()
    eventPlayer.startForcingThrottle(0, 0.5, 0, 0.5, 0, 0.5)
    eventPlayer.applyImpulse(eventPlayer.getVelocity() * -0.001, 1, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.applyImpulse(eventPlayer.getVelocity(), eventPlayer.Speed * 0.5, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)


rule "Spectator Mode (slow movement disabled)":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 3
    @Condition not eventPlayer.isHoldingButton(Button.SECONDARY_FIRE)
    
    eventPlayer.stopForcingThrottle()

