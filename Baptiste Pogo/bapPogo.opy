rule "Start - Assault - Every Map Is In Order (a - z)":
    L = vect(ceil(getObjectivePosition(0).x), ceil(getObjectivePosition(0).y), ceil(getObjectivePosition(0).z))
    if L != vect(-4, 2, 1):
        goto lbl_0
    Y = vect(-10.57, -0.72, -84.71)
    Z = vect(58, -1.5, 34)
    lbl_0:
    if L != vect(55, 9, -89):
        goto lbl_1
    Y = vect(-24.74, 2.7, -121)
    Z = vect(19, 13, -45.5)
    lbl_1:
    if L != vect(-54, 12, 15):
        goto lbl_2
    Y = vect(-104, 14.75, -100)
    Z = vect(-14.4, 14, -35.75)
    lbl_2:
    if L != vect(-45, 2, 44):
        goto lbl_3
    Y = vect(-7.5, 4.7, 111.3)
    Z = vect(-1, -2, -9)
    lbl_3:
    if L != vect(-13, -3, 91):
        goto lbl_4
    Y = vect(-94.24, -1.98, 49.3)
    Z = vect(18, -4.5, 23)
    lbl_4:


rule "Start - Escort":
    L = vect(ceil(getObjectivePosition(0).x), ceil(getObjectivePosition(0).y), ceil(getObjectivePosition(0).z))
    if L != vect(74, 7, -11):
        goto lbl_0
    Y = vect(184.19, 13.94, 40.32)
    Z = vect(12.5, 0, 6)
    lbl_0:
    if L != vect(-10, 6, -79):
        goto lbl_1
    Y = vect(140.14, 6.09, -46.38)
    Z = vect(-98, 4, -93)
    lbl_1:
    if L != vect(-33, 5, -53):
        goto lbl_2
    Y = vect(-92.82, 5.84, -119.06)
    Z = vect(46.549, 10.207, -99.638)
    lbl_2:
    if L != vect(39, 0, -68):
        goto lbl_3
    Y = vect(-57, 2.5, -131.67)
    Z = vect(106.5, -1, -15.5)
    lbl_3:
    if L != vect(15, 3, -7):
        goto lbl_4
    Y = vect(-92.49, 6.63, -23.25)
    Z = vect(38.5, 5.75, 36.5)
    lbl_4:
    if L != vect(26, -4, -73):
        goto lbl_5
    Y = vect(82.46, -0.91, 39.99)
    Z = vect(39, 4, -124.5)
    lbl_5:


rule "Start - Hybrid":
    L = vect(ceil(getObjectivePosition(0).x), ceil(getObjectivePosition(0).y), ceil(getObjectivePosition(0).z))
    if L != vect(4, 2, 75):
        goto lbl_0
    Y = vect(-122.14, -0.15, 110.64)
    Z = vect(3, 0, 21.5)
    lbl_0:
    if L != vect(11, 7, -71):
        goto lbl_1
    Y = vect(123.63, 8.85, -27.05)
    Z = vect(2, 6, 0.5)
    lbl_1:
    if L != vect(-23, 2, 1):
        goto lbl_2
    Y = vect(-35.08, 1.75, -134.97)
    Z = vect(-52, 0, 12.5)
    lbl_2:
    if L != vect(-18, 1, -33):
        goto lbl_3
    Y = vect(-149.09, -2.78, 24.25)
    Z = vect(-12, 0, 12.5)
    lbl_3:
    if L != vect(86, 1, -1):
        goto lbl_4
    Y = vect(206.99, -2.09, 22.14)
    Z = vect(18, 0, 13)
    lbl_4:


rule "Start - Control - Busan - Control Levels Are Randomly Ordered":
    L = vect(ceil(getObjectivePosition(getCurrentObjective()).x), ceil(getObjectivePosition(getCurrentObjective()).y), ceil(getObjectivePosition(getCurrentObjective()).z))
    if L != vect(-328, 9, 141):
        goto lbl_0
    Y = vect(-397, 9.5, 171)
    Z = vect(-255.5, 9, 147)
    lbl_0:
    if L != vect(223, 10, 243):
        goto lbl_1
    Y = vect(275.5, 10, 210.5)
    Z = vect(165, 10, 255)
    lbl_1:
    if L != vect(52, 7, -92):
        goto lbl_2
    Y = vect(-3.5, 16, -125)
    Z = vect(99, 16, -125.5)
    lbl_2:


rule "Start - Control - Ilios":
    L = vect(ceil(getObjectivePosition(getCurrentObjective()).x), ceil(getObjectivePosition(getCurrentObjective()).y), ceil(getObjectivePosition(getCurrentObjective()).z))
    if L != vect(358, -25, -51):
        goto lbl_0
    Y = vect(290, -25.75, -89)
    Z = vect(329, -25, 22)
    lbl_0:
    if L != vect(-208, 1, -16):
        goto lbl_1
    Y = vect(-264.5, -5, 29.5)
    Z = vect(-159, -5, -75.5)
    lbl_1:
    if L != vect(29, 58, -157):
        goto lbl_2
    Y = vect(-58.5, 60, -150)
    Z = vect(112, 65.5, -178)
    lbl_2:


rule "Start - Control - Lijiang Tower":
    L = vect(ceil(getObjectivePosition(getCurrentObjective()).x), ceil(getObjectivePosition(getCurrentObjective()).y), ceil(getObjectivePosition(getCurrentObjective()).z))
    if L != vect(1, 95, 151):
        goto lbl_0
    Y = vect(-61, 94, 148)
    Z = vect(64.5, 94, 145.5)
    lbl_0:
    if L != vect(1, 0, -60):
        goto lbl_1
    Y = vect(-54.25, 6, -11.75)
    Z = vect(61, 2, -34)
    lbl_1:
    if L != vect(1, 268, 280):
        goto lbl_2
    Y = vect(-35.5, 267, 316.75)
    Z = vect(44, 265, 327)
    lbl_2:


rule "Start - Control - Nepal":
    L = vect(ceil(getObjectivePosition(getCurrentObjective()).x), ceil(getObjectivePosition(getCurrentObjective()).y), ceil(getObjectivePosition(getCurrentObjective()).z))
    if L != vect(-195, -93, 0):
        goto lbl_0
    Y = vect(-176.5, -99, -71)
    Z = vect(-191, -98, 60)
    lbl_0:
    if L != vect(84, 129, 1):
        goto lbl_1
    Y = vect(81, 132, -35.5)
    Z = vect(81, 132, 36)
    lbl_1:
    if L != vect(-49, 14, 0):
        goto lbl_2
    Y = vect(-49, 15, -74)
    Z = vect(-38.5, 15, 60)
    lbl_2:


rule "Start - Control - Oasis":
    L = vect(ceil(getObjectivePosition(getCurrentObjective()).x), ceil(getObjectivePosition(getCurrentObjective()).y), ceil(getObjectivePosition(getCurrentObjective()).z))
    if L != vect(144, 3, 248):
        goto lbl_0
    Y = vect(195, 1, 200)
    Z = vect(101, 1, 309.5)
    lbl_0:
    if L != vect(-188, 16, 0):
        goto lbl_1
    Y = vect(-188.25, 18, -58)
    Z = vect(-188, 18, 50.5)
    lbl_1:
    if L != vect(122, 6, -227):
        goto lbl_2
    Y = vect(103, 8, -285.5)
    Z = vect(182, 8, -223.5)
    lbl_2:


rule "Start - Global":
    createEffect(getAllPlayers(), Effect.RING, Color.GREEN, Z, 2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, Color.WHITE, Y, 5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(getAllPlayers(), Effect.RING, Color.WHITE, Y, 5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    setMatchTime(3599)
    A = 9999
    G = 9999
    H = 9999
    hudHeader(getAllPlayers(), l"{0} - {1} - {2}".format(3, l"{0} sec".format(l"{0} {1}".format(H, floor(H % 0.01 * 1000))), J), HudPosition.RIGHT, 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader(getAllPlayers(), l"{0} - {1} - {2}".format(2, l"{0} sec".format(l"{0} {1}".format(G, floor(G % 0.01 * 1000))), I), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader(getAllPlayers(), l"{0} - {1} - {2}".format(l"Record", l"{0} sec".format(l"{0} {1}".format(A, floor(A % 0.01 * 1000))), B), HudPosition.RIGHT, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)


rule "Start - Player":
    @Event eachPlayer
    
    hudHeader(eventPlayer, l"{0} {1}".format(eventPlayer.A, floor(eventPlayer.A % 0.01 * 1000)), HudPosition.TOP, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.I = getLastCreatedText()
    hudHeader(eventPlayer, l"{0} - {1}".format(l"Best", l"{0} sec".format(l"{0} {1}".format(eventPlayer.B, floor(eventPlayer.B % 0.01 * 1000)))), HudPosition.LEFT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.J = getLastCreatedText()
    eventPlayer.K = getLastCreatedText()
    createInWorldText(eventPlayer, l"{0} m".format(distance(Y, eventPlayer)), Y + vect(0, 5, 0), 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
    createIcon(eventPlayer, Y + vect(0, 6, 0), Icon.FLAG, IconReeval.VISIBILITY_AND_POSITION, Color.WHITE, true)
    eventPlayer.B = 9999
    eventPlayer.F = false
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)
    eventPlayer.setStatusEffect(null, Status.STUNNED, 0.5)
    eventPlayer.F = false
    eventPlayer.teleport(Z)


rule "Floor":
    @Event eachPlayer
    @Condition eventPlayer.isOnGround() == true
    @Condition distance(Z, eventPlayer) > 4
    @Condition distance(Y, eventPlayer) > 6
    @Condition eventPlayer.M == 0
    
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)
    eventPlayer.setStatusEffect(null, Status.STUNNED, 0.25)
    eventPlayer.teleport(Z)
    eventPlayer.F = false
    eventPlayer.setInvisibility(Invis.ALL)
    stopChasingVariable(eventPlayer.A)
    eventPlayer.Shots = 0
    wait(0.25)
    eventPlayer.A = 0


rule "Finish":
    @Event eachPlayer
    @Condition distance(Y, vect(eventPlayer.getPosition().x, Y.y, eventPlayer.getPosition().z)) <= 5
    @Condition eventPlayer.F == false
    @Condition eventPlayer.M == 0
    
    eventPlayer.F = true
    stopChasingVariable(eventPlayer.A)
    if eventPlayer.A <= 1:
        return
    if eventPlayer.A >= A:
        goto lbl_0
    if B == eventPlayer:
        goto lbl_1
    if I != eventPlayer:
        goto lbl_2
    I = B
    G = A
    goto lbl_3
    lbl_2:
    J = I
    I = B
    H = G
    G = A
    lbl_1:
    lbl_3:
    A = eventPlayer.A
    B = eventPlayer
    eventPlayer.B = eventPlayer.A
    return
    if eventPlayer.A >= eventPlayer.B:
        goto lbl_4
    eventPlayer.B = eventPlayer.A
    lbl_0:
    if eventPlayer.A >= G:
        goto lbl_5
    if B == eventPlayer:
        goto lbl_6
    lbl_4:
    if I == eventPlayer:
        goto lbl_7
    H = G
    J = I
    lbl_7:
    G = eventPlayer.A
    I = eventPlayer
    return
    lbl_5:
    lbl_6:
    if eventPlayer.A >= H:
        goto lbl_8
    if B == eventPlayer:
        goto lbl_9
    if I == eventPlayer:
        goto lbl_10
    J = eventPlayer
    H = eventPlayer.A
    return
    lbl_8:
    lbl_9:
    lbl_10:
    bigMessage(eventPlayer, l"{0}!!!".format(l"Finished"))
    eventPlayer.setInvisibility(Invis.NONE)
    return


rule "Finish Message (Best Time)":
    @Event eachPlayer
    @Condition eventPlayer.F == true
    @Condition eventPlayer.M == 0
    @Condition eventPlayer.A < eventPlayer.B
    @Condition eventPlayer.A != A
    
    eventPlayer.B = eventPlayer.A
    wait(0.25)
    bigMessage(eventPlayer, l"{0} - {1}".format(l"{0} {1}".format(l"Best", l"Time"), l"{0} sec".format(l"{0} {1}".format(eventPlayer.B, floor(eventPlayer.B % 0.01 * 1000)))))


rule "Finish Message (Record Time)":
    @Event eachPlayer
    @Condition eventPlayer.F == true
    @Condition eventPlayer.M == 0
    @Condition eventPlayer.A == A
    
    wait(0.25)
    bigMessage(eventPlayer, l"{0} - {1}".format(l"New Record", l"{0} sec".format(l"{0} {1}".format(eventPlayer.B, floor(eventPlayer.B % 0.01 * 1000)))))


rule "Ult Reset":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE) == true
    @Condition eventPlayer.M == 0
    
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)
    eventPlayer.setStatusEffect(null, Status.STUNNED, 0.5)
    eventPlayer.teleport(Z)
    eventPlayer.F = false
    stopChasingVariable(eventPlayer.A)
    eventPlayer.setInvisibility(Invis.ALL)
    wait(0.25)
    eventPlayer.A = 0


rule "Ult Reset Checkpoint":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE) == true
    @Condition eventPlayer.M >= 1
    @Condition eventPlayer.O != 0
    
    eventPlayer.teleport(eventPlayer.O)
    eventPlayer.setFacing(angleToDirection(eventPlayer.P, eventPlayer.Q), Relativity.TO_WORLD)


rule "Start timer":
    @Event eachPlayer
    @Condition distance(Z, eventPlayer) > 2
    @Condition eventPlayer.M == 0
    
    chase(eventPlayer.A, 5000, rate=1, ChaseReeval.NONE)
    eventPlayer.F = false
    eventPlayer.setInvisibility(Invis.NONE)


rule "Spawn":
    @Event eachPlayer
    @Condition eventPlayer.isInSpawnRoom() == true
    
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)
    eventPlayer.setStatusEffect(null, Status.STUNNED, 0.5)
    stopChasingVariable(eventPlayer.A)
    eventPlayer.A = 0
    eventPlayer.teleport(Z)
    eventPlayer.F = false
    eventPlayer.setInvisibility(Invis.ALL)


rule "Circle Fix":
    @Event eachPlayer
    @Condition distance(Z, eventPlayer) <= 2
    @Condition eventPlayer.isOnGround() == true
    
    eventPlayer.Shots = 0
    stopChasingVariable(eventPlayer.A)
    eventPlayer.A = 0
    eventPlayer.F = false
    eventPlayer.setInvisibility(Invis.ALL)


rule "DISABLE PREHOP":
    @Event eachPlayer
    @Condition distance(Z, eventPlayer) <= 2.1
    @Condition eventPlayer.isOnGround() == true
    @Condition eventPlayer.getHorizontalSpeed() > 8.251
    
    eventPlayer.setStatusEffect(null, Status.KNOCKED_DOWN, 1)
    eventPlayer.setStatusEffect(null, Status.STUNNED, 0.5)


rule "Interact Spectating (Enabled)":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == true
    @Condition eventPlayer.M == 0
    
    eventPlayer.M = 1
    bigMessage(eventPlayer, l"{0} {1}".format(l"Exit", l"Current Game"))
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)
    eventPlayer.setStatusEffect(null, Status.STUNNED, 0.25)
    stopChasingVariable(eventPlayer.A)
    eventPlayer.A = 0
    eventPlayer.teleport(Z)
    eventPlayer.F = false
    eventPlayer.setInvisibility(Invis.ALL)


rule "Interact Spectating (Button Held - Enabled)":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == false
    @Condition eventPlayer.M == 1
    
    eventPlayer.M = 2


rule "Interact Spectating (disabled)":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == true
    @Condition eventPlayer.M == 2
    
    eventPlayer.M = 3
    bigMessage(eventPlayer, l"{0} {1}".format(l"Join", l"Current Game"))
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)
    eventPlayer.setStatusEffect(null, Status.STUNNED, 0.25)
    stopChasingVariable(eventPlayer.A)
    eventPlayer.A = 0
    eventPlayer.teleport(Z)
    eventPlayer.F = false
    eventPlayer.setInvisibility(Invis.ALL)


rule "Interact Spectating (Button Held - disabled)":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == false
    @Condition eventPlayer.M == 3
    
    eventPlayer.M = 0


rule "Fire status (Disabled)":
    @Event eachPlayer
    @Condition eventPlayer.M == 0
    
    destroyIcon(getLastCreatedEntity())
    eventPlayer.clearStatusEffect(Status.BURNING)
    eventPlayer.clearStatusEffect(Status.INVINCIBLE)
    destroyIcon(eventPlayer)


rule "Fire status (Enabled)":
    @Event eachPlayer
    @Condition eventPlayer.M >= 1
    
    eventPlayer.setStatusEffect(null, Status.BURNING, 9999)
    eventPlayer.setStatusEffect(null, Status.INVINCIBLE, 9999)


rule "Practice Checkpoints":
    @Event eachPlayer
    @Condition eventPlayer.M >= 1
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true
    
    eventPlayer.O = eventPlayer.getPosition()
    eventPlayer.P = eventPlayer.getHorizontalFacingAngle()
    eventPlayer.Q = eventPlayer.getVerticalFacingAngle()
    eventPlayer.R = eventPlayer.getVelocity()
    createIcon(eventPlayer, eventPlayer.O, Icon.FLAG, IconReeval.VISIBILITY_AND_POSITION, Color.GREEN, true)
    return


rule "Velocity Counter (red)":
    @Event eachPlayer
    @Condition eventPlayer.getSpeed() < 8.5
    @Condition eventPlayer.getCurrentHero() == Hero.BAPTISTE
    @Condition eventPlayer.S == true
    
    destroyHudText(getLastCreatedText())
    hudHeader(eventPlayer, l"{0} m/s".format(eventPlayer.getHorizontalSpeed()), HudPosition.TOP, 2, Color.RED, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)


rule "Velocity Counter (Yellow)":
    @Event eachPlayer
    @Condition eventPlayer.getSpeed() >= 8.5
    @Condition eventPlayer.getSpeed() < 15
    @Condition eventPlayer.getCurrentHero() == Hero.BAPTISTE
    @Condition eventPlayer.S == true
    
    destroyHudText(getLastCreatedText())
    hudHeader(eventPlayer, l"{0} m/s".format(eventPlayer.getHorizontalSpeed()), HudPosition.TOP, 2, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)


rule "Velocity Counter (Green)":
    @Event eachPlayer
    @Condition eventPlayer.getSpeed() >= 15
    @Condition eventPlayer.getCurrentHero() == Hero.BAPTISTE
    @Condition eventPlayer.S == true
    
    destroyHudText(getLastCreatedText())
    hudHeader(eventPlayer, l"{0} m/s".format(eventPlayer.getHorizontalSpeed()), HudPosition.TOP, 2, Color.GREEN, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)


rule "No damage rule":
    @Event eachPlayer
    
    heal(eventPlayer, null, 200)


rule "========== Everything below was edited by ĴewelƁutt for baptiste pogo ==========":


rule "Baptiste hud tag verification":
    @Event eachPlayer
    @Condition eventPlayer.getCurrentHero() == Hero.BAPTISTE
    
    hudHeader(eventPlayer, eventPlayer, HudPosition.LEFT, 0, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader(eventPlayer, l"{0} m/s".format(eventPlayer.ImpulseSpeed), HudPosition.LEFT, 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader(eventPlayer, l"{0}!".format(eventPlayer.Shots), HudPosition.TOP, 3, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader(eventPlayer, l"{0} m/s".format(eventPlayer.getHorizontalSpeed()), HudPosition.TOP, 2, Color.RED, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.S = true
    return


rule "Pogo":
    @Event eachPlayer
    @Hero baptiste
    @Condition eventPlayer.isFiringSecondaryFire() == true
    
    eventPlayer.HorizontalSpeed = eventPlayer.getHorizontalSpeed()
    eventPlayer.Velocity = eventPlayer.getVelocity()
    eventPlayer.RaycastHit = raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 100, getAllPlayers(), eventPlayer, true).getHitPosition()
    eventPlayer.FeetRaycastDistance = distance(eventPlayer, eventPlayer.RaycastHit)
    eventPlayer.EyesRaycastDistance = distance(eventPlayer.getEyePosition(), eventPlayer.RaycastHit)
    eventPlayer.ImpulseSpeed = 0
    if eventPlayer.FeetRaycastDistance > 4.35:
        return
    eventPlayer.ImpulseSpeed = 5.5
    if eventPlayer.isHoldingButton(Button.CROUCH):
        goto lbl_0
    eventPlayer.ImpulseSpeed = 21
    lbl_0:
    if eventPlayer.FeetRaycastDistance < 0.6 or eventPlayer.isHoldingButton(Button.CROUCH) == true:
        goto lbl_1
    eventPlayer.ImpulseSpeed = 22
    if eventPlayer.EyesRaycastDistance < 0.9:
        goto lbl_2
    eventPlayer.ImpulseSpeed = 22 - eventPlayer.FeetRaycastDistance * 4
    lbl_1:
    lbl_2:
    eventPlayer.applyImpulse(directionTowards(eventPlayer.RaycastHit, eventPlayer.getEyePosition()), eventPlayer.ImpulseSpeed, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.applyImpulse(vect(eventPlayer.Velocity.x, 0, eventPlayer.Velocity.z), eventPlayer.HorizontalSpeed, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    wait(0.25)
    eventPlayer.setMoveSpeed(ceil(150 + eventPlayer.getHorizontalSpeed() * (eventPlayer.getHorizontalSpeed() / 2)))


rule "Practice raycast":
    @Event eachPlayer
    @Condition eventPlayer.M >= 1
    @Condition raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 100, getAllPlayers(), eventPlayer, true).getHitPosition() != eventPlayer.PracticeRaycastHitPosition
    
    eventPlayer.PracticeRaycastHitPosition = raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 100, getAllPlayers(), eventPlayer, true).getHitPosition()
    wait(0.005)
    if RULE_CONDITION:
        goto RULE_START


rule "Pogo practice":
    @Event eachPlayer
    @Condition eventPlayer.M >= 1
    
    createEffect(eventPlayer, Effect.SPHERE, Color.RED, eventPlayer.PracticeRaycastHitPosition, 4.35, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.PracticeSphereBig = getLastCreatedEntity()
    wait(0.25)
    createEffect(eventPlayer, Effect.SPHERE, Color.GREEN, eventPlayer.PracticeRaycastHitPosition, 0.6, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.PracticeSphereSmall = getLastCreatedEntity()
    createEffect(eventPlayer, Effect.SPHERE, Color.PURPLE, eventPlayer.PracticeRaycastHitPosition, 0.9, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.PracticeSphereMedium = getLastCreatedEntity()


rule "Pogo exit practice":
    @Event eachPlayer
    @Condition eventPlayer.M == 0
    
    destroyEffect(eventPlayer.PracticeSphereBig)
    destroyEffect(eventPlayer.PracticeSphereSmall)
    destroyEffect(eventPlayer.PracticeSphereMedium)


rule "Pogo number of shots":
    @Event eachPlayer
    @Condition eventPlayer.isFiringSecondaryFire() == true
    @Condition eventPlayer.F != true
    
    eventPlayer.Shots = eventPlayer.Shots + 1


rule "Baptiste speed in air":
    @Event eachPlayer
    @Condition eventPlayer.isOnGround() == false
    
    eventPlayer.setMoveSpeed(150)


rule "Set speed to 150 if below 8.25":
    @Event eachPlayer
    @Condition eventPlayer.isOnGround() == false
    @Condition eventPlayer.getHorizontalSpeed() < 8.25
    
    eventPlayer.setMoveSpeed(150)


rule "track speed":
    @Event eachPlayer
    @Condition eventPlayer.getHorizontalSpeed() > eventPlayer.HorizontalSpeedTracker
    
    wait(0.5)
    if not RULE_CONDITION:
        return
    eventPlayer.HorizontalSpeedTracker = eventPlayer.getHorizontalSpeed()
    wait()
    if RULE_CONDITION:
        goto RULE_START


rule "Slow down if too slow":
    @Event eachPlayer
    @Condition eventPlayer.isOnGround() == false
    @Condition eventPlayer.getHorizontalSpeed() > 8.25
    @Condition eventPlayer.getHorizontalSpeed() < 19
    @Condition eventPlayer.getHorizontalSpeed() < eventPlayer.HorizontalSpeedTracker - 2
    
    wait()
    if not RULE_CONDITION:
        return
    eventPlayer.HorizontalSpeedTracker = eventPlayer.getHorizontalSpeed()
    eventPlayer.setMoveSpeed(ceil(ceil(eventPlayer.getHorizontalSpeed()) * 16.666))
    wait(0.25)
    if RULE_CONDITION:
        goto RULE_START


rule "Baptiste speed on ground to avoid insta stun when moving in circle":
    @Event eachPlayer
    @Condition eventPlayer.isOnGround() == true
    
    eventPlayer.setMoveSpeed(125)
    eventPlayer.Unused = 150
    eventPlayer.HorizontalSpeedTracker = 0
    wait(1)
    if RULE_CONDITION:
        goto RULE_START


