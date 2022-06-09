settings "settings.opy.json"

#Global variables

globalvar NotSetup 0
globalvar ForLoop 1
globalvar GameStart 2
globalvar Players 3
globalvar ForPlayer 4


#Player variables

playervar Partner 0
playervar Protected 1


#Activated extensions

#!extension spawnMoreDummyBots


#Rules

rule "Pre Setup":
    GameStart = false
    setMatchTime(0)


rule "Setup - Global":
    @Condition isGameInProgress() == true
    
    wait(5)
    disableScoring()
    Players = getAllPlayers()
    for ForLoop in range(len(Players)):
        ForPlayer = Players[ForLoop]
        wait()
        ForPlayer.startForcingHero(Hero.LUCIO)
        wait()
        ForPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)
        createDummy(Hero.BASTION, Team.ALL, ForLoop + 12, null, ForPlayer.getFacingDirection())
        wait()
        ForPlayer.Partner = getPlayersInSlot(ForLoop + 12, Team.ALL)
        wait()
        ForPlayer.Partner.Partner = ForPlayer
        ForPlayer.Partner.setScore(-9999)
        ForPlayer.Partner.startForcingHero(Hero.BASTION)
        wait()
        ForPlayer.Partner.setKnockbackDealt(0)
        ForPlayer.Partner.disallowButton(Button.PRIMARY_FIRE)
        ForPlayer.Partner.attachTo(ForPlayer, null)
        ForPlayer.Partner.setInvisibility(Invis.ALL)
        ForPlayer.Partner.startFacing(ForPlayer.getFacingDirection(), 9999, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    bigMessage(getAllPlayers(), "Game starts in 10 seconds.")
    wait(3)
    for ForLoop in range(len(Players)):
        ForPlayer = Players[ForLoop]
        ForPlayer.Partner.forceButtonPress(Button.ULTIMATE)
    wait()
    NotSetup = true
    wait(7)
    bigMessage(getAllPlayers(), "START!")
    GameStart = true


rule "Setup - Player":
    @Event eachPlayer
    @Condition isGameInProgress() == true
    
    eventPlayer.enableDeathSpectateAllPlayers()
    eventPlayer.enableDeathSpectateTargetHud()
    eventPlayer.disableRespawn()
    eventPlayer.setHealingReceived(0)


rule "Late Join":
    @Event playerJoined
    @Condition NotSetup == true
    
    waitUntil(eventPlayer.hasSpawned() and eventPlayer.isAlive(), 30)
    kill(eventPlayer, null)
    bigMessage(eventPlayer, "Joined while game active")


rule "Respawn on death":
    @Event playerDied
    @Hero bastion
    
    eventPlayer.Partner.addToScore(0 if attacker != eventPlayer else -1)
    attacker.Partner.addToScore(1 if attacker != eventPlayer else 0)
    destroyIcon(getLastCreatedEntity())
    createIcon(getAllPlayers(), eventPlayer.getPosition() + vect(0, 0.5, 0), Icon.HALO, IconReeval.VISIBILITY_AND_POSITION, Color.ORANGE, false)
    eventPlayer.clearStatusEffect(Status.BURNING)
    eventPlayer.Partner.clearStatusEffect(Status.BURNING)
    eventPlayer.Partner.Protected = true
    eventPlayer.detach()
    eventPlayer.Partner.respawn()
    eventPlayer.respawn()
    eventPlayer.disallowButton(Button.PRIMARY_FIRE)
    bigMessage([eventPlayer, eventPlayer.Partner], "5 sec spawn protection!")
    waitUntil(eventPlayer.isAlive() and eventPlayer.Partner.isAlive(), 3)
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 5)
    eventPlayer.Partner.setStatusEffect(null, Status.PHASED_OUT, 9999)
    eventPlayer.attachTo(eventPlayer.Partner, null)
    wait(3)
    eventPlayer.forceButtonPress(Button.ULTIMATE)
    eventPlayer.startFacing(eventPlayer.Partner.getFacingDirection(), 9999, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    wait(2)
    eventPlayer.Partner.Protected = false
    eventPlayer.allowButton(Button.PRIMARY_FIRE)
    destroyIcon(getLastCreatedEntity())
    bigMessage([eventPlayer, eventPlayer.Partner], "GO!")


rule "Lucio on ground":
    @Event eachPlayer
    @Hero lucio
    @Condition eventPlayer.isOnGround() == true
    @Condition eventPlayer.Protected == false
    @Condition GameStart == true
    
    eventPlayer.setStatusEffect(null, Status.BURNING, 9999)
    eventPlayer.Partner.setStatusEffect(null, Status.BURNING, 9999)
    while true:
        damage(eventPlayer.Partner, eventPlayer.Partner, 2.5)
        wait(0.016, Wait.ABORT_WHEN_FALSE)


rule "Lucio off ground":
    @Event eachPlayer
    @Hero lucio
    @Condition eventPlayer.isOnGround() == false
    @Condition GameStart == true
    
    eventPlayer.clearStatusEffect(Status.BURNING)
    eventPlayer.Partner.clearStatusEffect(Status.BURNING)


rule "Link partner health":
    @Event playerTookDamage
    @Hero bastion
    
    eventPlayer.Partner.setHealth(eventPlayer.getHealth())


rule "Bastion allow shooting":
    @Event eachPlayer
    @Hero bastion
    @Condition GameStart == true
    
    eventPlayer.allowButton(Button.PRIMARY_FIRE)


rule "Lucio got a kill":
    @Event playerEarnedElimination
    @Hero lucio
    @Condition victim != attacker

    eventPlayer.addToScore(1)


rule "Make Dummy shoot":
    @Event eachPlayer
    @Hero lucio
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE)
    
    eventPlayer.Partner.startForcingButton(Button.PRIMARY_FIRE)
    waitUntil(not eventPlayer.isHoldingButton(Button.PRIMARY_FIRE), 9999)
    eventPlayer.Partner.stopForcingButton(Button.PRIMARY_FIRE)