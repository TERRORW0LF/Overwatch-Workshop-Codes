settings "settings.opy.json"


#Global variables

globalvar Defense 0
globalvar Point 1
globalvar Time 2
globalvar Infinite 3
globalvar DummyAttack 4
globalvar DummyDefense 5
globalvar ObjectiveInPosition 6


#Player variables

playervar TimeSpawn 0
playervar TimeRun 1
playervar Finished 2
playervar Reset 3
playervar BestSpawn 4
playervar BestRun 5
playervar SpeedColor 6


#Workshop setting
rule "Workshop Settings":
    Defense = createWorkshopSetting(enum["Attack", "Defense"], "Point Select", "Active Team", 0, 0)
    Point = createWorkshopSetting(int[1:3], "Point Select", "Active Point", 1, 1)
    Time = createWorkshopSetting(int[60:3600], "Time", "Seconds", 600, 0)
    Infinite = createWorkshopSetting(bool, "Time", "Infinite", false, 1)


rule "Debug Player":
    @Disabled
    @Event eachPlayer

    hudHeader(eventPlayer, "{0}".format(eventPlayer.getPosition()), HudPosition.TOP, 5, Color.WHITE, HudReeval.STRING)
    hudHeader(eventPlayer, "{0}".format(getCurrentObjective()), HudPosition.TOP, 6, Color.WHITE, HudReeval.STRING)
    hudHeader(eventPlayer, "{0}".format(getObjectivePosition(getCurrentObjective())), HudPosition.TOP, 7, Color.WHITE, HudReeval.STRING)
    hudHeader(eventPlayer, "{0}".format(getPayloadPosition()), HudPosition.TOP, 8, Color.WHITE, HudReeval.STRING)


#Setup
rule "Skip Prepare Phase":
    @Condition isInSetup()

    setMatchTime(1)


rule "Unlock Control Point":
    @Condition getCurrentGamemode() == Gamemode.CONTROL or getCurrentGamemode() == Gamemode.PUSH
    @Condition not isInSetup()
    @Condition isControlPointLocked()

    setMatchTime(1)


rule "Set Match Time":
    @Condition isGameInProgress()
    @Condition not isControlPointLocked()

    setMatchTime(Time)


rule "Setup - Player":
    @Event eachPlayer

    eventPlayer.BestSpawn = 9999
    eventPlayer.BestRun = 9999
    eventPlayer.disableGamemodeHud()
    eventPlayer.disablePlayerCollision()
    eventPlayer.setStatusEffect(null, Status.INVINCIBLE, 9999)
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)
    hudHeader(eventPlayer, eventPlayer, HudPosition.LEFT, 0, Color.YELLOW, HudReeval.NONE)
    hudHeader(eventPlayer, "Spawn: {0} sec".format(eventPlayer.TimeSpawn), HudPosition.LEFT, 1, Color.WHITE, HudReeval.STRING)
    hudHeader(eventPlayer, "Run: {0} sec".format(eventPlayer.TimeRun), HudPosition.LEFT, 2, Color.WHITE, HudReeval.STRING)
    hudHeader(eventPlayer, l"{0} m/s".format(eventPlayer.getHorizontalSpeed()), HudPosition.TOP, 1, eventPlayer.SpeedColor, HudReeval.STRING_AND_COLOR)
    hudHeader(eventPlayer, "Best Spawn: {0} sec".format(eventPlayer.BestSpawn), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    hudHeader(eventPlayer, "Best Run: {0} sec".format(eventPlayer.BestRun), HudPosition.RIGHT, 2, Color.WHITE, HudReeval.STRING)


rule "Setup - Global":

    hudHeader(getAllPlayers(), "Fastest Rollouts v2.0", HudPosition.RIGHT, 0, Color.YELLOW, HudReeval.NONE)


rule "Setup - Active Point (Assault)":
    @Condition getCurrentGamemode() == Gamemode.ASSAULT
    @Condition not isInSetup()

    createDummy(Hero.ANA, Team.2, 5, nearestWalkablePosition(getObjectivePosition(0)), null)
    DummyAttack = getLastCreatedEntity()
    DummyAttack.setInvisibility(Invis.ALL)
    DummyAttack.disablePlayerCollision()
    waitUntil(getCurrentObjective() == Point - 1, 9999)
    DummyAttack.teleport(nearestWalkablePosition(getObjectivePosition(getCurrentObjective())))
    createDummy(Hero.ANA, Team.1, 5, nearestWalkablePosition(getObjectivePosition(getCurrentObjective())), null)
    DummyDefense = getLastCreatedEntity()
    DummyDefense.setInvisibility(Invis.ALL)
    DummyDefense.disablePlayerCollision()
    ObjectiveInPosition = true


rule "Setup - Active Point (Hybrid)":
    @Condition getCurrentGamemode() == Gamemode.HYBRID
    @Condition not isInSetup()

    createDummy(Hero.ANA, Team.2, 5, nearestWalkablePosition(getObjectivePosition(0)), null)
    DummyAttack = getLastCreatedEntity()
    DummyAttack.setInvisibility(Invis.ALL)
    DummyAttack.disablePlayerCollision()
    waitUntil(getCurrentObjective() == 1 if Point != 1 else true, 9999)
    if Point - 1:
        DummyAttack.startForcingPosition(nearestWalkablePosition(getPayloadPosition()), true)
        waitUntil(distance(getPayloadPosition(), getObjectivePosition(Point - 1)) < 0.5 if Defense == 0 else getCurrentObjective() == Point - 1, 9999)
    createDummy(Hero.ANA, Team.1, 5, nearestWalkablePosition(getPayloadPosition()) if Point != 1 else nearestWalkablePosition(getObjectivePosition(0)), null)
    DummyDefense = getLastCreatedEntity()
    DummyDefense.setInvisibility(Invis.ALL)
    DummyDefense.disablePlayerCollision()
    ObjectiveInPosition = true


rule "Setup - Active Point (Payload)":
    @Condition getCurrentGamemode() == Gamemode.ESCORT
    @Condition not isInSetup()

    createDummy(Hero.ANA, Team.2, 5, getPayloadPosition(), null)
    DummyAttack = getLastCreatedEntity()
    DummyAttack.setInvisibility(Invis.ALL)
    DummyAttack.disablePlayerCollision()
    DummyAttack.startForcingPosition(nearestWalkablePosition(getPayloadPosition()), true)
    waitUntil(distance(getPayloadPosition(), getObjectivePosition(Point - 1)) < 0.5 if Defense == 0 else getCurrentObjective() == Point - 1, 9999)
    createDummy(Hero.ANA, Team.1, 5, getPayloadPosition(), null)
    DummyDefense = getLastCreatedEntity()
    DummyDefense.setInvisibility(Invis.ALL)
    DummyDefense.disablePlayerCollision()
    DummyAttack.startForcingPosition(nearestWalkablePosition(getPayloadPosition()), true)
    ObjectiveInPosition = true


rule "Setup - Active Point (Control)":
    @Condition getCurrentGamemode() == Gamemode.CONTROL
    @Condition not isInSetup()

    waitUntil(nearestWalkablePosition(getObjectivePosition(getCurrentObjective())) != 0, 9999)
    createDummy(Hero.ANA, Team.2, 5, nearestWalkablePosition(getObjectivePosition(getCurrentObjective())), null)
    DummyAttack = getLastCreatedEntity()
    DummyAttack.setInvisibility(Invis.ALL)
    DummyAttack.disablePlayerCollision()
    createDummy(Hero.ANA, Team.1, 5, nearestWalkablePosition(getObjectivePosition(getCurrentObjective())), null)
    DummyDefense = getLastCreatedEntity()
    DummyDefense.setInvisibility(Invis.ALL)
    DummyDefense.disablePlayerCollision()
    ObjectiveInPosition = true


rule "Setup - Active Point (Push)":
    @Condition getCurrentGamemode() == Gamemode.PUSH
    @Condition not isInSetup()

    createDummy(Hero.ANA, Team.2, 5, getPayloadPosition(), null)
    DummyAttack = getLastCreatedEntity()
    DummyAttack.setInvisibility(Invis.ALL)
    DummyAttack.disablePlayerCollision()
    DummyAttack.startForcingPosition(nearestWalkablePosition(getPayloadPosition()), true)
    waitUntil(distance(getPayloadPosition(), getObjectivePosition(Point - 1)) < 0.5 if Defense == 0 else getCurrentObjective() == Point - 1, 9999)
    createDummy(Hero.ANA, Team.1, 5, getPayloadPosition(), null)
    DummyDefense = getLastCreatedEntity()
    DummyDefense.setInvisibility(Invis.ALL)
    DummyDefense.disablePlayerCollision()
    DummyAttack.startForcingPosition(nearestWalkablePosition(getPayloadPosition()), true)
    ObjectiveInPosition = true
    

rule "Setup - Keep in spawn":
    @Event eachPlayer
    @Condition not ObjectiveInPosition
    @Condition not eventPlayer.isInSpawnRoom()

    eventPlayer.respawn()


#Gamemode
rule "Start Timer - Spawn":
    @Event eachPlayer
    @Condition eventPlayer.isInSpawnRoom()
    @Condition eventPlayer.hasSpawned()
    @Condition ObjectiveInPosition

    eventPlayer.TimeSpawn = 0
    chase(eventPlayer.TimeSpawn, 5000, rate=1, ChaseReeval.NONE)
    stopChasingVariable(eventPlayer.TimeRun)
    eventPlayer.TimeRun = 0
    eventPlayer.setUltCharge(100)
    eventPlayer.setStatusEffect(null, Status.INVINCIBLE, 9999)
    eventPlayer.Finished = false


rule "Start Timer - Run":
    @Event eachPlayer
    @Condition not eventPlayer.isInSpawnRoom()
    @Condition eventPlayer.hasSpawned()
    @Condition ObjectiveInPosition

    chase(eventPlayer.TimeRun, 5000, rate=1, ChaseReeval.NONE)
    stopChasingVariable(eventPlayer.TimeSpawn)
    if eventPlayer.TimeSpawn < eventPlayer.BestSpawn and eventPlayer.TimeSpawn != 0:
        eventPlayer.BestSpawn = eventPlayer.TimeSpawn
        smallMessage(eventPlayer, "PB Spawn: {0} sec".format(eventPlayer.TimeSpawn))
    else:
        smallMessage(eventPlayer, "Spawn: {0} sec".format(eventPlayer.TimeSpawn))


rule "Reset":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)

    eventPlayer.respawn()
    stopChasingVariable(eventPlayer.TimeSpawn)
    eventPlayer.TimeSpawn = 0
    chase(eventPlayer.TimeSpawn, 5000, rate=1, ChaseReeval.NONE)


rule "Finish":
    @Event eachPlayer
    @Condition eventPlayer.isOnObjective()
    @Condition not eventPlayer.Finished
    @Condition ObjectiveInPosition

    stopChasingVariable(eventPlayer.TimeRun)
    if eventPlayer.TimeRun < eventPlayer.BestRun:
        eventPlayer.BestRun = eventPlayer.TimeRun
        smallMessage(eventPlayer, "PB Run: {0} sec".format(eventPlayer.TimeRun))
    else:
        smallMessage(eventPlayer, "Run: {0} sec".format(eventPlayer.TimeRun))
    eventPlayer.Finished = true


rule "Velocity Counter (Green)":
    @Event eachPlayer
    @Condition eventPlayer.getHorizontalSpeed() > 13.75

    eventPlayer.SpeedColor = Color.GREEN
    
    
rule "Velocity Counter (Yellow)":
    @Event eachPlayer
    @Condition eventPlayer.getHorizontalSpeed() > 11
    @Condition eventPlayer.getHorizontalSpeed() < 13.75

    eventPlayer.SpeedColor = Color.YELLOW


rule "Velocity Counter (Orange)":
    @Event eachPlayer
    @Condition eventPlayer.getHorizontalSpeed() > 6.88
    @Condition eventPlayer.getHorizontalSpeed() < 11

    eventPlayer.SpeedColor = Color.ORANGE
    
    
rule "Velocity Counter (Red)":
    @Event eachPlayer
    @Condition eventPlayer.getHorizontalSpeed() <= 6.88
    
    eventPlayer.SpeedColor = Color.RED    


rule "Infinite Match Time":
    @Condition isGameInProgress()
    @Condition not isControlPointLocked() or getCurrentGamemode() != Gamemode.CONTROL
    @Condition getMatchTime() < 10

    setMatchTime(Time)