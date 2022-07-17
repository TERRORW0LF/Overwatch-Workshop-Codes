settings "settings.opy.json"

#Global variables

globalvar Leader 0
globalvar Started 1
globalvar SelectLeader 2
globalvar SelectMode 3
globalvar WarningDistance 4
globalvar MaxDistance 5
globalvar Time 6
globalvar CurrTime 7


#Player variables

playervar DistanceColor 0
playervar Time 1
playervar InDanger 2


#Workshop settings
rule "Workshop Settings":
    SelectLeader = createWorkshopSetting(enum["Slot 0", "Random"], "Settings", "Leader selection", 1, 0)
    SelectMode = createWorkshopSetting(enum["Elimination", "Timer"], "Settings", "Mode", 0, 1)
    MaxDistance = createWorkshopSetting(int[5:50], "Settings", "Elimation distance", 15, 2)
    Time = createWorkshopSetting(int[0:60], "Settings", "Elimation time", 20, 3)

#Setup
rule "Global Setup":
    CurrTime = 0
    WarningDistance = MaxDistance / 2
    wait(4)
    Leader = getAllPlayers()[random.choice(getAllPlayers())] if SelectLeader else getPlayersInSlot(0, Team.ALL)
    createIcon([player for player in getAllPlayers() if player != Leader], Leader.getPosition(), Icon.FLAG, IconReeval.VISIBILITY_AND_POSITION, Color.GREEN, true)
    if SelectMode:
        hudHeader(getAllPlayers(), "{0} sec".format(Time - CurrTime), HudPosition.TOP, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)


rule "Player Setup":
    @Event eachPlayer

    eventPlayer.enableDeathSpectateAllPlayers()
    eventPlayer.enableDeathSpectateTargetHud()
    eventPlayer.disablePlayerCollision()
    eventPlayer.setRespawnTime(9999)
    eventPlayer.DistanceColor = Color.WHITE
    if not SelectMode:
        hudHeader(eventPlayer, "{0} sec".format(Time - eventPlayer.Time), HudPosition.TOP, 0, Color.WHITE, HudReeval.STRING)
    hudHeader(eventPlayer, "{0} m".format(distance(Leader.getPosition(), eventPlayer.getPosition())), HudPosition.TOP, 1, eventPlayer.DistanceColor, HudReeval.STRING_AND_COLOR)


rule "Teleport to Leader":
    @Event eachPlayer
    @Condition Leader != null
    @Condition not isGameInProgress()

    waitUntil(Leader.hasSpawned(), 5)
    eventPlayer.teleport(Leader.getPosition())


rule "Match start Setup":
    @Condition isGameInProgress()

    Leader.setScore(1)
    if SelectMode:
        chase(CurrTime, 20, rate=1, ChaseReeval.NONE)


rule "Kill late-joins":
    @Event playerJoined
    @Condition isGameInProgress()

    waitUntil(eventPlayer.hasSpawned(), 20)
    kill(eventPlayer, null)
    bigMessage(eventPlayer, "Joined into ongoing game")


rule "Declare Victory - Leader":
    @Condition isGameInProgress()
    @Condition getNumberOfLivingPlayers(Team.ALL) <= 1

    declarePlayerVictory(Leader)


rule "Declare Victory - Followers":
    @Condition isGameInProgress()
    @Condition getMatchTime() <= 1

    declarePlayerVictory(random.choice([player for player in getLivingPlayers(Team.ALL) if player.isAlive()]))


rule "Leader left":
    @Event playerLeft
    @Condition eventPlayer == Leader

    declarePlayerVictory(random.choice(getLivingPlayers(Team.ALL)))


rule "Leader died":
    @Event playerDied
    @Condition eventPlayer == Leader

    declarePlayerVictory(random.choice(getLivingPlayers(Team.ALL)))


rule "Elimation - Timer start":
    @Event eachPlayer
    @Condition not SelectMode
    @Condition eventPlayer.isAlive()
    @Condition distance(Leader.getPosition(), eventPlayer.getPosition()) > MaxDistance

    eventPlayer.DistanceColor = Color.RED
    eventPlayer.InDanger = true
    chase(eventPlayer.Time, 9999, rate=1, ChaseReeval.NONE)
    while eventPlayer.InDanger:
        playEffect(eventPlayer, DynamicEffect.DEBUFF_IMPACT_SOUND, Color.BLACK, eventPlayer.getPosition(), 10)
        wait(1, Wait.ABORT_WHEN_FALSE)


rule "Elimation - Timer end":
    @Event eachPlayer
    @Condition not SelectMode
    @Condition eventPlayer.isAlive()
    @Condition distance(Leader.getPosition(), eventPlayer.getPosition()) < MaxDistance

    stopChasingVariable(eventPlayer.Time)
    eventPlayer.Time = 0
    eventPlayer.InDanger = false
    eventPlayer.DistanceColor = Color.YELLOW


rule "Elimation - Elimate Player":
    @Event eachPlayer
    @Condition not SelectMode
    @Condition eventPlayer.Time > Time

    kill(eventPlayer, eventPlayer)
    eventPlayer.InDanger = false


rule "Elimation - Distance White":
    @Event eachPlayer
    @Condition not SelectMode
    @Condition distance(Leader.getPosition(), eventPlayer.getPosition()) < WarningDistance

    eventPlayer.DistanceColor = Color.WHITE


rule "Elimation - Distance Yellow":
    @Event eachPlayer
    @Condition not SelectMode
    @Condition distance(Leader.getPosition(), eventPlayer.getPosition()) > WarningDistance

    eventPlayer.DistanceColor = Color.YELLOW


rule "Timer - Timer":
    @Condition SelectMode
    @Condition isGameInProgress()
    @Condition CurrTime >= 20

    kill(sorted(getLivingPlayers(Team.ALL), lambda player: distance(Leader, player))[getNumberOfLivingPlayers(Team.ALL) - 1], sorted(getLivingPlayers(Team.ALL), lambda player: distance(Leader, player))[getNumberOfLivingPlayers(Team.ALL) - 1])
    CurrTime = 0


rule "Timer - Distance White":
    @Event eachPlayer
    @Condition SelectMode
    @Condition eventPlayer != sorted(getLivingPlayers(Team.ALL), lambda player: distance(Leader, player))[getNumberOfLivingPlayers(Team.ALL) - 1]

    eventPlayer.DistanceColor = Color.WHITE

    
rule "Timer - Distance Red":
    @Event eachPlayer
    @Condition SelectMode
    @Condition eventPlayer == sorted(getLivingPlayers(Team.ALL), lambda player: distance(Leader, player))[getNumberOfLivingPlayers(Team.ALL) - 1]

    eventPlayer.DistanceColor = Color.RED