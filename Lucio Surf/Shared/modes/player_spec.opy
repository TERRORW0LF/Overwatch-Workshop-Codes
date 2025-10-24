rule "Enable Player Spectator Mode":
    @Event eachPlayer
    @Condition not eventPlayer.Mode
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2) and not eventPlayer.isHoldingButton(Button.CROUCH)
    @Condition not eventPlayer.ExecutingMenu
    
    eventPlayer.ExecutingMenu = true
    eventPlayer.Mode = 2
    stopChasingVariable(eventPlayer.TimeCurrent)
    eventPlayer.TimeCurrent = 0
    eventPlayer.TimeExtra = 0
    eventPlayer.setRespawnTime(9999)
    bigMessage(eventPlayer, "Entering Player Spectator Mode")
    wait(0.1)
    kill(eventPlayer, null)
    waitUntil(not eventPlayer.isHoldingButton(Button.ABILITY_2), 9999)
    eventPlayer.ExecutingMenu = false


rule "Disable Player Specator Mode":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 2
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2) and not eventPlayer.isHoldingButton(Button.CROUCH)
    @Condition not eventPlayer.ExecutingMenu
    
    eventPlayer.ExecutingMenu = true
    eventPlayer.resurrect()
    async(Respawn, AsyncBehavior.NOOP)
    bigMessage(eventPlayer, "Leaving Player Spectator Mode")
    waitUntil(not eventPlayer.isHoldingButton(Button.ABILITY_2), 9999)
    eventPlayer.ExecutingMenu = false

