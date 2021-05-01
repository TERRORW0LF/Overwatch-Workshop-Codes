#global varibles
globalvar forloop 0
globalvar dmgStart 1

#player variables
playervar partner 0

#subroutines

#Setup
rule "Setup":
    @Condition isGameInProgress()
    getAllPlayers().disableRespawn()
    setMatchTime(300)


rule "Preload Heros":
    @Event eachPlayer
    eventPlayer.preloadHero([Hero.BASTION, Hero.LUCIO])


#Gamemode
rule "Lucio Bastion Combo":
    @Condition isGameInProgress()
    for forloop in range(0, len(getAllPlayers())):
        if forloop % 2 == 0:
            getAllPlayers()[forloop].startForcingHero(Hero.LUCIO)
            getAllPlayers()[forloop].setInvisibility(Invis.ALL)
            getAllPlayers()[forloop].setHealingReceived(0)
        if forloop % 2 != 0:
            getAllPlayers()[forloop].startForcingHero(Hero.BASTION)
            getAllPlayers()[forloop].disallowButton(Button.PRIMARY_FIRE)
            getAllPlayers()[forloop].attachTo(getAllPlayers()[forloop-1], vect(0,2,0))
            getAllPlayers()[forloop].partner = getAllPlayers()[forloop-1]
            getAllPlayers()[forloop-1].partner = getAllPlayers()[forloop]
    for forloop in range (0, len(getAllPlayers())):
        if not getAllPlayers()[forloop].partner:
            kill(getAllPlayers()[forloop], null)
            bigMessage(getAllPlayers()[forloop], "No Partner, wait for the next round.")


rule "Force Bastion into ult form":
    @Event eachPlayer
    @Condition isGameInProgress()
    @Condition eventPlayer.hasSpawned()
    @Condition eventPlayer.getCurrentHero() == Hero.BASTION
    wait()
    eventPlayer.forceButtonPress(Button.ULTIMATE)


rule "5 secs time to get on wall":
    @Condition isGameInProgress()
    bigMessage(getAllPlayers(), "Get on a wall!")
        wait(5)
    bigMessage(getAllPlayers(), "GO!")
    dmgStart = true


rule "Enable Primary fire (Bastion)":
    @Event eachPlayer
    @Condition dmgStart
    @Condition eventPlayer.getCurrentHero() == Hero.BASTION
    eventPlayer.allowButton(Button.PRIMARY_FIRE)


rule "Kill Partner":
    @Event playerDied
    kill(eventPlayer.partner, attacker)


rule "Damage if on ground":
    @Event eachPlayer
    @Condition isGameInProgress()
    @Condition dmgStart
    @Condition eventPlayer.isOnGround()
    @Condition eventPlayer.getCurrentHero() == Hero.LUCIO
    eventPlayer.setHealth(eventPlayer.getHealth()-10)
    eventPlayer.partner.setHealth(eventPlayer.partner.getHealth()-10)
    wait(1, Wait.ABORT_WHEN_FALSE)
    eventPlayer.startDoT(null, 9999, 10)
    eventPlayer.partner.startDoT(null, 9999, 10)


rule "Stop DoT if not on ground":
    @Event eachPlayer
    @Condition isGameInProgress()
    @Condition not eventPlayer.isOnGround()
    @Condition eventPlayer.getCurrentHero() == Hero.LUCIO
    eventPlayer.stopAllDoT()
    eventPlayer.partner.stopAllDoT()


rule "Dmg Lucio":
    @Event playerTookDamage
    @Condition eventPlayer.getCurrentHero() == Hero.BASTION
    eventPlayer.partner.setHealth(eventPlayer.getHealth())


rule "Enable outlines on 30 seconds left":
    @Condition isGameInProgress()
    @Condition getMatchTime() < 30
    [player for player in getLivingPlayers(Team.ALL) if player.getCurrentHero() == Hero.BASTION].startForcingOutlineFor(getAllPlayers(), true, Color.RED)


rule "Declare winner":
    @Condition isGameInProgress()
    @Condition len([player for player in getLivingPlayers(Team.ALL) if player.getCurrentHero() == Hero.BASTION]) <= 1
    declarePlayerVictory([player for player in getLivingPlayers(Team.ALL) if player.getCurrentHero() == Hero.BASTION][0])


rule "Deal with leavers":
    @Event playerLeft
    if not eventPlayer.partner:
        return
    kill(eventPlayer.partner, null)
    bigMessage(eventPlayer.partner, "Partner left, moving to spectators.")


rule "Disable player spawning in round":
    @Event playerJoined
    @Condition isGameInProgress()
    @Condition getMatchTime() < 299
    eventPlayer.disableRespawn()
    eventPlayer.setScore(-100)
    kill(eventPlayer, null)
    bigMessage(eventPlayer, "Wait for next round!")