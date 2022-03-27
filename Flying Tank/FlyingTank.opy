settings "settings.opy.json"

#Global variables

globalvar Setup 0
globalvar ForLoop 1
globalvar GameStart 2
globalvar Mode 3
globalvar ForPlayer 4


#Player variables

playervar Partner 0


rule "Workshop Settings":
    Mode = createWorkshopSetting(enum["Random Partner", "Fixed Partner"], "Mode", "Game Type", 0, 0)


rule "Pre Setup":
    GameStart = false
    setMatchTime(0)


rule "Setup - Global":
    @Condition isGameInProgress() == true
    
    wait(5)
    for ForLoop in range(12 if Mode else len(getAllPlayers())):
        ForPlayer = getPlayersInSlot(ForLoop, Team.ALL) if Mode else getAllPlayers()[ForLoop]
        wait()
        printLog(ForPlayer)
        if ForLoop % 2 == 0:
            ForPlayer.startForcingHero(Hero.LUCIO)
            ForPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)
            ForPlayer.Partner = getPlayersInSlot(ForLoop + 1, Team.ALL) if Mode else getAllPlayers()[ForLoop + 1]
        else:
            ForPlayer.startForcingHero(Hero.BASTION)
            ForPlayer.disallowButton(Button.PRIMARY_FIRE)
            ForPlayer.setKnockbackDealt(0)
            ForPlayer.Partner = getPlayersInSlot(ForLoop - 1, Team.ALL) if Mode else getAllPlayers()[ForLoop - 1]
            ForPlayer.attachTo(getPlayersInSlot(ForLoop - 1, Team.ALL) if Mode else getAllPlayers()[ForLoop - 1], vect(0, 1.5, 0))
    wait()
    Setup = true
    bigMessage(getAllPlayers(), "Game starts in 10 seconds.")
    wait(10)
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
    @Condition Setup == true
    
    waitUntil(eventPlayer.hasSpawned() and eventPlayer.isAlive(), 30)
    kill(eventPlayer, null)
    bigMessage(eventPlayer, "Joined while game active")


rule "Kill player if no partner":
    @Event eachPlayer
    @Condition eventPlayer.Partner == null
    @Condition Setup == true
    
    waitUntil(eventPlayer.hasSpawned() and eventPlayer.isAlive(), 30)
    kill(eventPlayer, null)
    bigMessage(eventPlayer, "No partner assigned")


rule "Kill partner on death":
    @Event playerDied
    
    kill(eventPlayer.Partner, attacker)


rule "Victory":
    @Disabled
    @Condition len(getLivingPlayers(Team.ALL)) <= 2
    @Condition isGameInProgress() == true
    
    declarePlayerVictory(random.choice(getLivingPlayers(Team.ALL)))


rule "Lucio on ground":
    @Event eachPlayer
    @Hero lucio
    @Condition eventPlayer.isOnGround() == true
    @Condition GameStart == true
    
    eventPlayer.setStatusEffect(null, Status.BURNING, 9999)
    eventPlayer.Partner.setStatusEffect(null, Status.BURNING, 9999)
    while true:
        damage(eventPlayer.Partner, eventPlayer, 2.5)
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

