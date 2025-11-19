rule "Start - Global FFA":
    @Condition getCurrentGamemode() == Gamemode.FFA

    hudSubtext(getAllPlayers(), f"{floor(getMatchTime() / 3600)}:"
        "{floor((getMatchTime() - floor(getMatchTime() / 3600) * 3600) / 60)}:"
        "{floor(getMatchTime() - floor(getMatchTime() / 60) * 60)}", 
        HudPosition.TOP, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    disableScoring()
    disableGamemodeCompletion()
    disableAnnouncer()
    setMatchTime(0)


rule "Start - Global":
    #Vars
    wait()
    setMatchTime(Time + 10)
    chase(VoteTimer, 9999, rate=1, ChaseReeval.NONE)
    #Start / Checkpoint / Finish / Barrier effects
    createEffect(getAllPlayers(), Effect.RING, Color.GREEN, PosStart, 2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, Color.WHITE, PosFinish, 5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(getAllPlayers(), Effect.RING, Color.WHITE, PosFinish, 5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    for Loop1 in range(0, len(PosCheckpoint)):
        createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, Color.LIME_GREEN if localPlayer.Checkpoint[evalOnce(Loop1)] else Color.SKY_BLUE, PosCheckpoint[evalOnce(Loop1)], 3.5, EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)
        createEffect(getAllPlayers(), Effect.RING, Color.LIME_GREEN if localPlayer.Checkpoint[evalOnce(Loop1)] else Color.SKY_BLUE, PosCheckpoint[evalOnce(Loop1)], 3.5, EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)
    for Loop1 in range(0, len(PosBarrier), 1):
        createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, PosBarrier[evalOnce(Loop1)], 5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)

    # Layout / Category information
    hudHeader([player for player in getAllPlayers() if player.Category == 0], f"Lucio Surf v{VERSION} | {Layout + 1}S{MapName}", HudPosition.RIGHT, 0, Color.YELLOW, HudReeval.VISIBILITY)
    hudHeader([player for player in getAllPlayers() if player.Category == 1], f"Lucio Surf v{VERSION} | {Layout + 1}G{MapName}", HudPosition.RIGHT, 0, Color.YELLOW, HudReeval.VISIBILITY)
    # Leaderboards
    hudHeader([player for player in getAllPlayers() if player.Category == 0], f"1 - {floor(TimeFirstStan + 0.001 / 1000)}.{(floor((1000 * TimeFirstStan + 0.001)) % 1000 + 1000).substring(1, 3)} sec - {PlayerFirstStan}", HudPosition.RIGHT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader([player for player in getAllPlayers() if player.Category == 0 and player.HideHud <= 1], f"2 - {floor(TimeSecondStan + 0.001 / 1000)}.{(floor((1000 * TimeSecondStan + 0.001)) % 1000 + 1000).substring(1, 3)} sec - {PlayerSecondStan}", HudPosition.RIGHT, 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader([player for player in getAllPlayers() if player.Category == 0 and player.HideHud <= 1], f"3 - {floor(TimeThirdStan + 0.001 / 1000)}.{(floor((1000 * TimeThirdStan + 0.001)) % 1000 + 1000).substring(1, 3)} sec - {PlayerThirdStan}", HudPosition.RIGHT, 3, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader([player for player in getAllPlayers() if player.Category == 1], f"1 - {floor(TimeFirstGrav + 0.001 / 1000)}.{(floor((1000 * TimeFirstGrav + 0.001)) % 1000 + 1000).substring(1, 3)} sec - {PlayerFirstGrav}", HudPosition.RIGHT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader([player for player in getAllPlayers() if player.Category == 1 and player.HideHud <= 1], f"2 - {floor(TimeSecondGrav + 0.001 / 1000)}.{(floor((1000 * TimeSecondGrav + 0.001)) % 1000 + 1000).substring(1, 3)} sec - {PlayerSecondGrav}", HudPosition.RIGHT, 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader([player for player in getAllPlayers() if player.Category == 1 and player.HideHud <= 1], f"3 - {floor(TimeThirdGrav + 0.001 / 1000)}.{(floor((1000 * TimeThirdGrav + 0.001)) % 1000 + 1000).substring(1, 3)} sec - {PlayerThirdGrav}", HudPosition.RIGHT, 3, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    # Always visible help text
    hudSubtext(getAllPlayers(), "Map Skip - {0}/{1} | {2}%".format(len([player for player in getAllPlayers() if player.SkipMap]), VoteMin, "{}/{}".format(len([player for player in getAllPlayers() if player.SkipMap]) / len(getAllPlayers()) * 100, VotePerc)), HudPosition.LEFT, 3, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    # Help text standard
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and not player.Mode], "Reset - Ultimate", HudPosition.LEFT, 5, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and not player.Mode], "Cycle Auto Reset - Crouch + Melee", HudPosition.LEFT, 6, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and not player.Mode], "Cycle Category - Crouch + Ability 2", HudPosition.LEFT, 7, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and not player.Mode], "Practice Mode - Interact", HudPosition.LEFT, 8, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and not player.Mode], "Player Spectator Mode - Ability 2", HudPosition.LEFT, 9, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and not player.Mode], "Spectator Mode - Reload", HudPosition.LEFT, 10, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    # Help text practice
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and player.Mode == 1], "Standard Mode - Interact", HudPosition.LEFT, 5, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and player.Mode == 1], "Ult Reset (Checkpoint) - Ultimate", HudPosition.LEFT, 6, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and player.Mode == 1], "Set Checkpoint - Secondary Fire", HudPosition.LEFT, 7, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and player.Mode == 1], "Delete Checkpoint - Ability 2", HudPosition.LEFT, 8, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    # Help text playerspec
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and player.Mode == 2], "Standard Mode - Ability 2", HudPosition.LEFT, 5, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and player.Mode == 2], "Spectate next - Primary Fire", HudPosition.LEFT, 6, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and player.Mode == 2], "Spectate previous - Secondary Fire", HudPosition.LEFT, 7, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)    
    #Help text spectator
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and player.Mode == 3], "Standard Mode - Reload", HudPosition.LEFT, 5, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and player.Mode == 3], "Stop - Primary Fire", HudPosition.LEFT, 6, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and player.Mode == 3], "Slow Move - Secondary Fire", HudPosition.LEFT, 7, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    # Always visible help text
    hudSubtext([player for player in getAllPlayers() if not player.HideHud], "Vote Skip Map - Crouch + Secondary Fire", HudPosition.LEFT, 18, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and player == hostPlayer], "Toggle Invisibility - Crouch + Reload", HudPosition.LEFT, 19, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext(getAllPlayers(), "Cycle HUD - Crouch + Interact", HudPosition.LEFT, 20, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)


rule "Start - Player FFA":
    @Event eachPlayer
    @Condition getCurrentGamemode() == Gamemode.FFA
    @Condition isGameInProgress()
    @Condition eventPlayer.hasSpawned()

    async(Respawn(), AsyncBehavior.NOOP)
    eventPlayer.disableGamemodeHud()
    wait(0.1)
    eventPlayer.FFAReset = true


rule "Start - Player":
    @Event eachPlayer
    @Condition eventPlayer.hasSpawned()
    
    eventPlayer.Checkpoint = [false for cp in PosCheckpoint]
    if (getCurrentGamemode() != Gamemode.FFA):
        eventPlayer.FFAReset = true
    #Category setup
    if Category == 0:
        eventPlayer.setMoveSpeed(100)
        eventPlayer.setGravity(100)
    elif Category == 1:
        eventPlayer.setMoveSpeed(125)
        eventPlayer.setGravity(80)
    #Mode setup
    eventPlayer.enableDeathSpectateAllPlayers()
    eventPlayer.enableDeathSpectateTargetHud()
    eventPlayer.disablePlayerCollision()
    #Hud
    hudHeader(eventPlayer, eventPlayer, HudPosition.LEFT, 0, Color.YELLOW, HudReeval.NONE, SpecVisibility.DEFAULT)
    hudHeader(eventPlayer if eventPlayer.Category == 0 else null, "Best - {0}.{1} sec".format(floor(eventPlayer.TimeBestStan + 0.001 / 1000), "{0}".format(floor((1000 * eventPlayer.TimeBestStan + 0.001)) % 1000 + 1000).substring(1, 3)), HudPosition.LEFT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader(eventPlayer if eventPlayer.Category == 1 else null, "Best - {0}.{1} sec".format(floor(eventPlayer.TimeBestGrav + 0.001 / 1000), "{0}".format(floor((1000 * eventPlayer.TimeBestGrav + 0.001)) % 1000 + 1000).substring(1, 3)), HudPosition.LEFT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader(eventPlayer if eventPlayer.HideHud <= 1 else null, "Attempts: {0}".format(eventPlayer.Attempts), HudPosition.LEFT, 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader(eventPlayer, "{0} m/s".format(eventPlayer.getHorizontalSpeed()), HudPosition.TOP, 0.1, eventPlayer.SpeedColor, HudReeval.STRING_AND_COLOR, SpecVisibility.DEFAULT)
    hudHeader(eventPlayer, "{0}.{1} sec".format(floor(eventPlayer.TimeCurrent + 0.001 / 1000), "{0}".format(floor((1000 * eventPlayer.TimeCurrent + 0.001)) % 1000 + 1000).substring(1, 3)), HudPosition.TOP, 0.2, Color.WHITE, HudReeval.STRING, SpecVisibility.DEFAULT)
    #Start
    async(Respawn, AsyncBehavior.NOOP)