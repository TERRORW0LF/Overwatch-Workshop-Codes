#Global variables

globalvar TimeFirst 0
globalvar TimeSecond 1
globalvar TimeThird 2
globalvar PlayerFirst 3
globalvar PlayerSecond 4
globalvar PlayerThird 5
globalvar Checkpoint 6
globalvar Visible 7
globalvar Season 8
globalvar Mode 9
globalvar Time 10
globalvar Infinite 11
globalvar PosStart 24
globalvar PosCheckpoint 25
globalvar PosFinish 26


#Player variables

playervar TimeCurrent 0
playervar TimeBest 1
playervar NewBest 2
playervar Checkpoint 3
playervar Finished 4
playervar AutoReset 5
playervar HideHelp 6
playervar Mode 7
playervar Attempts 8
playervar SpeedColor 9
playervar Speed 10
playervar Reset 11
playervar PosPracticeCheckpoint 14
playervar FacingPracticeCheckpoint 15
playervar VelocityPracticeCheckpoint 16
playervar SpeedPracticeCheckpoint 17


#Subroutine names

subroutine Respawn 0


#Debug
rule "Debug (Global)":
    @Disabled


rule "Debug (Player)":
    @Disabled
    @Event eachPlayer

    hudHeader(eventPlayer, "{0}".format(eventPlayer.getPosition()), HudPosition.TOP, 4, Color.WHITE, HudReeval.STRING)


#Settings
rule "Workshop Settings":
    Season = createWorkshopSetting(enum["Season 1", "Season 2", "Season 3", "Season 4"], "Combo", "Season", 0, 0)
    Mode = createWorkshopSetting(enum["Standard", "Gravspeed"], "Combo", "Mode", 1, 1)
    Time = createWorkshopSetting(int[60:3600], "Time", "Seconds", 600, 0)
    Infinite = createWorkshopSetting(bool, "Time", "Infinite", false, 1)


rule "Apply Settings":
    @Event eachPlayer
    @Condition eventPlayer.hasSpawned()

    if not Mode:
        eventPlayer.setMoveSpeed(100)
        eventPlayer.setGravity(100)
    elif Mode == 1:
        eventPlayer.setMoveSpeed(125)
        eventPlayer.setGravity(80)


#Maps
rule "Start - Maps (Season 1)":
    @Condition not Season
    
    Checkpoint = false
    #Assault
    if getCurrentMap() == Map.HANAMURA:
        PosStart = vect(58, -1.87, 34)
        PosFinish = vect(-10.57, -1.02, -84.71)
        return
    if getCurrentMap() == Map.HORIZON_LUNAR_COLONY:
        PosStart = vect(19, 13, -45.5)
        PosFinish = vect(-24.74, 2.5, -121)
        return
    if getCurrentMap() == Map.PARIS:
        PosStart = vect(-14.4, 14, -35.75)
        PosFinish = vect(-104, 14.5, -100)
        return
    if getCurrentMap() == Map.TEMPLE_OF_ANUBIS:
        PosStart = vect(-1, -2.32, -9)
        PosFinish = vect(-7.5, 4.57, 111.3)
        return
    if getCurrentMap() == Map.VOLSKAYA:
        PosStart = vect(18, -5, 23)
        PosFinish = vect(-94.24, -2.08, 49.3)
        return
    #Escort
    if getCurrentMap() == Map.DORADO:
        PosStart = vect(12.5, 0, 6)
        PosFinish = vect(184.19, 13.7, 40.32)
        return
    if getCurrentMap() == Map.HAVANA:
        PosStart = vect(-98, 4, -93)
        PosFinish = vect(140.14, 5.9, -46.38)
        return
    if getCurrentMap() == Map.JUNKERTOWN:
        PosStart = vect(-46.5, 9.5, -47.5)
        PosFinish = vect(-92.82, 5.28, -119.06)
        return
    if getCurrentMap() == Map.RIALTO:
        PosStart = vect(106.5, -1.25, -15.5)
        PosFinish = vect(-57, 2.5, -131.67)
        return
    if getCurrentMap() == Map.ROUTE66:
        PosStart = vect(38.5, 5.5, 36.5)
        PosFinish = vect(-92.49, 6.4, -23.25)
        return
    if getCurrentMap() == Map.WATCHPOINT_GIBRALTAR:
        PosStart = vect(39, 4, -124.5)
        PosFinish = vect(82.46, -1, 39.99)
        return
    #Hybrid
    if getCurrentMap() == Map.BLIZZ_WORLD:
        PosStart = vect(3, -0.1, 21.5)
        PosFinish = vect(-122.14, -0.5, 110.64)
        return
    if getCurrentMap() == Map.EICHENWALDE:
        PosStart = vect(2, 6, 0.5)
        PosFinish = vect(123.63, 8.62, -27.05)
        return
    if getCurrentMap() == Map.HOLLYWOOD:
        PosStart = vect(-52, -0.25, 12.5)
        PosFinish = vect(-35.08, 1.65, -134.97)
        return
    if getCurrentMap() == Map.KINGS_ROW:
        PosStart = vect(-12, -0.12, 12.5)
        PosFinish = vect(-149.09, -3.1, 24.25)
        return
    if getCurrentMap() == Map.NUMBANI:
        PosStart = vect(18, 0.08, 13)
        PosFinish = vect(206.99, -2.29, 22.14)
        return
    #Control
    if getCurrentMap() == Map.BUSAN:
        #Downtown
        if getCurrentObjective() == 0:
            PosStart = vect(99, 15.93, -125.5)
            PosFinish = vect(-3.5, 15.8, -125)
            return
        #MEKA Base
        if getCurrentObjective() == 2:
            PosStart = vect(165, 10.1, 255)
            PosFinish = vect(275.5, 10, 210.5)
            return
        #Sanctuary
        if getCurrentObjective() == 1:
            PosStart = vect(-255.5, 9.36, 147)
            PosFinish = vect(-397, 9.1, 171)
            return
    if getCurrentMap() == Map.ILIOS:
        #Lighthouse
        if getCurrentObjective() == 0:
            PosStart = vect(329, -25.6, 22)
            PosFinish = vect(290, -25.74, -89)
            return
        #Ruins
        if getCurrentObjective() == 2:
            PosStart = vect(112, 65.39, -178)
            PosFinish = vect(-58.5, 60.3, -150)
            return
        #Well
        if getCurrentObjective() == 1:
            PosStart = vect(-159, -5.06, -75.5)
            PosFinish = vect(-264.5, -5.2, 29.5)
            return
    if getCurrentMap() == Map.LIJIANG_TOWER:
        #Control Tower
        if getCurrentObjective() == 2:
            PosStart = vect(44, 265, 327)
            PosFinish = vect(-35.5, 266.9, 316.75)
            return
        #Garden
        if getCurrentObjective() == 1:
            PosStart = vect(64.5, 94, 145.5)
            PosFinish = vect(-61, 93.9, 148)
            return
        #Night Market
        if getCurrentObjective() == 0:
            PosStart = vect(61, 2, -34)
            PosFinish = vect(-54.25, 5.9, -11.75)
            return
    if getCurrentMap() == Map.NEPAL:
        #Sanctum
        if getCurrentObjective() == 2:
            PosStart = vect(81, 131.8, 36)
            PosFinish = vect(81, 131.7, -35.5)
            return
        #Shrine
        if getCurrentObjective() == 1:
            PosStart = vect(-38.5, 14.88, 60)
            PosFinish = vect(-49, 14.9, -74)
            return
        #Village
        if getCurrentObjective() == 0:
            PosStart = vect(-191, -98.23, 60)
            PosFinish = vect(-176.5, -99.5, -71)
            return
    if getCurrentMap() == Map.OASIS:
        #City Center
        if getCurrentObjective() == 0:
            PosStart = vect(101, 1, 309.5)
            PosFinish = vect(195, 0.75, 200)
            return
        #Gardens
        if getCurrentObjective() == 1:
            PosStart = vect(182, 8, -223.5)
            PosFinish = vect(103, 7.9, -285.5)
            return
        #University
        if getCurrentObjective() == 2:
            PosStart = vect(-188, 18, 50.5)
            PosFinish = vect(-188.25, 17.9, -58)


rule "Start - Maps (Season 2)":
    @Condition Season == 1
    
    Checkpoint = false
    #Assault
    if getCurrentMap() == Map.HANAMURA:
        PosStart = vect(-6.786, -0.92, -84.457)
        PosFinish = vect(58, -2.1, 34)
        return
    if getCurrentMap() == Map.HORIZON_LUNAR_COLONY:
        PosStart = vect(-19.673, 2.75, -120.219)
        PosFinish = vect(19, 6.9, -45.5)
        return
    if getCurrentMap() == Map.PARIS:
        PosStart = vect(-87.011, 13, -104.458)
        PosFinish = vect(-14.4, 13.9, -35.75)
        return
    if getCurrentMap() == Map.TEMPLE_OF_ANUBIS:
        PosStart = vect(-11.096, 4.66, 110.46)
        PosFinish = vect(-1, -2.8, -9)
        return
    if getCurrentMap() == Map.VOLSKAYA:
        PosStart = vect(-92.538, 2.02, 59.543)
        PosFinish = vect(18, -5.1, 23)
        return
    #Escort
    if getCurrentMap() == Map.DORADO:
        PosStart = vect(190.171, 14.1, 35.423)
        PosFinish = vect(12.5, -0.3, 6)
        return
    if getCurrentMap() == Map.HAVANA:
        PosStart = vect(138.376, 6, -34.025)
        PosFinish = vect(-98, 3.9, -93)
        return
    if getCurrentMap() == Map.JUNKERTOWN:
        PosStart = vect(-89.759, 7.05, -105.446)
        PosFinish = vect(-46.5, 9.4, -47.5)
        return
    if getCurrentMap() == Map.RIALTO:
        PosStart = vect(-65.683, 4.75, -144.738)
        PosFinish = vect(106.5, -1.5, -15.5)
        return
    if getCurrentMap() == Map.ROUTE66:
        PosStart = vect(-89.645, 6.5, -32.632)
        PosFinish = vect(38.5, 4.6, 36.5)
        return
    if getCurrentMap() == Map.WATCHPOINT_GIBRALTAR:
        PosStart = vect(65.011, 1, 47.639)
        PosFinish = vect(39, 3.9, -124.5)
        return
    #Hybrid
    if getCurrentMap() == Map.BLIZZ_WORLD:
        PosStart = vect(-121.57, -0.4, 116.2)
        PosFinish = vect(3, -0.2, 21.5)
        return
    if getCurrentMap() == Map.EICHENWALDE:
        PosStart = vect(126.088, 14.76, -17.073)
        PosFinish = vect(2, 5.9, 0.5)
        return
    if getCurrentMap() == Map.HOLLYWOOD:
        PosStart = vect(-33.426, 1.75, -140.166)
        PosFinish = vect(-52, -0.5, 12.5)
        return
    if getCurrentMap() == Map.KINGS_ROW:
        PosStart = vect(-157.049, 0.07, 38.51)
        PosFinish = vect(-12, -0.2, 12.5)
        return
    if getCurrentMap() == Map.NUMBANI:
        PosStart = vect(201.699, 4.2, 38.253)
        PosFinish = vect(18, -0.3, 13)
        return
    #Control
    if getCurrentMap() == Map.BUSAN:
        #Downtown
        if getCurrentObjective() == 0:
            PosStart = vect(-1.544, 15.93, -128.594)
            PosFinish = vect(99, 14.5, -125.5)
            return
        #MEKA Base
        if getCurrentObjective() == 2:
            PosStart = vect(275.5, 10.1, 210.5)
            PosFinish = vect(165, 10, 255)
            return
        #Sanctuary
        if getCurrentObjective() == 1:
            PosStart = vect(-391.367, 9.36, 168.276)
            PosFinish = vect(-255.5, 9.26, 147)
            return
    if getCurrentMap() == Map.ILIOS:
        #Lighthouse
        if getCurrentObjective() == 0:
            PosStart = vect(288.533, -25.57, -100.389)
            PosFinish = vect(329, -25.7, 22)
            return
        #Ruins
        if getCurrentObjective() == 2:
            PosStart = vect(-58.5, 60.58, -150)
            PosFinish = vect(112, 60.3, -178)
            return
        #Well
        if getCurrentObjective() == 1:
            PosStart = vect(-264.5, -5.1, 29.5)
            PosFinish = vect(-159, -5.2, -75.5)
            return
    if getCurrentMap() == Map.LIJIANG_TOWER:
        #Control Tower
        if getCurrentObjective() == 2:
            PosStart = vect(-35.5, 267, 316.75)
            PosFinish = vect(44, 264.9, 327)
            return
        #Garden
        if getCurrentObjective() == 1:
            PosStart = vect(-65.211, 94, 145.476)
            PosFinish = vect(64.5, 93.9, 145.5)
            return
        #Night Market
        if getCurrentObjective() == 0:
            PosStart = vect(-56.087, 1.86, -35.084)
            PosFinish = vect(61, 1.8, -34)
            return
    if getCurrentMap() == Map.NEPAL:
        #Sanctum
        if getCurrentObjective() == 2:
            PosStart = vect(81, 131.8, -35.5)
            PosFinish = vect(81, 131.7, 36)
            return
        #Shrine
        if getCurrentObjective() == 1:
            PosStart = vect(-70.647, 16.89, -64.165)
            PosFinish = vect(-38.5, 13.6, 60)
            return
        #Village
        if getCurrentObjective() == 0:
            PosStart = vect(-184.744, -96.5, -75.548)
            PosFinish = vect(-191, -98.7, 60)
    if getCurrentMap() == Map.OASIS:
        #City Center
        if getCurrentObjective() == 0:
            PosStart = vect(211.712, 1, 203.561)
            PosFinish = vect(101, 0.75, 309.5)
            return
        #Gardens
        if getCurrentObjective() == 1:
            PosStart = vect(101.075, 8, -271.365)
            PosFinish = vect(182, 7.4, -223.5)
            return
        #University
        if getCurrentObjective() == 2:
            PosStart = vect(-187.904, 19.77, -69.197)
            PosFinish = vect(-188, 16.9, 50.5)


rule "Start - Maps (Season 3)":
    @Condition Season == 2
    
    Checkpoint = true
    #Assault
    if getCurrentMap() == Map.HANAMURA:
        PosStart = vect(55.024, -1.92, 41.766)
        PosCheckpoint = vect(76.329, -3.55, 97.421)
        PosFinish = vect(91.752, -2.1, 17.33)
        return
    if getCurrentMap() == Map.HORIZON_LUNAR_COLONY:
        PosStart = vect(20.101, 6, -107.386)
        PosCheckpoint = vect(94.12, 10.4, -56.787)
        PosFinish = vect(47.863, 5.9, -37.389)
        return
    if getCurrentMap() == Map.PARIS:
        PosStart = vect(-77.279, 12.07, -2.75)
        PosCheckpoint = vect(-43.506, 11, -34.903)
        PosFinish = vect(-119.113, 9.9, -69.934)
        return
    if getCurrentMap() == Map.TEMPLE_OF_ANUBIS:
        PosStart = vect(-59.379, 6.5, 44.914)
        PosCheckpoint = vect(16.802, 2.3, 106.979)
        PosFinish = vect(-36.8, 9, 2.543)
        return
    if getCurrentMap() == Map.VOLSKAYA:
        PosStart = vect(-32.824, -2.94, 48.356)
        PosCheckpoint = vect(16.248, -5.1, 25.782)
        PosFinish = vect(2.417, -8, 107.37)
        return
    #Escort
    if getCurrentMap() == Map.DORADO:
        PosStart = vect(167.15, 18.01, 68)
        PosCheckpoint = vect(68, 16.9, 40)
        PosFinish = vect(125, 6.9, -18)
        return
    if getCurrentMap() == Map.HAVANA:
        PosStart = vect(101.15, 2.17, -82.72)
        PosCheckpoint = vect(6, 5.7, -75)
        PosFinish = vect(42.47, 5.9, -47)
        return
    if getCurrentMap() == Map.JUNKERTOWN:
        PosStart = vect(32.55, 15.2, -89.45)
        PosCheckpoint = vect(-18, 6.4, -90)
        PosFinish = vect(-46.5, 9.4, -47.5)
        return
    if getCurrentMap() == Map.RIALTO:
        PosStart = vect(110.31, -0.25, -34.22)
        PosCheckpoint = vect(33, 0.55, -36.59)
        PosFinish = vect(-15, 5.65, -55)
        return
    if getCurrentMap() == Map.ROUTE66:
        PosStart = vect(37.82, 2.01, 16.71)
        PosCheckpoint = vect(16, 7.8, -23)
        PosFinish = vect(51, 0.1, 45)
        return
    if getCurrentMap() == Map.WATCHPOINT_GIBRALTAR:
        PosStart = vect(5.42, -5, -81.88)
        PosCheckpoint = vect(89, 2.9, -27)
        PosFinish = vect(97.362, -6, 38.946)
        return
    #Hybrid
    if getCurrentMap() == Map.BLIZZ_WORLD:
        PosStart = vect(23.31, 2, 79.2)
        PosCheckpoint = vect(-72.57, 6.5, 105.2)
        PosFinish = vect(-8, -1.1, 103.66)
        return
    if getCurrentMap() == Map.EICHENWALDE:
        PosStart = vect(54.97, 22.68, -104.11)
        PosCheckpoint = vect(4.93, 4.9, -14.1)
        PosFinish = vect(64.74, 15.5, -61.86)
        return
    if getCurrentMap() == Map.HOLLYWOOD:
        PosStart = vect(-29.04, 13.86, -12.75)
        PosCheckpoint = vect(19.77, 4.8, 59.12)
        PosFinish = vect(-42.39, -0.25, 54.98)
        return
    if getCurrentMap() == Map.KINGS_ROW:
        PosStart = vect(14.73, 6, 18.19)
        PosCheckpoint = vect(-60, -0.2, -47.5)
        PosFinish = vect(-98.35, 0.6, -6.78)
        return
    if getCurrentMap() == Map.NUMBANI:
        PosStart = vect(88.38, 4.25, -24.17)
        PosCheckpoint = vect(129.52, -3.85, 38.61)
        PosFinish = vect(204.25, -2.25, 22.61)
        return
    #Control
    if getCurrentMap() == Map.BUSAN:
        #Downtown
        if getCurrentObjective() == 0:
            PosStart = vect(51.9, 21.4, -129)
            PosCheckpoint = vect(51.9, 4.78, -74)
            PosFinish = vect(51.9, 10.9, -147.9)
            return
        #MEKA Base
        if getCurrentObjective() == 2:
            PosStart = vect(210, 9.1, 212)
            PosCheckpoint = vect(205.5, 9, 202)
            PosFinish = vect(226, 9, 250)
            return
        #Sanctuary
        if getCurrentObjective() == 1:
            PosStart = vect(-328.5, 8, 180.5)
            PosCheckpoint = vect(-328.5, 9.72, 107.4)
            PosFinish = vect(-328.5, 9, 195)
            return
    if getCurrentMap() == Map.ILIOS:
        #Lighthouse
        if getCurrentObjective() == 0:
            PosStart = vect(318, -23.66, -35)
            PosCheckpoint = vect(365, -25.73, -54.5)
            PosFinish = vect(307.8, -11.1, 31.4)
            return
        #Ruins
        if getCurrentObjective() == 2:
            PosStart = vect(28.5, 57.37, -141.5)
            PosCheckpoint = vect(-55, 65, -178)
            PosFinish = vect(11.9, 66.2, -144.2)
            return
        #Well
        if getCurrentObjective() == 1:
            PosStart = vect(-195, 1, -3)
            PosCheckpoint = vect(-284, -0.55, 10)
            PosFinish = vect(-271.9, 1.2, 53.5)
            return
    if getCurrentMap() == Map.LIJIANG_TOWER:
        #Control Tower
        if getCurrentObjective() == 2:
            PosStart = vect(0, 278, 293)
            PosCheckpoint = vect(0, 274, 330)
            PosFinish = vect(0, 269.9, 254)
            return
        #Garden
        if getCurrentObjective() == 1:
            PosStart = vect(-65, 94, 145)
            PosCheckpoint = vect(0, 94.9, 125)
            PosFinish = vect(52, 90, 182)
            return
        #Night Market
        if getCurrentObjective() == 0:
            PosStart = vect(1, -2, -82)
            PosCheckpoint = vect(49, 1.76, -47)
            PosFinish = vect(1, -0.1, -10)
            return
    if getCurrentMap() == Map.NEPAL:
        #Sanctum
        if getCurrentObjective() == 0:
            PosStart = vect(78, 129.8, -59)
            PosCheckpoint = vect(81, 127.9, 8)
            PosFinish = vect(102, 131.9, 78)
            return
        #Shrine
        if getCurrentObjective() == 2:
            PosStart = vect(-26, 10.62, -34)
            PosCheckpoint = vect(-63, 12.9, 0)
            PosFinish = vect(-24, 14.9, 82)
            return
        #Village
        if getCurrentObjective() == 1:
            PosStart = vect(-158, -88.94, 0)
            PosCheckpoint = vect(-220, -94.1, 0)
            PosFinish = vect(-207, -87.1, -44)
            return
    if getCurrentMap() == Map.OASIS:
        #City Center
        if getCurrentObjective() == 0:
            PosStart = vect(166, 4, 270)
            PosCheckpoint = vect(102, -2, 288)
            PosFinish = vect(119, 0.5, 223)
            return
        #Gardens
        if getCurrentObjective() == 1:
            PosStart = vect(172.66, 8.4, -166)
            PosCheckpoint = vect(141.33, 7.3, -247.33)
            PosFinish = vect(101.5, -1, -207.5)
            return
        #University
        if getCurrentObjective() == 2:
            PosStart = vect(-198, 9, 0)
            PosCheckpoint = vect(-220, 18.9, 0)
            PosFinish = vect(-175, 15.9, 61.5)
            
            
            
rule "Start - Maps (Season 4)":
    @Condition Season == 3
    
    #Assault
    if getCurrentMap() == Map.HANAMURA:
        PosStart = vect(85.867, -2.02, 16.524)
        PosCheckpoint = vect(64.123, -3.4, 84.188)
        PosFinish = vect(30.542, 1.9, 40.845)
        Checkpoint = true
        return
    if getCurrentMap() == Map.HORIZON_LUNAR_COLONY:
        PosStart = vect(-38.253, 10, -122.811)
        PosCheckpoint = vect(43.183, 13.9, -77.129)
        PosFinish = vect(25.671, 6.9, -15.62)
        Checkpoint = true
        return
    if getCurrentMap() == Map.PARIS:
        PosStart = vect(-119.964, 9.86, -51.908)
        PosCheckpoint = vect(-44.044, 11, -33.258)
        PosFinish = vect(15.807, 9.8, -57.496)
        Checkpoint = true
        return
    if getCurrentMap() == Map.TEMPLE_OF_ANUBIS:
        PosStart = vect(9.122, 4.4, 124.801)
        PosFinish = vect(14.464, 10, 12.459)
        Checkpoint = false
        return
    if getCurrentMap() == Map.VOLSKAYA:
        PosStart = vect(-96.722, -2.48, 24.146)
        PosCheckpoint = vect(-37.356, 1.9, 98.043)
        PosFinish = vect(-30.133, 1.9, 38.232)
        Checkpoint = true
        return
    #Escort
    if getCurrentMap() == Map.DORADO:
        PosStart = vect(62.246, 13.42, 21.758)
        PosCheckpoint = vect(117.076, 17.9, 5.438)
        PosFinish = vect(26.047, 3.9, -41.35)
        Checkpoint = true
        return
    if getCurrentMap() == Map.HAVANA:
        PosStart = vect(-107.317, 4, -59.178)
        PosFinish = vect(65.054, 10.82, -83.635)
        Checkpoint = false
        return
    if getCurrentMap() == Map.JUNKERTOWN:
        PosStart = vect(-49.399, 9.49, -42.145)
        PosCheckpoint = vect(-46.378, 17.6, -90.257)
        PosFinish = vect(40.235, 8.7, -51.024)
        Checkpoint = true
        return
    if getCurrentMap() == Map.RIALTO:
        PosStart = vect(-31.663, 1.75, -115.564)
        PosFinish = vect(160.704, -3.678, -62.886)
        Checkpoint = false
        return
    if getCurrentMap() == Map.ROUTE66:
        PosStart = vect(71.704, -0.06, 11.87)
        PosCheckpoint = vect(-42.605, 3.3, 5.206)
        PosFinish = vect(-100.763, 8.4, 8.128)
        Checkpoint = true
        return
    if getCurrentMap() == Map.WATCHPOINT_GIBRALTAR:
        PosStart = vect(83.581, 3.04, -31.786)
        PosCheckpoint = vect(66.186, -2.1, -114.804)
        PosFinish = vect(22.688, -6.1, -159.187)
        Checkpoint = true
        return
    #Hybrid
    if getCurrentMap() == Map.BLIZZ_WORLD:
        PosStart = vect(52.118, -0.81, -7.795)
        PosCheckpoint = vect(53.816, -6.5, -87.717)
        PosFinish = vect(-57.568, -3.9, -5.401)
        Checkpoint = true
        return
    if getCurrentMap() == Map.EICHENWALDE:
        PosStart = vect(2.656, 6, 0.346)
        PosCheckpoint = vect(31.753, 13.5, -79.386)
        PosFinish = vect(83.903, 12.6, -87.977)
        Checkpoint = true
        return
    if getCurrentMap() == Map.HOLLYWOOD:
        PosStart = vect(-25.875, 1.75, 21.201)
        PosCheckpoint = vect(12.661, 1.6, -86.28)
        PosFinish = vect(-38.232, 8.62, -116.867)
        Checkpoint = true
        return
    if getCurrentMap() == Map.KINGS_ROW:
        PosStart = vect(4.83, 6, -1.205)
        PosCheckpoint = vect(-83.851, 0, 4.438)
        PosFinish = vect(-118.429, -1.4, 24.984)
        Checkpoint = true
        return
    if getCurrentMap() == Map.NUMBANI:
        PosStart = vect(144.571, 2.25, 29.313)
        PosCheckpoint = vect(49.435, 1.6, -6.419)
        PosFinish = vect(163.628, 4.15, -0.052)
        Checkpoint = true
        return
    #Control
    if getCurrentMap() == Map.BUSAN:
        #Downtown
        if not getCurrentObjective():
            PosStart = vect(84.198, 15, -142.989)
            PosCheckpoint = vect(22.583, 7.9, -81.736)
            PosFinish = vect(-12.436, 15.9, -117.693)
            Checkpoint = true
            return
        #MEKA Base
        if getCurrentObjective() == 2:
            PosStart = vect(165.682, 10.09, 271.056)
            PosFinish = vect(247.878, 13, 199.614)
            Checkpoint = false
            return
        #Sanctuary
        if getCurrentObjective() == 1:
            PosStart = vect(-284.514, 12.05, 174.822)
            PosCheckpoint = vect(-382.463, 9, 138.889)
            PosFinish = vect(-271.677, 9, 137.999)
            Checkpoint = true
            return
    if getCurrentMap() == Map.ILIOS:
        #Lighthouse
        if not getCurrentObjective():
            PosStart = vect(284.738, -17.94, -75.819)
            PosCheckpoint = vect(363.517, -18.4, -53.426)
            PosFinish = vect(336.947, -25.7, 22.725)
            Checkpoint = true
            return
        #Ruins
        if getCurrentObjective() == 2:
            PosStart = vect(111.647, 65.39, -177.77)
            PosCheckpoint = vect(28.446, 61.39, -143.87)
            PosFinish = vect(-55.178, 65.3, -178.229)
            Checkpoint = true
            return
        #Well
        if getCurrentObjective() == 1:
            PosStart = vect(-258.986, -0.5, 48.481)
            PosCheckpoint = vect(-224.969, 5.3, -33.21)
            PosFinish = vect(-141.105, 10.5, -87.497)
            Checkpoint = true
    if getCurrentMap() == Map.LIJIANG_TOWER:
        #Control Tower
        if getCurrentObjective() == 2:
            PosStart = vect(-26.497, 270, 340.286)
            PosCheckpoint = vect(10.656, 269.9, 261.943)
            PosFinish = vect(27.763, 269.9, 355.578)
            Checkpoint = true
            return
        #Garden
        if getCurrentObjective() == 1:
            PosStart = vect(61.321, 98, 161.408)
            PosCheckpoint = vect(-0.067, 95.9, 107.872)
            PosFinish = vect(-68.698, 97.9, 163.209)
            Checkpoint = true
            return
        #Night Market
        if not getCurrentObjective():
            PosStart = vect(61.03, 6, -10.232)
            PosCheckpoint = vect(1.479, -1.1, -59.482)
            PosFinish = vect(-58.911, 5.9, -10.302)
            Checkpoint = true
            return
    if getCurrentMap() == Map.NEPAL:
        #Sanctum
        if getCurrentObjective() == 2:
            PosStart = vect(107.495, 133.1, -73.174)
            PosCheckpoint = vect(55.295, 129.7, 0.52)
            PosFinish = vect(102.618, 135.9, 78.165)
            Checkpoint = true
            return
        #Shrine
        if getCurrentObjective() == 1:
            PosStart = vect(-22.294, 22, 76.936)
            PosFinish = vect(-50.994, 14.9, -77.311)
            Checkpoint = false
            return
        #Village
        if not getCurrentObjective():
            PosStart = vect(-168.653, -97.53, -48.431)
            PosCheckpoint = vect(-221.123, -89.5, 0.323)
            PosFinish = vect(-147.782, -92.5, 62.105)
            Checkpoint = true
            return
    if getCurrentMap() == Map.OASIS:
        #City Center
        if not getCurrentObjective():
            PosStart = vect(84.599, 1, 298.498)
            PosCheckpoint = vect(157.26, 3.9, 264.225)
            PosFinish = vect(157.23, 0.8, 205.119)
            Checkpoint = true
            return
        #Gardens
        if getCurrentObjective() == 1:
            PosStart = vect(73.282, 7.5, -285.746)
            PosFinish = vect(155.223, 9.9, -186.502)
            Checkpoint = false
            return
        #University
        if getCurrentObjective() == 2:
            PosStart = vect(-208.867, 20.33, -71.688)
            PosCheckpoint = vect(-172.403, 16.9, 2.078)
            PosFinish = vect(-188.53, 17.9, 60.728)
            Checkpoint = true


rule "Start - Global":
    #Vars
    setMatchTime(Time)
    TimeFirst = 9999
    TimeSecond = 9999
    TimeThird = 9999
    Visible = true
    #Start / Checkpoint / Finish effects
    createEffect(getAllPlayers(), Effect.RING, Color.GREEN, PosStart, 2, EffectReeval.VISIBILITY)
    createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, Color.WHITE, PosFinish, 5, EffectReeval.VISIBILITY)
    createEffect(getAllPlayers(), Effect.RING, Color.WHITE, PosFinish, 5, EffectReeval.VISIBILITY)
    createIcon(getAllPlayers(), PosFinish + vect(0, 6, 0), Icon.FLAG, IconReeval.VISIBILITY, Color.WHITE, true)
    if Checkpoint:
        createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, Color.SKY_BLUE, PosCheckpoint, 3.5, EffectReeval.VISIBILITY)
        createEffect(getAllPlayers(), Effect.RING, Color.SKY_BLUE, PosCheckpoint, 3.5, EffectReeval.VISIBILITY)
        createIcon(getAllPlayers(), PosCheckpoint + vect(0, 6, 0), Icon.ARROW_DOWN, IconReeval.VISIBILITY, Color.SKY_BLUE, true)
    #Seaons / Mode information
    hudHeader(getAllPlayers(), "Lucio Surf v4.2 | Season {0} | {1}".format(Season + 1, "Standard" if not Mode else "Gravspeed"), HudPosition.RIGHT, 0, Color.YELLOW, HudReeval.VISIBILITY)
    #Leaderboards
    hudHeader(getAllPlayers(), l"{0} - {1} - {2}".format(l"Record", l"{0} sec".format(TimeFirst), PlayerFirst), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudHeader(getAllPlayers(), l"{0} - {1} - {2}".format("2", l"{0} sec".format(TimeSecond), PlayerSecond), HudPosition.RIGHT, 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudHeader(getAllPlayers(), l"{0} - {1} - {2}".format("3", l"{0} sec".format(TimeThird), PlayerThird), HudPosition.RIGHT, 3, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    #Help text standard
    hudSubtext(getAllPlayers(), "Toggle Help - 'Ultimate Status'", HudPosition.LEFT, 3, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and player.Mode != -1 and player == hostPlayer], "Toggle Invisibility - 'Need Healing'", HudPosition.LEFT, 4, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and not player.Mode], "Reset - Ultimate", HudPosition.LEFT, 5, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and not player.Mode], "Cycle Auto Reset - Primary Fire", HudPosition.LEFT, 6, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and not player.Mode], "Practice Mode - Interact", HudPosition.LEFT, 7, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and not player.Mode], "Player Spectator Mode - Ability 2", HudPosition.LEFT, 8, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and not player.Mode], "Spectator Mode - Reload", HudPosition.LEFT, 9, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    #Help text practice
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and player.Mode >= 1 and player.Mode <= 3], "Standard Mode - Interact", HudPosition.LEFT, 5, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and player.Mode >= 1 and player.Mode <= 3], "Ult Reset (Checkpoint) - Ultimate", HudPosition.LEFT, 6, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and player.Mode >= 1 and player.Mode <= 3], "Set Checkpoint - Secondary Fire", HudPosition.LEFT, 7, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    #Help text playerspec
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and player.Mode >= 4 and player.Mode <= 6], "Standard Mode - Ability 2", HudPosition.LEFT, 5, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and player.Mode >= 4 and player.Mode <= 6], "Spectate next - Primary Fire", HudPosition.LEFT, 6, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and player.Mode >= 4 and player.Mode <= 6], "Spectate previous - Secondary Fire", HudPosition.LEFT, 7, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)    
    #Help text spectator
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and player.Mode >= 7 and player.Mode <= 9], "Standard Mode - Reload", HudPosition.LEFT, 5, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and player.Mode >= 7 and player.Mode <= 9], "Stop - Primary Fire", HudPosition.LEFT, 6, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and player.Mode >= 7 and player.Mode <= 9], "Slow Move - Secondary Fire", HudPosition.LEFT, 7, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)


rule "Start - Player":
    @Event eachPlayer
    @Condition eventPlayer.hasSpawned()
    
    #vars
    eventPlayer.Mode = 0
    eventPlayer.TimeBest = 9999
    eventPlayer.Finished = false
    eventPlayer.Checkpoint = false
    eventPlayer.Attempts = -1
    eventPlayer.SpeedColor = Color.RED
    eventPlayer.enableDeathSpectateAllPlayers()
    eventPlayer.enableDeathSpectateTargetHud()
    eventPlayer.disablePlayerCollision()
    eventPlayer.disallowButton(Button.ABILITY_2)
    eventPlayer.disallowButton(Button.ULTIMATE)
    #Effects
    createInWorldText(eventPlayer, "{0} m".format(distance(PosFinish, eventPlayer)), PosFinish + vect(0, 5, 0), 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
    if Checkpoint:
        createInWorldText(eventPlayer, "{0} m".format(distance(PosCheckpoint, eventPlayer)), PosCheckpoint + vect(0, 5, 0), 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.SKY_BLUE, SpecVisibility.DEFAULT)
    #Hud
    hudHeader(eventPlayer, eventPlayer, HudPosition.LEFT, 0, Color.YELLOW, HudReeval.NONE, SpecVisibility.DEFAULT)
    hudHeader(eventPlayer, "Best - {0} sec".format(eventPlayer.TimeBest), HudPosition.LEFT, 1, Color.WHITE, HudReeval.STRING, SpecVisibility.DEFAULT)
    hudHeader(eventPlayer, "ATTEMPTS: {0}".format(eventPlayer.Attempts), HudPosition.LEFT, 2, Color.WHITE, HudReeval.STRING, SpecVisibility.DEFAULT)
    hudHeader(eventPlayer, "{0} m/s".format(eventPlayer.getHorizontalSpeed()), HudPosition.TOP, 1, eventPlayer.SpeedColor, HudReeval.STRING_AND_COLOR, SpecVisibility.DEFAULT)
    hudHeader(eventPlayer, "{0} sec".format(eventPlayer.TimeCurrent), HudPosition.TOP, 2, Color.WHITE, HudReeval.STRING, SpecVisibility.DEFAULT)
    #Start
    async(Respawn, AsyncBehavior.NOOP)


rule "Start timer":
    @Event eachPlayer
    @Condition not eventPlayer.Mode
    @Condition not eventPlayer.Checkpoint
    @Condition not eventPlayer.Finished
    @Condition distance(PosStart, updateEveryTick(eventPlayer.getPosition())) > 2
    
    chase(eventPlayer.TimeCurrent, 5000, rate=1, ChaseReeval.NONE)
    if not Visible:
        return
    eventPlayer.setInvisibility(Invis.NONE)


rule "Checkpoint":
    @Event eachPlayer
    @Condition Checkpoint
    @Condition not eventPlayer.Finished
    @Condition not eventPlayer.Checkpoint
    @Condition not eventPlayer.Mode
    @Condition distance(PosCheckpoint, vect(eventPlayer.getPosition().x, PosCheckpoint.y, eventPlayer.getPosition().z)) <= 3.5
    @Condition eventPlayer.getPosition().y >= PosCheckpoint.y
    
    if not eventPlayer.TimeCurrent:
        smallMessage(eventPlayer, "No timer start.")
        async(Respawn, AsyncBehavior.NOOP)
        return

    eventPlayer.Checkpoint = true
    smallMessage(eventPlayer, l"{0} {1}".format(l"Finish", l"Unlocked"))
    bigMessage(eventPlayer, eventPlayer.TimeCurrent)


rule "Checkpoint (no LoS)":
    @Event eachPlayer
    @Condition Checkpoint
    @Condition not eventPlayer.Finished
    @Condition not eventPlayer.Checkpoint
    @Condition not eventPlayer.Mode
    @Condition distance(PosCheckpoint, vect(eventPlayer.getPosition().x, PosCheckpoint.y, eventPlayer.getPosition().z)) <= 3.5
    @Condition eventPlayer.getPosition().y < PosCheckpoint.y
    
    if not eventPlayer.TimeCurrent:
        smallMessage(eventPlayer, "No timer start.")
        async(Respawn, AsyncBehavior.NOOP)
        return

    smallMessage(eventPlayer, l"{0} {1}".format(l"Checkpoint", l"Out of View"))


rule "Finish":
    @Event eachPlayer
    @Condition eventPlayer.Checkpoint or not Checkpoint
    @Condition not eventPlayer.Finished
    @Condition not eventPlayer.Mode
    @Condition distance(PosFinish, vect(updateEveryTick(eventPlayer.getPosition().x), PosFinish.y, updateEveryTick(eventPlayer.getPosition().z))) <= 5
    @Condition updateEveryTick(eventPlayer.getPosition().y) >= PosFinish.y
    
    if not eventPlayer.TimeCurrent:
        smallMessage(eventPlayer, "No timer start.")
        async(Respawn, AsyncBehavior.NOOP)
        return

    stopChasingVariable(eventPlayer.TimeCurrent)
    eventPlayer.Attempts += 1
    if eventPlayer.TimeCurrent < eventPlayer.TimeBest:
        if eventPlayer.TimeCurrent < TimeThird and eventPlayer != PlayerSecond and eventPlayer != PlayerFirst:
            TimeThird = eventPlayer.TimeCurrent
            PlayerThird = eventPlayer
        if eventPlayer.TimeCurrent < TimeSecond and eventPlayer != PlayerFirst:
            if eventPlayer != PlayerSecond:
                TimeThird = TimeSecond
                PlayerThird = PlayerSecond
            TimeSecond = eventPlayer.TimeCurrent
            PlayerSecond = eventPlayer
        if eventPlayer.TimeCurrent < TimeFirst:
            if eventPlayer != PlayerFirst:
                TimeSecond = TimeFirst
                PlayerSecond = PlayerFirst
            TimeFirst = eventPlayer.TimeCurrent
            PlayerFirst = eventPlayer
        eventPlayer.TimeBest = eventPlayer.TimeCurrent
        eventPlayer.NewBest = true
    else:
        bigMessage(eventPlayer, l"{0}!!!".format(l"Finished"))
    wait()
    eventPlayer.Finished = true


rule "Finish (no LoS)":
    @Event eachPlayer
    @Condition not eventPlayer.Finished
    @Condition not eventPlayer.Mode
    @Condition distance(PosFinish, vect(eventPlayer.getPosition().x, PosFinish.y, eventPlayer.getPosition().z)) <= 5
    @Condition eventPlayer.getPosition().y < PosFinish.y
    
    if not eventPlayer.TimeCurrent:
        smallMessage(eventPlayer, "No timer start.")
        async(Respawn, AsyncBehavior.NOOP)
        return

    smallMessage(eventPlayer, l"{0} {1}".format(l"Finish", l"Out of View"))


rule "Finish (no Checkpoint)":
    @Event eachPlayer
    @Condition Checkpoint
    @Condition not eventPlayer.Checkpoint
    @Condition not eventPlayer.Finished
    @Condition not eventPlayer.Mode
    @Condition distance(PosFinish, vect(eventPlayer.getPosition().x, PosFinish.y, eventPlayer.getPosition().z)) <= 5
    
    if not eventPlayer.TimeCurrent:
        smallMessage(eventPlayer, "No timer start.")
        async(Respawn, AsyncBehavior.NOOP)
        return

    bigMessage(eventPlayer, l"{0} {1}".format(l"No", l"Checkpoint"))


rule "Finish Message (Best Time)":
    @Event eachPlayer
    @Condition eventPlayer.Finished
    @Condition eventPlayer.NewBest
    @Condition eventPlayer != PlayerFirst
    
    bigMessage(eventPlayer, l"{0} - {1}".format(l"{0} {1}".format(l"Best", l"Time"), eventPlayer.TimeBest))


rule "Finish Message (Record Time)":
    @Event eachPlayer
    @Condition eventPlayer.Finished
    @Condition eventPlayer.NewBest
    @Condition eventPlayer == PlayerFirst
    
    bigMessage(getAllPlayers(), l"{0}: {1}".format(l"New Record", l"{0} - {1}".format(l"{0} sec".format(eventPlayer.TimeBest), l"{0}!!!".format(eventPlayer))))


rule "Floor":
    @Event eachPlayer
    @Condition eventPlayer.isOnGround()
    @Condition not eventPlayer.Mode
    @Condition distance(PosStart, vect(eventPlayer.getPosition().x, PosStart.y, eventPlayer.getPosition().z)) > 4
    @Condition distance(PosFinish, vect(eventPlayer.getPosition().x, PosFinish.y, eventPlayer.getPosition().z)) > 6
    @Condition distance(PosCheckpoint, vect(eventPlayer.getPosition().x, PosCheckpoint.y, eventPlayer.getPosition().z)) > 6 or not Checkpoint
    
    async(Respawn, AsyncBehavior.NOOP)


rule "Ult Reset":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition not eventPlayer.Mode
    
    async(Respawn, AsyncBehavior.NOOP)


rule "Death":
    @Event playerDied
    @Condition eventPlayer.Mode < 4 or eventPlayer.Mode > 6
    
    eventPlayer.resurrect()
    async(Respawn, AsyncBehavior.NOOP)


rule "Velocity Counter - Standard (Green)":
    @Event eachPlayer
    @Condition not Mode
    @Condition eventPlayer.getHorizontalSpeed() > 13.75

    eventPlayer.SpeedColor = Color.GREEN
    
    
rule "Velocity Counter - Standard (Yellow)":
    @Event eachPlayer
    @Condition not Mode
    @Condition eventPlayer.getHorizontalSpeed() > 11
    @Condition eventPlayer.getHorizontalSpeed() < 13.75

    eventPlayer.SpeedColor = Color.YELLOW


rule "Velocity Counter - Standard (Orange)":
    @Event eachPlayer
    @Condition not Mode
    @Condition eventPlayer.getHorizontalSpeed() > 6.88
    @Condition eventPlayer.getHorizontalSpeed() < 11

    eventPlayer.SpeedColor = Color.ORANGE
    
    
rule "Velocity Counter - Standard (Red)":
    @Event eachPlayer
    @Condition not Mode
    @Condition eventPlayer.getHorizontalSpeed() <= 6.88
    
    eventPlayer.SpeedColor = Color.RED


rule "Velocity Counter - Gravspeed (Green)":
    @Event eachPlayer
    @Condition Mode == 1
    @Condition eventPlayer.getHorizontalSpeed() > 17.2

    eventPlayer.SpeedColor = Color.GREEN


rule "Velocity Counter - Gravspeed (Yellow)":
    @Event eachPlayer
    @Condition Mode == 1
    @Condition eventPlayer.getHorizontalSpeed() > 13.15
    @Condition eventPlayer.getHorizontalSpeed() < 17.2

    eventPlayer.SpeedColor = Color.YELLOW


rule "Velocity Counter - Gravspeed (Orange)":
    @Event eachPlayer
    @Condition Mode == 1
    @Condition eventPlayer.getHorizontalSpeed() > 8.6
    @Condition eventPlayer.getHorizontalSpeed() < 13.15

    eventPlayer.SpeedColor = Color.ORANGE


rule "Velocity Counter - Gravspeed (Red)":
    @Event eachPlayer
    @Condition Mode == 1
    @Condition eventPlayer.getHorizontalSpeed() <= 8.6
    
    eventPlayer.SpeedColor = Color.RED


rule "Toggle Invisibility (Host only)":
    @Event eachPlayer
    @Condition eventPlayer.isCommunicating(Comms.NEED_HEALING)
    @Condition eventPlayer == hostPlayer
    
    if Visible:
        smallMessage(eventPlayer, l"{0} {1}".format(l"Players", l"Invisible"))
        getAllPlayers().setInvisibility(Invis.ALL)
        Visible = false
        return
    smallMessage(eventPlayer, "{0} {1}".format(l"Players", l"Visible"))
    ([player for player in getAllPlayers() if not eventPlayer.Mode and (distance(PosStart, player.getPosition()) > 2 or not eventPlayer.isOnGround())]).setInvisibility(Invis.NONE)
    Visible = true


rule "Toggle Help":
    @Event eachPlayer
    @Condition eventPlayer.isCommunicating(Comms.ULTIMATE_STATUS)
    
    if eventPlayer.HideHelp:
        eventPlayer.HideHelp = false
        return
    eventPlayer.HideHelp = true


rule "Cycle Auto Reset":
    @Event eachPlayer
    @Condition not eventPlayer.Mode
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE)
    
    eventPlayer.AutoReset += 1
    if eventPlayer.AutoReset == 3:
        eventPlayer.AutoReset = 0
    if not eventPlayer.AutoReset:
        smallMessage(eventPlayer, "Auto Reset - Disabled")
        return
    if eventPlayer.AutoReset == 1:
        smallMessage(eventPlayer, "Auto Reset - Personal Best")
        return
    if eventPlayer.AutoReset == 2:
        smallMessage(eventPlayer, "Auto Reset - Record")


rule "Auto Reset (Personal Best)":
    @Event eachPlayer
    @Condition not eventPlayer.Mode
    @Condition eventPlayer.AutoReset == 1
    @Condition eventPlayer.TimeCurrent > eventPlayer.TimeBest
    
    smallMessage(eventPlayer, "Reset by 'Auto Reset'")
    async(Respawn, AsyncBehavior.NOOP)


rule "Auto Reset (Record)":
    @Event eachPlayer
    @Condition not eventPlayer.Mode
    @Condition eventPlayer.AutoReset == 2
    @Condition eventPlayer.TimeCurrent > TimeFirst
    
    smallMessage(eventPlayer, "Reset by 'Auto Reset'")
    async(Respawn, AsyncBehavior.NOOP)


rule "Practice Mode (Enabled)":
    @Event eachPlayer
    @Condition not eventPlayer.Mode
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)
    
    stopChasingVariable(eventPlayer.TimeCurrent)
    eventPlayer.TimeCurrent = 0
    eventPlayer.Attempts = 0
    eventPlayer.Mode = 1
    createIcon(eventPlayer, eventPlayer.PosPracticeCheckpoint, Icon.FLAG, IconReeval.POSITION, Color.GREEN, true)
    bigMessage(eventPlayer, "Entering Practice Mode")
    eventPlayer.setInvisibility(Invis.ALL)


rule "Practice Mode (Button Held - Enabled)":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 1
    @Condition not eventPlayer.isHoldingButton(Button.INTERACT)
    
    eventPlayer.Mode = 2


rule "Fire status (Enabled)":
    @Event eachPlayer
    @Condition eventPlayer.Mode >= 1
    @Condition eventPlayer.Mode <= 3
    
    eventPlayer.setStatusEffect(null, Status.BURNING, 9999)
    eventPlayer.setStatusEffect(null, Status.INVINCIBLE, 9999)


rule "Practice Mode (disabled)":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 2
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)
    
    eventPlayer.Mode = 3


rule "Practice Mode (Button Held - disabled)":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 3
    @Condition not eventPlayer.isHoldingButton(Button.INTERACT)
    
    destroyIcon(getLastCreatedEntity())
    eventPlayer.PosPracticeCheckpoint = 0
    bigMessage(eventPlayer, "Leaving Practice Mode")
    async(Respawn, AsyncBehavior.NOOP)


rule "Fire status (Disabled)":
    @Event eachPlayer
    @Condition eventPlayer.Mode < 1 or eventPlayer.Mode > 3
    
    eventPlayer.clearStatusEffect(Status.BURNING)
    eventPlayer.clearStatusEffect(Status.INVINCIBLE)


rule "Practice Checkpoints":
    @Event eachPlayer
    
    @Condition eventPlayer.Mode == 2
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE)
    
    eventPlayer.PosPracticeCheckpoint = eventPlayer.getPosition()
    eventPlayer.FacingPracticeCheckpoint = eventPlayer.getFacingDirection()
    eventPlayer.VelocityPracticeCheckpoint = eventPlayer.getVelocity()
    eventPlayer.SpeedPracticeCheckpoint = eventPlayer.getSpeed()
    smallMessage(eventPlayer, l"{0} {1}".format(l"Checkpoint", l"Saved"))


rule "Ult Reset Checkpoint":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 2
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    
    async(Respawn, AsyncBehavior.NOOP)


rule "Player Spectator Mode enabled":
    @Event eachPlayer
    @Condition not eventPlayer.Mode
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2)
    
    eventPlayer.Mode = 4
    stopChasingVariable(eventPlayer.TimeCurrent)
    eventPlayer.TimeCurrent = 0
    eventPlayer.setRespawnTime(9999)
    bigMessage(eventPlayer, "Entering Player Spectator Mode")
    wait(0.1)
    kill(eventPlayer, null)


rule "Player Spectator Mode enabled (Button Held)":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 4
    @Condition not eventPlayer.isHoldingButton(Button.ABILITY_2)
    
    eventPlayer.Mode = 5


rule "Player Spectator Mode disabled":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 5
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2)
    
    eventPlayer.Mode = 6


rule "Player Specator Mode disabled (Button Held)":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 6
    @Condition not eventPlayer.isHoldingButton(Button.ABILITY_2)
    
    eventPlayer.resurrect()
    async(Respawn, AsyncBehavior.NOOP)
    bigMessage(eventPlayer, "Leaving Player Spectator Mode")


rule "Spectator Mode enable":
    @Event eachPlayer
    @Condition not eventPlayer.Mode
    @Condition eventPlayer.isHoldingButton(Button.RELOAD)
    
    eventPlayer.Mode = 7
    eventPlayer.setGravity(0)
    if not Mode:
        eventPlayer.setMoveSpeed(225)
    if Mode == 1:
        eventPlayer.setMoveSpeed(275)
    eventPlayer.setInvisibility(Invis.ALL)
    stopChasingVariable(eventPlayer.TimeCurrent)
    eventPlayer.TimeCurrent = 0
    eventPlayer.Attempts = 0
    bigMessage(eventPlayer, "Entering Spectator Mode")


rule "Spectator Mode enable (Button Held)":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 7
    @Condition not eventPlayer.isHoldingButton(Button.RELOAD)
    
    eventPlayer.Mode = 8


rule "Spectator Mode disabled":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 8
    @Condition eventPlayer.isHoldingButton(Button.RELOAD)
    
    eventPlayer.Mode = 9


rule "Spectator Mode disabled (Button Held)":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 9
    @Condition not eventPlayer.isHoldingButton(Button.RELOAD)
    
    bigMessage(eventPlayer, "Leaving Spectator Mode")
    async(Respawn, AsyncBehavior.NOOP)


rule "Spectator Mode (move up enabled)":
    @Event eachPlayer
    @Condition eventPlayer.Mode >= 7
    @Condition eventPlayer.Mode <= 9
    @Condition eventPlayer.isHoldingButton(Button.JUMP)
    
    eventPlayer.applyImpulse(Vector.UP, 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)


rule "Spectator Mode (move up disabled)":
    @Event eachPlayer
    @Condition eventPlayer.Mode >= 7
    @Condition eventPlayer.Mode <= 9
    @Condition not eventPlayer.isHoldingButton(Button.JUMP)
    
    eventPlayer.applyImpulse(Vector.DOWN, 0.001, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.applyImpulse(Vector.UP, 0.001, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)


rule "Spectator Mode (move down enabled)":
    @Event eachPlayer
    @Condition eventPlayer.Mode >= 7
    @Condition eventPlayer.Mode <= 9
    @Condition eventPlayer.isHoldingButton(Button.CROUCH)
    
    eventPlayer.applyImpulse(Vector.DOWN, 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)


rule "Spectator Mode (move down disabled)":
    @Event eachPlayer
    @Condition eventPlayer.Mode >= 7
    @Condition eventPlayer.Mode <= 9
    @Condition not eventPlayer.isHoldingButton(Button.CROUCH)
    
    eventPlayer.applyImpulse(Vector.UP, 0.001, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.applyImpulse(Vector.DOWN, 0.001, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)


rule "Spectator Mode (stop movement)":
    @Event eachPlayer
    @Condition eventPlayer.Mode >= 7
    @Condition eventPlayer.Mode <= 9
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE)
    
    eventPlayer.applyImpulse(eventPlayer.getVelocity() * -0.001, 0.001, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.applyImpulse(eventPlayer.getVelocity() * 0.001, 0.001, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)


rule "Spectator Mode (slow movement enabled)":
    @Event eachPlayer
    @Condition eventPlayer.Mode >= 7
    @Condition eventPlayer.Mode <= 9
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE)
    
    eventPlayer.Speed = eventPlayer.getHorizontalSpeed()
    eventPlayer.startForcingThrottle(0, 0.5, 0, 0.5, 0, 0.5)
    eventPlayer.applyImpulse(eventPlayer.getVelocity() * -0.001, 1, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.applyImpulse(eventPlayer.getVelocity(), eventPlayer.Speed * 0.5, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)


rule "Spectator Mode (slow movement disabled)":
    @Event eachPlayer
    @Condition eventPlayer.Mode >= 7
    @Condition eventPlayer.Mode <= 9
    @Condition not eventPlayer.isHoldingButton(Button.SECONDARY_FIRE)
    
    eventPlayer.stopForcingThrottle()


rule "Circle Fix":
    @Event eachPlayer
    @Condition distance(PosStart, updateEveryTick(eventPlayer.getPosition())) <= 2
    @Condition not eventPlayer.Reset
    @Condition eventPlayer.Mode <= 2
    @Condition not eventPlayer.PosPracticeCheckpoint
    @Condition not eventPlayer.Checkpoint
    @Condition not eventPlayer.Finished
    @Condition (not Mode and eventPlayer.getHorizontalSpeed() <= 6.88) or (Mode == 1 and eventPlayer.getHorizontalSpeed() <= 8.6)
    
    stopChasingVariable(eventPlayer.TimeCurrent)
    eventPlayer.TimeCurrent = 0
    eventPlayer.setInvisibility(Invis.ALL)
    wait(0.05)
    eventPlayer.allowButton(Button.JUMP)


rule "Match Time Frozen":
    @Condition isGameInProgress()
    @Condition Infinite
    
    wait()
    while true:
        wait(getMatchTime() - 10)
        setMatchTime(Time)


def Respawn():
    @Name "Respawn"
    
    if eventPlayer.Mode <= 2:
        if eventPlayer.PosPracticeCheckpoint:
            eventPlayer.Attempts += 1
            eventPlayer.teleport(eventPlayer.PosPracticeCheckpoint)
            eventPlayer.setFacing(eventPlayer.FacingPracticeCheckpoint, Relativity.TO_WORLD)
            eventPlayer.applyImpulse(eventPlayer.getVelocity() * -0.001, 0.001, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
            eventPlayer.applyImpulse(eventPlayer.VelocityPracticeCheckpoint, eventPlayer.SpeedPracticeCheckpoint, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
            return
        eventPlayer.Reset = true
        wait()
        eventPlayer.Reset = false
        if not eventPlayer.Finished:
            eventPlayer.Attempts += 1
        if eventPlayer.NewBest:
            eventPlayer.NewBest = false
            eventPlayer.Attempts = 0
    eventPlayer.disallowButton(Button.JUMP)
    eventPlayer.teleport(PosStart)
    eventPlayer.applyImpulse(eventPlayer.getVelocity() * -0.001, 0.001, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.applyImpulse(eventPlayer.getVelocity() * 0.001, 0.001, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
    eventPlayer.setStatusEffect(null, Status.ROOTED, 0.5)
    waitUntil(eventPlayer.getPosition() == PosStart, 0.5)
    eventPlayer.Finished = false
    eventPlayer.Checkpoint = false
    if eventPlayer.Mode > 2:
        eventPlayer.Attempts = 0
        eventPlayer.Mode = 0
        if not Mode:
            eventPlayer.setGravity(100)
            eventPlayer.setMoveSpeed(100)
        elif Mode == 1:
            eventPlayer.setGravity(80)
            eventPlayer.setMoveSpeed(125)

