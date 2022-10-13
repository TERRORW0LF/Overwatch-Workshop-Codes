settings "settings.opy.json"

#Global variables

globalvar TimeFirstGrav 0
globalvar TimeFirstStan 1
globalvar TimeSecondGrav 2
globalvar TimeSecondStan 3
globalvar TimeThirdGrav 4
globalvar TimeThirdStan 5
globalvar PlayerFirstGrav 6
globalvar PlayerFirstStan 7
globalvar PlayerSecondGrav 8
globalvar PlayerSecondStan 9
globalvar PlayerThirdGrav 10
globalvar PlayerThirdStan 11
globalvar Checkpoint 12
globalvar Visible 13
globalvar Season 14
globalvar Category 15
globalvar Time 16
globalvar Infinite 17
globalvar Loop1 19
globalvar PosStart 20
globalvar PosCheckpoint 21
globalvar PosFinish 22
globalvar PosBarrier 23


#Player variables

playervar TimeCurrent 0
playervar TimeBestGrav 1
playervar TimeBestStan 2
playervar NewBest 3
playervar Checkpoint 4
playervar Finished 5
playervar Category 6
playervar AutoReset 7
playervar HideHelp 8
playervar Mode 9
playervar Attempts 10
playervar SpeedColor 11
playervar ExecutingMenu 12
playervar Speed 13
playervar CurrCheckpoint 14
playervar CheckpointLoop 15
playervar Reset 16
playervar PracticeCheckpoint 22
playervar PosPracticeCheckpoint 23
playervar FacingPracticeCheckpoint 24
playervar VelocityPracticeCheckpoint 25
playervar SpeedPracticeCheckpoint 26


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
    Season = createWorkshopSetting(enum["Season 1", "Season 2", "Season 3", "Season 4", "Season 5"], "Combo", "Season", 0, 0)
    Category = createWorkshopSetting(enum["Standard", "Gravspeed"], "Combo", "Default Category", 1, 1)
    Time = createWorkshopSetting(int[60:3600], "Time", "Seconds", 600, 0)
    Infinite = createWorkshopSetting(bool, "Time", "Infinite", false, 1)


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
    #FFA
    if getCurrentMap() == Map.CHATEAU_GUILLARD:
        PosStart = vect(176.515, 0, 52.458)
        PosFinish = vect(233.220, 3.9, 110.969)
        return
    if getCurrentMap() == Map.KANEZAKA:
        PosStart = vect(-14.495, 6, 42.699)
        PosFinish = vect(-39.953, 7.9, -54.264)
        return
    if getCurrentMap() == Map.MALEVENTO:
        PosStart = vect(0, 0, 0)
        PosFinish = vect(0, 0, 0)
        return
    if getCurrentMap() == Map.PETRA:
        PosStart = vect(0, 0, 0)
        PosFinish = vect(0, 0, 0)
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
    if getCurrentMap() == Map.ILIOS_LIGHTHOUSE:
        PosStart = vect(329, -25.6, 22)
        PosFinish = vect(290, -25.74, -89)
        return
    if getCurrentMap() == Map.ILIOS_RUINS:
        PosStart = vect(112, 65.39, -178)
        PosFinish = vect(-58.5, 60.3, -150)
        return
    if getCurrentMap() == Map.ILIOS_WELL:
        PosStart = vect(-159, -5.06, -75.5)
        PosFinish = vect(-264.5, -5.2, 29.5)
        return
    if getCurrentMap() == Map.LIJIANG_CONTROL_CENTER:
        PosStart = vect(44, 265, 327)
        PosFinish = vect(-35.5, 266.9, 316.75)
        return
    if getCurrentMap() == Map.LIJIANG_GARDEN:
        PosStart = vect(64.5, 94, 145.5)
        PosFinish = vect(-61, 93.9, 148)
        return
    if getCurrentMap() == Map.LIJIANG_NIGHT_MARKET:
        PosStart = vect(61, 2, -34)
        PosFinish = vect(-54.25, 5.9, -11.75)
        return
    if getCurrentMap() == Map.NEPAL_SANCTUM:
        PosStart = vect(81, 131.8, 36)
        PosFinish = vect(81, 131.7, -35.5)
        return
    if getCurrentMap() == Map.NEPAL_SHRINE:
        PosStart = vect(-38.5, 14.88, 60)
        PosFinish = vect(-49, 14.9, -74)
        return
    if getCurrentMap() == Map.NEPAL_VILLAGE:
        PosStart = vect(-191, -98.23, 60)
        PosFinish = vect(-176.5, -99.5, -71)
        return
    if getCurrentMap() == Map.OASIS_CITY_CENTER:
        PosStart = vect(101, 1, 309.5)
        PosFinish = vect(195, 0.75, 200)
        return
    if getCurrentMap() == Map.OASIS_GARDENS:
        PosStart = vect(182, 8, -223.5)
        PosFinish = vect(103, 7.9, -285.5)
        return
    if getCurrentMap() == Map.OASIS_UNIVERSITY:
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
    #FFA
    if getCurrentMap() == Map.CHATEAU_GUILLARD:
        PosStart = vect(0, 0, 0)
        PosFinish = vect(0, 0, 0)
        return
    if getCurrentMap() == Map.KANEZAKA:
        PosStart = vect(0, 0, 0)
        PosFinish = vect(0, 0, 0)
        return
    if getCurrentMap() == Map.MALEVENTO:
        PosStart = vect(0, 0, 0)
        PosFinish = vect(0, 0, 0)
        return
    if getCurrentMap() == Map.PETRA:
        PosStart = vect(0, 0, 0)
        PosFinish = vect(0, 0, 0)
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
    #Ilios
    if getCurrentMap() == Map.ILIOS_LIGHTHOUSE:
        PosStart = vect(288.533, -25.57, -100.389)
        PosFinish = vect(329, -25.7, 22)
        return
    if getCurrentMap() == Map.ILIOS_RUINS:
        PosStart = vect(-58.5, 60.58, -150)
        PosFinish = vect(112, 60.3, -178)
        return
    if getCurrentMap() == Map.ILIOS_WELL:
        PosStart = vect(-264.5, -5.1, 29.5)
        PosFinish = vect(-159, -5.2, -75.5)
        return
    #Lijiang
    if getCurrentMap() == Map.LIJIANG_CONTROL_CENTER:
        PosStart = vect(-35.5, 267, 316.75)
        PosFinish = vect(44, 264.9, 327)
        return
    if getCurrentMap() == Map.LIJIANG_GARDEN:
        PosStart = vect(-65.211, 94, 145.476)
        PosFinish = vect(64.5, 93.9, 145.5)
        return
    if getCurrentMap() == Map.LIJIANG_NIGHT_MARKET:
        PosStart = vect(-56.087, 1.86, -35.084)
        PosFinish = vect(61, 1.8, -34)
        return
    #Nepal
    if getCurrentMap() == Map.NEPAL_SANCTUM:
        PosStart = vect(81, 131.8, -35.5)
        PosFinish = vect(81, 131.7, 36)
        return
    if getCurrentMap() == Map.NEPAL_SHRINE:
        PosStart = vect(-70.647, 15.7, -64.165)
        PosFinish = vect(-38.5, 13.6, 60)
        return
    if getCurrentMap() == Map.NEPAL_VILLAGE:
        PosStart = vect(-184.744, -96.5, -75.548)
        PosFinish = vect(-191, -98.7, 60)
        return
    #Oasis
    if getCurrentMap() == Map.OASIS_CITY_CENTER:
        PosStart = vect(211.712, 1, 203.561)
        PosFinish = vect(101, 0.75, 309.5)
        return
    if getCurrentMap() == Map.OASIS_GARDENS:
        PosStart = vect(101.075, 8, -271.365)
        PosFinish = vect(182, 7.4, -223.5)
        return
    if getCurrentMap() == Map.OASIS_UNIVERSITY:
        PosStart = vect(-187.904, 19.77, -69.197)
        PosFinish = vect(-188, 16.9, 50.5)


rule "Start - Maps (Season 3)":
    @Condition Season == 2
    
    Checkpoint = true
    #Assault
    if getCurrentMap() == Map.HANAMURA:
        PosStart = vect(55.024, -1.92, 41.766)
        PosCheckpoint = [vect(76.329, -3.55, 97.421)]
        PosFinish = vect(91.752, -2.1, 17.33)
        return
    if getCurrentMap() == Map.HORIZON_LUNAR_COLONY:
        PosStart = vect(20.101, 6, -107.386)
        PosCheckpoint = [vect(94.12, 10.4, -56.787)]
        PosFinish = vect(47.863, 5.9, -37.389)
        return
    if getCurrentMap() == Map.PARIS:
        PosStart = vect(-77.279, 12.07, -2.75)
        PosCheckpoint = [vect(-43.506, 11, -34.903)]
        PosFinish = vect(-119.113, 9.9, -69.934)
        return
    if getCurrentMap() == Map.TEMPLE_OF_ANUBIS:
        PosStart = vect(-59.379, 6.5, 44.914)
        PosCheckpoint = [vect(16.802, 2.3, 106.979)]
        PosFinish = vect(-36.8, 9, 2.543)
        return
    if getCurrentMap() == Map.VOLSKAYA:
        PosStart = vect(-32.824, -2.94, 48.356)
        PosCheckpoint = [vect(16.248, -5.1, 25.782)]
        PosFinish = vect(2.417, -8, 107.37)
        return
    #Escort
    if getCurrentMap() == Map.DORADO:
        PosStart = vect(167.15, 18.01, 68)
        PosCheckpoint = [vect(68, 16.9, 40)]
        PosFinish = vect(125, 6.9, -18)
        return
    if getCurrentMap() == Map.HAVANA:
        PosStart = vect(101.15, 2.17, -82.72)
        PosCheckpoint = [vect(6, 5.7, -75)]
        PosFinish = vect(42.47, 5.9, -47)
        return
    if getCurrentMap() == Map.JUNKERTOWN:
        PosStart = vect(32.55, 15.2, -89.45)
        PosCheckpoint = [vect(-18, 6.4, -90)]
        PosFinish = vect(-46.5, 9.4, -47.5)
        return
    if getCurrentMap() == Map.RIALTO:
        PosStart = vect(110.31, -0.25, -34.22)
        PosCheckpoint = [vect(33, 0.55, -36.59)]
        PosFinish = vect(-15, 5.65, -55)
        return
    if getCurrentMap() == Map.ROUTE66:
        PosStart = vect(37.82, 2.01, 16.71)
        PosCheckpoint = [vect(16, 7.8, -23)]
        PosFinish = vect(51, 0.1, 45)
        return
    if getCurrentMap() == Map.WATCHPOINT_GIBRALTAR:
        PosStart = vect(5.42, -5, -81.88)
        PosCheckpoint = [vect(89, 2.9, -27)]
        PosFinish = vect(97.362, -6, 38.946)
        return
    #FFA
    if getCurrentMap() == Map.CHATEAU_GUILLARD:
        PosStart = vect(0, 0, 0)
        PosCheckpoint = [vect(0, 0, 0)]
        PosFinish = vect(0, 0, 0)
        return
    if getCurrentMap() == Map.KANEZAKA:
        PosStart = vect(0, 0, 0)
        PosCheckpoint = [vect(0, 0, 0)]
        PosFinish = vect(0, 0, 0)
        return
    if getCurrentMap() == Map.MALEVENTO:
        PosStart = vect(0, 0, 0)
        PosCheckpoint = [vect(0, 0, 0)]
        PosFinish = vect(0, 0, 0)
        return
    if getCurrentMap() == Map.PETRA:
        PosStart = vect(0, 0, 0)
        PosCheckpoint = [vect(0, 0, 0)]
        PosFinish = vect(0, 0, 0)
        return
    #Hybrid
    if getCurrentMap() == Map.BLIZZ_WORLD:
        PosStart = vect(23.31, 2, 79.2)
        PosCheckpoint = [vect(-72.57, 6.5, 105.2)]
        PosFinish = vect(-8, -1.1, 103.66)
        return
    if getCurrentMap() == Map.EICHENWALDE:
        PosStart = vect(54.97, 22.68, -104.11)
        PosCheckpoint = [vect(4.93, 4.9, -14.1)]
        PosFinish = vect(64.74, 15.5, -61.86)
        return
    if getCurrentMap() == Map.HOLLYWOOD:
        PosStart = vect(-29.04, 13.86, -12.75)
        PosCheckpoint = [vect(19.77, 4.8, 59.12)]
        PosFinish = vect(-42.39, -0.25, 54.98)
        return
    if getCurrentMap() == Map.KINGS_ROW:
        PosStart = vect(14.73, 6, 18.19)
        PosCheckpoint = [vect(-60, -0.2, -47.5)]
        PosFinish = vect(-98.35, 0.6, -6.78)
        return
    if getCurrentMap() == Map.NUMBANI:
        PosStart = vect(88.38, 4.25, -24.17)
        PosCheckpoint = [vect(129.52, -3.85, 38.61)]
        PosFinish = vect(204.25, -2.25, 22.61)
        return
    #Control
    if getCurrentMap() == Map.BUSAN:
        #Downtown
        if getCurrentObjective() == 0:
            PosStart = vect(51.9, 21.4, -129)
            PosCheckpoint = [vect(51.9, 4.78, -74)]
            PosFinish = vect(51.9, 10.9, -147.9)
            return
        #MEKA Base
        if getCurrentObjective() == 2:
            PosStart = vect(210, 9.1, 212)
            PosCheckpoint = [vect(205.5, 9, 202)]
            PosFinish = vect(226, 9, 250)
            return
        #Sanctuary
        if getCurrentObjective() == 1:
            PosStart = vect(-328.5, 8, 180.5)
            PosCheckpoint = [vect(-328.5, 9.72, 107.4)]
            PosFinish = vect(-328.5, 9, 195)
            return
    #Ilios
    if getCurrentMap() == Map.ILIOS_LIGHTHOUSE:
        PosStart = vect(318, -23.66, -35)
        PosCheckpoint = [vect(365, -25.73, -54.5)]
        PosFinish = vect(307.8, -11.1, 31.4)
        return
    if getCurrentMap() == Map.ILIOS_RUINS:
        PosStart = vect(28.5, 57.37, -141.5)
        PosCheckpoint = [vect(-55, 65, -178)]
        PosFinish = vect(11.9, 66.2, -144.2)
        return
    if getCurrentMap() == Map.ILIOS_WELL:
        PosStart = vect(-195, 1, -3)
        PosCheckpoint = [vect(-284, -0.55, 10)]
        PosFinish = vect(-271.9, 1.2, 53.5)
        return
    #Lijiang
    if getCurrentMap() == Map.LIJIANG_CONTROL_CENTER:
        PosStart = vect(0, 278, 293)
        PosCheckpoint = [vect(0, 274, 330)]
        PosFinish = vect(0, 269.9, 254)
        return
    if getCurrentMap() == Map.LIJIANG_GARDEN:
        PosStart = vect(-65, 94, 145)
        PosCheckpoint = [vect(0, 94.9, 125)]
        PosFinish = vect(52, 90, 182)
        return
    if getCurrentMap() == Map.LIJIANG_NIGHT_MARKET:
        PosStart = vect(1, -2, -82)
        PosCheckpoint = [vect(49, 1.76, -47)]
        PosFinish = vect(1, -0.1, -10)
        return
    #Nepal
    if getCurrentMap() == Map.NEPAL_SANCTUM:
        PosStart = vect(78, 129.8, -59)
        PosCheckpoint = [vect(81, 127.9, 8)]
        PosFinish = vect(102, 131.9, 78)
        return
    if getCurrentMap() == Map.NEPAL_SHRINE:
        PosStart = vect(-26, 10.62, -34)
        PosCheckpoint = [vect(-63, 12.9, 0)]
        PosFinish = vect(-24, 14.9, 82)
        return
    if getCurrentMap() == Map.NEPAL_VILLAGE:
        PosStart = vect(-158, -88.94, 0)
        PosCheckpoint = [vect(-220, -94.1, 0)]
        PosFinish = vect(-207, -87.1, -44)
        return
    #Oasis
    if getCurrentMap() == Map.OASIS_CITY_CENTER:
        PosStart = vect(166, 4, 270)
        PosCheckpoint = [vect(102, -2, 288)]
        PosFinish = vect(119, 0.5, 223)
        return
    if getCurrentMap() == Map.OASIS_GARDENS:
        PosStart = vect(172.66, 8.4, -166)
        PosCheckpoint = [vect(141.33, 7.3, -247.33)]
        PosFinish = vect(101.5, -1, -207.5)
        return
    if getCurrentMap() == Map.OASIS_UNIVERSITY:
        PosStart = vect(-198, 9, 0)
        PosCheckpoint = [vect(-220, 18.9, 0)]
        PosFinish = vect(-175, 15.9, 61.5)


rule "Start - Maps (Season 4)":
    @Condition Season == 3
    
    #Assault
    if getCurrentMap() == Map.HANAMURA:
        PosStart = vect(85.867, -2.02, 16.524)
        PosCheckpoint = [vect(64.123, -3.4, 84.188)]
        PosFinish = vect(30.542, 1.9, 40.845)
        Checkpoint = true
        return
    if getCurrentMap() == Map.HORIZON_LUNAR_COLONY:
        PosStart = vect(-38.253, 10, -122.811)
        PosCheckpoint = [vect(43.183, 13.9, -77.129)]
        PosFinish = vect(25.671, 6.9, -15.62)
        Checkpoint = true
        return
    if getCurrentMap() == Map.PARIS:
        PosStart = vect(-119.964, 9.86, -51.908)
        PosCheckpoint = [vect(-44.044, 11, -33.258)]
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
        PosCheckpoint = [vect(-37.356, 1.9, 98.043)]
        PosFinish = vect(-30.133, 1.9, 38.232)
        Checkpoint = true
        return
    #Escort
    if getCurrentMap() == Map.DORADO:
        PosStart = vect(62.246, 13.42, 21.758)
        PosCheckpoint = [vect(117.076, 17.9, 5.438)]
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
        PosCheckpoint = [vect(-46.378, 17.6, -90.257)]
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
        PosCheckpoint = [vect(-42.605, 3.3, 5.206)]
        PosFinish = vect(-100.763, 8.4, 8.128)
        Checkpoint = true
        return
    if getCurrentMap() == Map.WATCHPOINT_GIBRALTAR:
        PosStart = vect(83.581, 3.04, -31.786)
        PosCheckpoint = [vect(66.186, -2.1, -114.804)]
        PosFinish = vect(22.688, -6.1, -159.187)
        Checkpoint = true
        return
    #FFA
    if getCurrentMap() == Map.CHATEAU_GUILLARD:
        PosStart = vect(0, 0, 0)
        PosCheckpoint = [vect(0, 0, 0)]
        PosFinish = vect(0, 0, 0)
        Checkpoint = true
        return
    if getCurrentMap() == Map.KANEZAKA:
        PosStart = vect(0, 0, 0)
        PosCheckpoint = [vect(0, 0, 0)]
        PosFinish = vect(0, 0, 0)
        Checkpoint = true
        return
    if getCurrentMap() == Map.MALEVENTO:
        PosStart = vect(0, 0, 0)
        PosCheckpoint = [vect(0, 0, 0)]
        PosFinish = vect(0, 0, 0)
        Checkpoint = true
        return
    if getCurrentMap() == Map.PETRA:
        PosStart = vect(0, 0, 0)
        PosCheckpoint = [vect(0, 0, 0)]
        PosFinish = vect(0, 0, 0)
        Checkpoint = true
        return
    #Hybrid
    if getCurrentMap() == Map.BLIZZ_WORLD:
        PosStart = vect(52.118, -0.81, -7.795)
        PosCheckpoint = [vect(53.816, -6.5, -87.717)]
        PosFinish = vect(-57.568, -3.9, -5.401)
        Checkpoint = true
        return
    if getCurrentMap() == Map.EICHENWALDE:
        PosStart = vect(2.656, 6, 0.346)
        PosCheckpoint = [vect(31.753, 13.5, -79.386)]
        PosFinish = vect(83.903, 12.6, -87.977)
        Checkpoint = true
        return
    if getCurrentMap() == Map.HOLLYWOOD:
        PosStart = vect(-25.875, 1.75, 21.201)
        PosCheckpoint = [vect(12.661, 1.6, -86.28)]
        PosFinish = vect(-38.232, 8.62, -116.867)
        Checkpoint = true
        return
    if getCurrentMap() == Map.KINGS_ROW:
        PosStart = vect(4.83, 6, -1.205)
        PosCheckpoint = [vect(-83.851, 0, 4.438)]
        PosFinish = vect(-118.429, -1.4, 24.984)
        Checkpoint = true
        return
    if getCurrentMap() == Map.NUMBANI:
        PosStart = vect(144.571, 2.25, 29.313)
        PosCheckpoint = [vect(49.435, 1.6, -6.419)]
        PosFinish = vect(163.628, 4.15, -0.052)
        Checkpoint = true
        return
    #Control
    if getCurrentMap() == Map.BUSAN:
        #Downtown
        if not getCurrentObjective():
            PosStart = vect(84.198, 15, -142.989)
            PosCheckpoint = [vect(22.583, 7.9, -81.736)]
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
            PosCheckpoint = [vect(-382.463, 9, 138.889)]
            PosFinish = vect(-271.677, 9, 137.999)
            Checkpoint = true
            return
    #Ilios
    if getCurrentMap() == Map.ILIOS_LIGHTHOUSE:
        PosStart = vect(284.738, -17.94, -75.819)
        PosCheckpoint = [vect(363.517, -18.4, -53.426)]
        PosFinish = vect(336.947, -25.7, 22.725)
        Checkpoint = true   
        return
    if getCurrentMap() == Map.ILIOS_RUINS:
        PosStart = vect(111.647, 65.39, -177.77)
        PosCheckpoint = [vect(28.446, 61.39, -143.87)]
        PosFinish = vect(-55.178, 65.3, -178.229)
        Checkpoint = true
        return
    if getCurrentMap() == Map.ILIOS_WELL:
        PosStart = vect(-258.986, -0.5, 48.481)
        PosCheckpoint = [vect(-224.969, 5.3, -33.21)]
        PosFinish = vect(-141.105, 10.5, -87.497)
        Checkpoint = true
    #Lijiang
    if getCurrentMap() == Map.LIJIANG_CONTROL_CENTER:
        PosStart = vect(-26.497, 270, 340.286)
        PosCheckpoint = [vect(10.656, 269.9, 261.943)]
        PosFinish = vect(27.763, 269.9, 355.578)
        Checkpoint = true
        return
    if getCurrentMap() == Map.LIJIANG_GARDEN:
        PosStart = vect(61.321, 98, 161.408)
        PosCheckpoint = [vect(-0.067, 95.9, 107.872)]
        PosFinish = vect(-68.698, 97.9, 163.209)
        Checkpoint = true
        return
    if getCurrentMap() == Map.LIJIANG_NIGHT_MARKET:
        PosStart = vect(61.03, 6, -10.232)
        PosCheckpoint = [vect(1.479, -1.1, -59.482)]
        PosFinish = vect(-58.911, 5.9, -10.302)
        Checkpoint = true
        return
    #Nepal
    if getCurrentMap() == Map.NEPAL_SANCTUM:
        PosStart = vect(107.495, 133.1, -73.174)
        PosCheckpoint = [vect(55.295, 129.7, 0.52)]
        PosFinish = vect(102.618, 135.9, 78.165)
        Checkpoint = true
        return
    if getCurrentMap() == Map.NEPAL_SHRINE:
        PosStart = vect(-22.294, 22, 76.936)
        PosFinish = vect(-50.994, 14.9, -77.311)
        Checkpoint = false
        return
    if getCurrentMap() == Map.NEPAL_VILLAGE:
        PosStart = vect(-168.653, -97.53, -48.431)
        PosCheckpoint = [vect(-221.123, -89.5, 0.323)]
        PosFinish = vect(-147.782, -92.5, 62.105)
        Checkpoint = true
        return
    #Oasis
    if getCurrentMap() == Map.OASIS_CITY_CENTER:
        PosStart = vect(84.599, 1, 298.498)
        PosCheckpoint = [vect(157.26, 3.9, 264.225)]
        PosFinish = vect(157.23, 0.8, 205.119)
        Checkpoint = true
        return
    if getCurrentMap() == Map.OASIS_GARDENS:
        PosStart = vect(73.282, 7.5, -285.746)
        PosFinish = vect(155.223, 9.9, -186.502)
        Checkpoint = false
        return
    if getCurrentMap() == Map.OASIS_UNIVERSITY:
        PosStart = vect(-208.867, 20.33, -71.688)
        PosCheckpoint = [vect(-172.403, 16.9, 2.078)]
        PosFinish = vect(-188.53, 17.9, 60.728)
        Checkpoint = true
            
            
rule "Start - Maps (Season 5)":
    @Condition Season == 4
    
    Checkpoint = true
    #Assault
    if getCurrentMap() == Map.HANAMURA:
        PosStart = vect(11.329, 0, -24.036)
        PosCheckpoint = [vect(66.147, -2, -3.121), vect(-23.977, -0.95, -72.131)]
        PosFinish = vect(12.963, 6.7, -23.213)
        return
    if getCurrentMap() == Map.HORIZON_LUNAR_COLONY:
        PosStart = vect(57.716, 8.77, -97.643)
        PosCheckpoint = [vect(-32.413, 4.4, -135.156), vect(24.286, 6.9, -20.328), vect(94.019, 11, -57.378)]
        PosFinish = vect(43.878, 13.5, -77.993)
        return
    if getCurrentMap() == Map.PARIS:
        PosStart = vect(-27.132, 13, 6.412)
        PosCheckpoint = [vect(7.458, 9.9, -58.2), vect(-53.175, 12, 12.32), vect(-73.074, 14.9, -86.629), vect(-118.024, 12.9, -92.921), vect(-83.325, 11.7, -58.477)]
        PosFinish = vect(-58.73, 11, -13.232)
        return
    if getCurrentMap() == Map.TEMPLE_OF_ANUBIS:
        PosStart = vect(-31.404, 1.3, 27.937)
        PosCheckpoint = [vect(12.334, -2.6, -1.291), vect(15.76, 0.4, 98.839), vect(-20.635, 2.5, 104.372), vect(-8.628, -2.5, -15.143)]
        PosFinish = vect(-21.014, 4.5, 35.175)
        return
    if getCurrentMap() == Map.VOLSKAYA:
        PosStart = vect(-38.235, -2.51, 54.73)
        PosCheckpoint = [vect(-98.926, -2.5, 23.314), vect(-104.674, -4, 68.186), vect(23.227, -4.1, 100.796), vect(-23.84, -5, 38.582)]
        PosFinish = vect(-56.662, -4.2, 71.855)
        return
    #Escort
    if getCurrentMap() == Map.DORADO:
        PosStart = vect(84.979, 20, 17.035)
        PosCheckpoint = [vect(136.754, 10.9, 45.919), vect(35.461, 9.7, -33.067), vect(8.526, -2, 22.064), vect(193.551, 14, 43.411)]
        PosFinish = vect(98.023, 17.9, 5.085)
        return
    if getCurrentMap() == Map.HAVANA:
        PosStart = vect(25.471, 6, -70.081)
        PosCheckpoint = [vect(138.605, 4.8, -25.422), vect(107.194, 1.2, -26.704), vect(-30.023, 9.9, -98.164), vect(-84.714, 3.8, -55.305)]
        PosFinish = vect(27.096, 9.9, -78.649)
        return
    if getCurrentMap() == Map.JUNKERTOWN:
        PosStart = vect(-43.021, 12.48, -61.452)
        PosCheckpoint = [vect(4.734, 6.4, -52.832), vect(37.373, 8.8, -74.34), vect(-84.607, 13.4, -159.448), vect(-49.728, 7.3, -118.016)]
        PosFinish = vect(-36.35, 4.2, -68.046)
        return
    if getCurrentMap() == Map.RIALTO:
        PosStart = vect(46.435, 0.65, -36.57)
        PosCheckpoint = [vect(85.068, -0.5, -49.805), vect(107.15, -1.3, -1.272), vect(-25.075, -1.8, -60.92), vect(-57.09, 4.7, -145.623)]
        PosFinish = vect(37.136, -0.3, -55.023)
        return
    if getCurrentMap() == Map.ROUTE66:
        PosStart = vect(-10.146, 8.13, -8.694)
        PosCheckpoint = [vect(-43.069, 3.3, 5.652), vect(-68.091, 6.4, -14.181), vect(44.356, 2.3, 62.423)]
        PosFinish = vect(-23.554, 3.2, -15.238)
        return
    if getCurrentMap() == Map.WATCHPOINT_GIBRALTAR:
        PosStart = vect(70.129, 3, -44.346)
        PosCheckpoint = [vect(94.532, -1, 42.21), vect(96.233, 1, 15.036), vect(28.308, -6.1, -158.458), vect(66.1, -2.6, -114.92), vect(64.438, 0.3, 13.364)]
        PosFinish = vect(59.279, -3.2, -39.483)
        PosBarrier = [vect(38.005, 4.175, -76.422), vect(38.619, -3.844, -76.96)]
        return
    #FFA
    if getCurrentMap() == Map.CHATEAU_GUILLARD:
        PosStart = vect(0, 0, 0)
        PosCheckpoint = [vect(0, 0, 0)]
        PosFinish = vect(0, 0, 0)
        return
    if getCurrentMap() == Map.KANEZAKA:
        PosStart = vect(0, 0, 0)
        PosCheckpoint = [vect(0, 0, 0)]
        PosFinish = vect(0, 0, 0)
        return
    if getCurrentMap() == Map.MALEVENTO:
        PosStart = vect(0, 0, 0)
        PosCheckpoint = [vect(0, 0, 0)]
        PosFinish = vect(0, 0, 0)
        return
    if getCurrentMap() == Map.PETRA:
        PosStart = vect(0, 0, 0)
        PosCheckpoint = [vect(0, 0, 0)]
        PosFinish = vect(0, 0, 0)
        return
    #Hybrid
    if getCurrentMap() == Map.BLIZZ_WORLD:
        PosStart = vect(-46.717, 4.7, 86.88)
        PosCheckpoint = [vect(0.922, -1, 107.766), vect(2.998, -4.2, -18.814), vect(-122.15, -0.3, 110.5)]
        PosFinish = vect(-50.14, -0.3, 93.171)
        return
    if getCurrentMap() == Map.EICHENWALDE:
        PosStart = vect(69.737, 18.36, -66.742)
        PosCheckpoint = [vect(31.753, 13.5, -79.386), vect(142.5, 11.7, -38.836), vect(3.39, -0.1, -8.241)]
        PosFinish = vect(73.816, 12.6, -75.982)
        return
    if getCurrentMap() == Map.HOLLYWOOD:
        PosStart = vect(7.65, 6, -55.154)
        PosCheckpoint = [vect(16.595, -0.1, 62.76), vect(-12.548, -0.1, 64.54), vect(-37.391, 1.7, -140.414), vect(-4.969, 1.5, -99.506), vect(-47.322, -0.5, 12.226)]
        PosFinish = vect(8.044, 1.5, -48.109)
        return
    if getCurrentMap() == Map.KINGS_ROW:
        PosStart = vect(-56.613, -0.3, -42.469)
        PosCheckpoint = [vect(-154.342, -3.3, 24.929), vect(6.499, -0.2, -28.248), vect(-25.912, -0.2, 10.967)]
        PosFinish = vect(-70.902, 4.4, -36.354)
        return
    if getCurrentMap() == Map.NUMBANI:
        PosStart = vect(161.121, -4, 6.575)
        PosCheckpoint = [vect(207.578, -2.2, 31.463), vect(203.656, -3.9, 1.168), vect(120.67, -5.8, -17.039), vect(131.903, -3.8, 40.896), vect(59.889, -0.8, -25.254), vect(8.506, 0.2, 37.804)]
        PosFinish = vect(169.395, 4.2, 6.428)
        return
    #Control
    if getCurrentMap() == Map.BUSAN:
        #Downtown
        if not getCurrentObjective():
            PosStart = vect(52.012, 10, -117.491)
            PosCheckpoint = [vect(51.837, 4.8, -77.729), vect(-10.418, 15.9, -125.283), vect(114.197, 15.9, -125.294)]
            PosFinish = vect(52.012, 14.4, -117.491)
            return
        #MEKA Base
        if getCurrentObjective() == 2:
            PosStart = vect(217.009, 10.09, 228.832)
            PosCheckpoint = [vect(272.082, 10, 212.348), vect(167.216, 10, 257.301), vect(217.798, 17, 230.83)]
            PosFinish = vect(222.709, 9, 242.021)
            return
        #Sanctuary
        if getCurrentObjective() == 1:
            PosStart = vect(-328.384, 8.8, 144.334)
            PosCheckpoint = [vect(-389.913, 9, 139.646), vect(-328.561, 8, 180.59), vect(-266.552, 9, 138.877), vect(-327.941, 9.7, 117.976)]
            PosFinish = vect(-328.184, 13.5, 140.64)
            return
    #Ilios
    if getCurrentMap() == Map.ILIOS_LIGHTHOUSE:
        PosStart = vect(336.294, -23.7, -42.507)
        PosCheckpoint = [vect(336.182, -25.7, 22.951), vect(290.258, -25.7, -88.687), vect(357.797, -25.7, -50.871), vect(322.5, -23.7, -36.7)]
        PosFinish = vect(338.282, -25.7, -43.21)
        return
    if getCurrentMap() == Map.ILIOS_RUINS:
        PosStart = vect(28.463, 57.37, -163.093)
        PosCheckpoint = [vect(87.767, 58.3, -148.654), vect(113.185, 65.3, -178.097), vect(-55.96, 60.3, -158.273)]
        PosFinish = vect(28.411, 57.3, -156.448)
        return
    if getCurrentMap() == Map.ILIOS_WELL:
        PosStart = vect(-201.811, 0.8, -10.588)
        PosCheckpoint = [vect(-155.044, -4, -58.727), vect(-179.473, -0.5, -87.438), vect(-258.817, -5.2, 21.142)]
        PosFinish = vect(-199.735, 9.8, -7.602)
        return
    #Lijiang
    if getCurrentMap() == Map.LIJIANG_CONTROL_CENTER:
        PosStart = vect(0.023, 270, 301.513)
        PosCheckpoint = [vect(36.745, 264.9, 336.094), vect(-36.683, 264.9, 336.086), vect(0.125, 269.9, 260.847)]
        PosFinish = vect(-0.021, 267.3, 280)
        return
    if getCurrentMap() == Map.LIJIANG_GARDEN:
        PosStart = vect(-0.178, 94, 140.449)
        PosCheckpoint = [vect(0, 95.9, 110), vect(56.906, 93.9, 145.431), vect(-64.365, 97.9, 162.007)]
        PosFinish = vect(0, 93.9, 150)
        return
    if getCurrentMap() == Map.LIJIANG_NIGHT_MARKET:
        PosStart = vect(1.155, 0, -20.142)
        PosCheckpoint = [vect(1.061, -1.1, -73.3), vect(27.511, -0.1, -18.133), vect(-56.438, 1.8, -29.101)]
        PosFinish = vect(0.84, -1.2, -29.825)
        return
    #Nepal
    if getCurrentMap() == Map.NEPAL_SANCTUM:
        PosStart = vect(67.643, 132, 0.073)
        PosCheckpoint = [vect(97.8, 131.7, 73.715), vect(96.973, 131.7, -0.008), vect(56.276, 129.7, -0.025), vect(70.755, 127.7, -63.246)]
        PosFinish = vect(83.1, 127.9, 0.05)
        return
    if getCurrentMap() == Map.NEPAL_SHRINE:
        PosStart = vect(-52.552, 13.13, 0)
        PosCheckpoint = [vect(-53.696, 14.7, -63.339), vect(-53.662, 14.7, 63.728)]
        PosFinish = vect(-50, 12.7, 0)
        return
    if getCurrentMap() == Map.NEPAL_VILLAGE:
        PosStart = vect(-183.773, -94.08, 0)
        PosCheckpoint = [vect(-171.284, -99.3, -62.016), vect(-155.566, -91.2, 45.98), vect(-186.996, -96.6, 72.119)]
        PosFinish = vect(-181.606, -88, 0)
        return
    #Oasis
    if getCurrentMap() == Map.OASIS_CITY_CENTER:
        PosStart = vect(143.522, 2.15, 247.456)
        PosCheckpoint = [vect(125.589, 0.9, 229.793), vect(91.966, 0.9, 305.984), vect(158.681, 3.9, 262.665), vect(183.478, -3.5, 207.761)]
        PosFinish = vect(143.522, 9.9, 247.456)
        return
    if getCurrentMap() == Map.OASIS_GARDENS:
        PosStart = vect(122.619, 6.27, -228.847)
        PosCheckpoint = [vect(186.331, 8.3, -195.651), vect(83.077, 5.4, -262.511), vect(120.717, 7.4, -267.995)]
        PosFinish = vect(121.375, 11.4, -227.604)
        return
    if getCurrentMap() == Map.OASIS_UNIVERSITY:
        PosStart = vect(-196.495, 15, 0)
        PosCheckpoint = [vect(-188.089, 19.9, 115.294), vect(-171.972, 14.9, -44.885), vect(-207.617, 17.9, -62.585)]
        PosFinish = vect(-202.067, 18.9, -0.002)


#Gamemode
rule "Start - Global FFA":
    @Condition getCurrentGamemode() == Gamemode.FFA

    hudSubtext(getAllPlayers(), "{0}:{1}:{2}".format(floor(getMatchTime() / 3600), floor((getMatchTime() - floor(getMatchTime() / 3600) * 3600) / 60), floor(getMatchTime() - floor(getMatchTime() / 60) * 60)), HudPosition.TOP, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    disableScoring()
    disableGamemodeCompletion()
    disableAnnouncer()
    setMatchTime(0)


rule "Start - Global":
    #Vars
    wait()
    setMatchTime(Time + 10)
    TimeFirstStan = 9999
    TimeFirstGrav = 9999
    TimeSecondStan = 9999
    TimeSecondGrav = 9999
    TimeThirdStan = 9999
    TimeThirdGrav = 9999
    Visible = true
    #Start / Checkpoint / Finish / Barrier effects
    createEffect(getAllPlayers(), Effect.RING, Color.GREEN, PosStart, 2, EffectReeval.VISIBILITY)
    createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, Color.WHITE, PosFinish, 5, EffectReeval.VISIBILITY)
    createEffect(getAllPlayers(), Effect.RING, Color.WHITE, PosFinish, 5, EffectReeval.VISIBILITY)
    createIcon(getAllPlayers(), PosFinish + vect(0, 6, 0), Icon.FLAG, IconReeval.VISIBILITY, Color.WHITE, true)
    #Non-sense ahead. Workshop only evaluades index when var is array, so no loop possible.
    if PosCheckpoint[0]:
        #Not collected
        createEffect([player for player in getAllPlayers() if not player.Checkpoint[0]], Effect.LIGHT_SHAFT, Color.SKY_BLUE, PosCheckpoint[0], 3.5, EffectReeval.VISIBILITY)
        createEffect([player for player in getAllPlayers() if not player.Checkpoint[0]], Effect.RING, Color.SKY_BLUE, PosCheckpoint[0], 3.5, EffectReeval.VISIBILITY)
        createIcon([player for player in getAllPlayers() if not player.Checkpoint[0]], PosCheckpoint[0] + vect(0, 6, 0), Icon.ARROW_DOWN, IconReeval.VISIBILITY, Color.SKY_BLUE, false)
        #Collected
        createEffect([player for player in getAllPlayers() if player.Checkpoint[0]], Effect.LIGHT_SHAFT, Color.LIME_GREEN, PosCheckpoint[0], 3.5, EffectReeval.VISIBILITY)
        createEffect([player for player in getAllPlayers() if player.Checkpoint[0]], Effect.RING, Color.LIME_GREEN, PosCheckpoint[0], 3.5, EffectReeval.VISIBILITY)
        createIcon([player for player in getAllPlayers() if player.Checkpoint[0]], PosCheckpoint[0] + vect(0, 6, 0), Icon.CHECKMARK, IconReeval.VISIBILITY, Color.LIME_GREEN, false)
    if PosCheckpoint[1]:
        createEffect([player for player in getAllPlayers() if not player.Checkpoint[1]], Effect.LIGHT_SHAFT, Color.SKY_BLUE, PosCheckpoint[1], 3.5, EffectReeval.VISIBILITY)
        createEffect([player for player in getAllPlayers() if not player.Checkpoint[1]], Effect.RING, Color.SKY_BLUE, PosCheckpoint[1], 3.5, EffectReeval.VISIBILITY)
        createIcon([player for player in getAllPlayers() if not player.Checkpoint[1]], PosCheckpoint[1] + vect(0, 6, 0), Icon.ARROW_DOWN, IconReeval.VISIBILITY, Color.SKY_BLUE, false)
        createEffect([player for player in getAllPlayers() if player.Checkpoint[1]], Effect.LIGHT_SHAFT, Color.LIME_GREEN, PosCheckpoint[1], 3.5, EffectReeval.VISIBILITY)
        createEffect([player for player in getAllPlayers() if player.Checkpoint[1]], Effect.RING, Color.LIME_GREEN, PosCheckpoint[1], 3.5, EffectReeval.VISIBILITY)
        createIcon([player for player in getAllPlayers() if player.Checkpoint[1]], PosCheckpoint[1] + vect(0, 6, 0), Icon.CHECKMARK, IconReeval.VISIBILITY, Color.LIME_GREEN, false)
    if PosCheckpoint[2]:
        createEffect([player for player in getAllPlayers() if not player.Checkpoint[2]], Effect.LIGHT_SHAFT, Color.SKY_BLUE, PosCheckpoint[2], 3.5, EffectReeval.VISIBILITY)
        createEffect([player for player in getAllPlayers() if not player.Checkpoint[2]], Effect.RING, Color.SKY_BLUE, PosCheckpoint[2], 3.5, EffectReeval.VISIBILITY)
        createIcon([player for player in getAllPlayers() if not player.Checkpoint[2]], PosCheckpoint[2] + vect(0, 6, 0), Icon.ARROW_DOWN, IconReeval.VISIBILITY, Color.SKY_BLUE, false)
        createEffect([player for player in getAllPlayers() if player.Checkpoint[2]], Effect.LIGHT_SHAFT, Color.LIME_GREEN, PosCheckpoint[2], 3.5, EffectReeval.VISIBILITY)
        createEffect([player for player in getAllPlayers() if player.Checkpoint[2]], Effect.RING, Color.LIME_GREEN, PosCheckpoint[2], 3.5, EffectReeval.VISIBILITY)
        createIcon([player for player in getAllPlayers() if player.Checkpoint[2]], PosCheckpoint[2] + vect(0, 6, 0), Icon.CHECKMARK, IconReeval.VISIBILITY, Color.LIME_GREEN, false)
    if PosCheckpoint[3]:
        createEffect([player for player in getAllPlayers() if not player.Checkpoint[3]], Effect.LIGHT_SHAFT, Color.SKY_BLUE, PosCheckpoint[3], 3.5, EffectReeval.VISIBILITY)
        createEffect([player for player in getAllPlayers() if not player.Checkpoint[3]], Effect.RING, Color.SKY_BLUE, PosCheckpoint[3], 3.5, EffectReeval.VISIBILITY)
        createIcon([player for player in getAllPlayers() if not player.Checkpoint[3]], PosCheckpoint[3] + vect(0, 6, 0), Icon.ARROW_DOWN, IconReeval.VISIBILITY, Color.SKY_BLUE, false)
        createEffect([player for player in getAllPlayers() if player.Checkpoint[3]], Effect.LIGHT_SHAFT, Color.LIME_GREEN, PosCheckpoint[3], 3.5, EffectReeval.VISIBILITY)
        createEffect([player for player in getAllPlayers() if player.Checkpoint[3]], Effect.RING, Color.LIME_GREEN, PosCheckpoint[3], 3.5, EffectReeval.VISIBILITY)
        createIcon([player for player in getAllPlayers() if player.Checkpoint[3]], PosCheckpoint[3] + vect(0, 6, 0), Icon.CHECKMARK, IconReeval.VISIBILITY, Color.LIME_GREEN, false)
    if PosCheckpoint[4]:
        createEffect([player for player in getAllPlayers() if not player.Checkpoint[4]], Effect.LIGHT_SHAFT, Color.SKY_BLUE, PosCheckpoint[4], 3.5, EffectReeval.VISIBILITY)
        createEffect([player for player in getAllPlayers() if not player.Checkpoint[4]], Effect.RING, Color.SKY_BLUE, PosCheckpoint[4], 3.5, EffectReeval.VISIBILITY)
        createIcon([player for player in getAllPlayers() if not player.Checkpoint[4]], PosCheckpoint[4] + vect(0, 6, 0), Icon.ARROW_DOWN, IconReeval.VISIBILITY, Color.SKY_BLUE, false)
        createEffect([player for player in getAllPlayers() if player.Checkpoint[4]], Effect.LIGHT_SHAFT, Color.LIME_GREEN, PosCheckpoint[4], 3.5, EffectReeval.VISIBILITY)
        createEffect([player for player in getAllPlayers() if player.Checkpoint[4]], Effect.RING, Color.LIME_GREEN, PosCheckpoint[4], 3.5, EffectReeval.VISIBILITY)
        createIcon([player for player in getAllPlayers() if player.Checkpoint[4]], PosCheckpoint[4] + vect(0, 6, 0), Icon.CHECKMARK, IconReeval.VISIBILITY, Color.LIME_GREEN, false)
    if PosCheckpoint[5]:
        createEffect([player for player in getAllPlayers() if not player.Checkpoint[5]], Effect.LIGHT_SHAFT, Color.SKY_BLUE, PosCheckpoint[5], 3.5, EffectReeval.VISIBILITY)
        createEffect([player for player in getAllPlayers() if not player.Checkpoint[5]], Effect.RING, Color.SKY_BLUE, PosCheckpoint[5], 3.5, EffectReeval.VISIBILITY)
        createIcon([player for player in getAllPlayers() if not player.Checkpoint[5]], PosCheckpoint[5] + vect(0, 6, 0), Icon.ARROW_DOWN, IconReeval.VISIBILITY, Color.SKY_BLUE, false)
        createEffect([player for player in getAllPlayers() if player.Checkpoint[5]], Effect.LIGHT_SHAFT, Color.LIME_GREEN, PosCheckpoint[5], 3.5, EffectReeval.VISIBILITY)
        createEffect([player for player in getAllPlayers() if player.Checkpoint[5]], Effect.RING, Color.LIME_GREEN, PosCheckpoint[5], 3.5, EffectReeval.VISIBILITY)
        createIcon([player for player in getAllPlayers() if player.Checkpoint[5]], PosCheckpoint[5] + vect(0, 6, 0), Icon.CHECKMARK, IconReeval.VISIBILITY, Color.LIME_GREEN, false)
    if PosCheckpoint[6]:
        createEffect([player for player in getAllPlayers() if not player.Checkpoint[6]], Effect.LIGHT_SHAFT, Color.SKY_BLUE, PosCheckpoint[6], 3.5, EffectReeval.VISIBILITY)
        createEffect([player for player in getAllPlayers() if not player.Checkpoint[6]], Effect.RING, Color.SKY_BLUE, PosCheckpoint[6], 3.5, EffectReeval.VISIBILITY)
        createIcon([player for player in getAllPlayers() if not player.Checkpoint[6]], PosCheckpoint[6] + vect(0, 6, 0), Icon.ARROW_DOWN, IconReeval.VISIBILITY, Color.SKY_BLUE, false)
        createEffect([player for player in getAllPlayers() if player.Checkpoint[6]], Effect.LIGHT_SHAFT, Color.LIME_GREEN, PosCheckpoint[6], 3.5, EffectReeval.VISIBILITY)
        createEffect([player for player in getAllPlayers() if player.Checkpoint[6]], Effect.RING, Color.LIME_GREEN, PosCheckpoint[6], 3.5, EffectReeval.VISIBILITY)
        createIcon([player for player in getAllPlayers() if player.Checkpoint[6]], PosCheckpoint[6] + vect(0, 6, 0), Icon.CHECKMARK, IconReeval.VISIBILITY, Color.LIME_GREEN, false)
    if PosCheckpoint[7]:
        createEffect([player for player in getAllPlayers() if not player.Checkpoint[7]], Effect.LIGHT_SHAFT, Color.SKY_BLUE, PosCheckpoint[7], 3.5, EffectReeval.VISIBILITY)
        createEffect([player for player in getAllPlayers() if not player.Checkpoint[7]], Effect.RING, Color.SKY_BLUE, PosCheckpoint[7], 3.5, EffectReeval.VISIBILITY)
        createIcon([player for player in getAllPlayers() if not player.Checkpoint[7]], PosCheckpoint[7] + vect(0, 6, 0), Icon.ARROW_DOWN, IconReeval.VISIBILITY, Color.SKY_BLUE, false)
        createEffect([player for player in getAllPlayers() if player.Checkpoint[7]], Effect.LIGHT_SHAFT, Color.LIME_GREEN, PosCheckpoint[7], 3.5, EffectReeval.VISIBILITY)
        createEffect([player for player in getAllPlayers() if player.Checkpoint[7]], Effect.RING, Color.LIME_GREEN, PosCheckpoint[7], 3.5, EffectReeval.VISIBILITY)
        createIcon([player for player in getAllPlayers() if player.Checkpoint[7]], PosCheckpoint[7] + vect(0, 6, 0), Icon.CHECKMARK, IconReeval.VISIBILITY, Color.LIME_GREEN, false)
    if PosCheckpoint[8]:
        createEffect([player for player in getAllPlayers() if not player.Checkpoint[8]], Effect.LIGHT_SHAFT, Color.SKY_BLUE, PosCheckpoint[8], 3.5, EffectReeval.VISIBILITY)
        createEffect([player for player in getAllPlayers() if not player.Checkpoint[8]], Effect.RING, Color.SKY_BLUE, PosCheckpoint[8], 3.5, EffectReeval.VISIBILITY)
        createIcon([player for player in getAllPlayers() if not player.Checkpoint[8]], PosCheckpoint[8] + vect(0, 6, 0), Icon.ARROW_DOWN, IconReeval.VISIBILITY, Color.SKY_BLUE, false)
        createEffect([player for player in getAllPlayers() if player.Checkpoint[8]], Effect.LIGHT_SHAFT, Color.LIME_GREEN, PosCheckpoint[8], 3.5, EffectReeval.VISIBILITY)
        createEffect([player for player in getAllPlayers() if player.Checkpoint[8]], Effect.RING, Color.LIME_GREEN, PosCheckpoint[8], 3.5, EffectReeval.VISIBILITY)
        createIcon([player for player in getAllPlayers() if player.Checkpoint[8]], PosCheckpoint[8] + vect(0, 6, 0), Icon.CHECKMARK, IconReeval.VISIBILITY, Color.LIME_GREEN, false)
    if PosCheckpoint[9]:
        createEffect([player for player in getAllPlayers() if not player.Checkpoint[9]], Effect.LIGHT_SHAFT, Color.SKY_BLUE, PosCheckpoint[9], 3.5, EffectReeval.VISIBILITY)
        createEffect([player for player in getAllPlayers() if not player.Checkpoint[9]], Effect.RING, Color.SKY_BLUE, PosCheckpoint[9], 3.5, EffectReeval.VISIBILITY)
        createIcon([player for player in getAllPlayers() if not player.Checkpoint[9]], PosCheckpoint[9] + vect(0, 6, 0), Icon.ARROW_DOWN, IconReeval.VISIBILITY, Color.SKY_BLUE, false)
        createEffect([player for player in getAllPlayers() if player.Checkpoint[9]], Effect.LIGHT_SHAFT, Color.LIME_GREEN, PosCheckpoint[9], 3.5, EffectReeval.VISIBILITY)
        createEffect([player for player in getAllPlayers() if player.Checkpoint[9]], Effect.RING, Color.LIME_GREEN, PosCheckpoint[9], 3.5, EffectReeval.VISIBILITY)
        createIcon([player for player in getAllPlayers() if player.Checkpoint[9]], PosCheckpoint[9] + vect(0, 6, 0), Icon.CHECKMARK, IconReeval.VISIBILITY, Color.LIME_GREEN, false)
    for Loop1 in range(0, len(PosBarrier), 1):
        createEffect(getAllPlayers(), Effect.SPHERE, Color.RED, PosBarrier[Loop1], 5, EffectReeval.VISIBILITY)

    #Seaons / Mode information
    hudHeader([player for player in getAllPlayers() if not player.Category], "Lucio Surf v5.5 | Season {0} | Standard".format(Season + 1), HudPosition.RIGHT, 0, Color.YELLOW, HudReeval.VISIBILITY)
    hudHeader([player for player in getAllPlayers() if player.Category == 1], "Lucio Surf v5.5 | Season {0} | Gravspeed".format(Season + 1), HudPosition.RIGHT, 0, Color.YELLOW, HudReeval.VISIBILITY)
    #Leaderboards
    hudHeader([player for player in getAllPlayers() if not player.Category], "3 - {0}{1} sec - {2}".format(TimeThirdStan, "{0}".format(10*TimeThirdStan).split(".")[1].charAt(1), PlayerThirdStan), HudPosition.RIGHT, 3, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader([player for player in getAllPlayers() if not player.Category], "2 - {0}{1} sec - {2}".format(TimeSecondStan, "{0}".format(10*TimeSecondStan).split(".")[1].charAt(1), PlayerSecondStan), HudPosition.RIGHT, 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader([player for player in getAllPlayers() if not player.Category], "Record - {0}{1} sec - {2}".format(TimeFirstStan, "{0}".format(10*TimeFirstStan).split(".")[1].charAt(1), PlayerFirstStan), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader([player for player in getAllPlayers() if player.Category == 1], "3 - {0}{1} sec - {2}".format(TimeThirdGrav, "{0}".format(10*TimeThirdGrav).split(".")[1].charAt(1), PlayerThirdGrav), HudPosition.RIGHT, 3, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader([player for player in getAllPlayers() if player.Category == 1], "2 - {0}{1} sec - {2}".format(TimeSecondGrav, "{0}".format(10*TimeSecondGrav).split(".")[1].charAt(1), PlayerSecondGrav), HudPosition.RIGHT, 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader([player for player in getAllPlayers() if player.Category == 1], "Record - {0}{1} sec - {2}".format(TimeFirstGrav, "{0}".format(10*TimeFirstGrav).split(".")[1].charAt(1), PlayerFirstGrav), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    #Help text standard
    hudSubtext(getAllPlayers(), "Toggle Help - Crouch + Interact", HudPosition.LEFT, 3, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and not player.Mode], "Reset - Ultimate", HudPosition.LEFT, 4, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and player.Mode != -1 and player == hostPlayer], "Toggle Invisibility - Crouch + Reload", HudPosition.LEFT, 5, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and not player.Mode], "Cycle Auto Reset - Crouch + Melee", HudPosition.LEFT, 6, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and not player.Mode], "Cycle Category - Crouch + Ability 2", HudPosition.LEFT, 7, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and not player.Mode], "Practice Mode - Interact", HudPosition.LEFT, 8, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and not player.Mode], "Player Spectator Mode - Ability 2", HudPosition.LEFT, 9, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and not player.Mode], "Spectator Mode - Reload", HudPosition.LEFT, 10, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    #Help text practice
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and player.Mode == 1], "Standard Mode - Interact", HudPosition.LEFT, 5, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and player.Mode == 1], "Ult Reset (Checkpoint) - Ultimate", HudPosition.LEFT, 6, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and player.Mode == 1], "Set Checkpoint - Secondary Fire", HudPosition.LEFT, 7, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and player.Mode == 1], "Delete Checkpoint - Ability 2", HudPosition.LEFT, 8, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    #Help text playerspec
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and player.Mode == 2], "Standard Mode - Ability 2", HudPosition.LEFT, 5, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and player.Mode == 2], "Spectate next - Primary Fire", HudPosition.LEFT, 6, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and player.Mode == 2], "Spectate previous - Secondary Fire", HudPosition.LEFT, 7, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)    
    #Help text spectator
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and player.Mode == 3], "Standard Mode - Reload", HudPosition.LEFT, 5, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and player.Mode == 3], "Stop - Primary Fire", HudPosition.LEFT, 6, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHelp and player.Mode == 3], "Slow Move - Secondary Fire", HudPosition.LEFT, 7, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)


rule "Start - Player FFA":
    @Event eachPlayer
    @Condition getCurrentGamemode() == Gamemode.FFA

    eventPlayer.disableGamemodeHud()


rule "Start - Player":
    @Event eachPlayer
    @Condition eventPlayer.hasSpawned()
    
    #vars
    eventPlayer.Mode = 0
    eventPlayer.TimeBestStan = 9999
    eventPlayer.TimeBestGrav = 9999
    eventPlayer.Finished = false
    eventPlayer.PracticeCheckpoint = false
    eventPlayer.Checkpoint = []
    for eventPlayer.CheckpointLoop in range(0, len(PosCheckpoint), 1):
        eventPlayer.Checkpoint.append(false)
    eventPlayer.Attempts = -1
    eventPlayer.SpeedColor = Color.RED
    eventPlayer.HideHelp = true
    #Category setup
    eventPlayer.Category = Category
    if not Category:
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
    hudHeader(eventPlayer if not eventPlayer.Category else null, "Best - {0}{1} sec".format(eventPlayer.TimeBestStan, "{0}".format(10*eventPlayer.TimeBestStan).split(".")[1].charAt(1)), HudPosition.LEFT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader(eventPlayer if eventPlayer.Category == 1 else null, "Best - {0}{1} sec".format(eventPlayer.TimeBestGrav, "{0}".format(10*eventPlayer.TimeBestGrav).split(".")[1].charAt(1)), HudPosition.LEFT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader(eventPlayer, "ATTEMPTS: {0}".format(eventPlayer.Attempts), HudPosition.LEFT, 2, Color.WHITE, HudReeval.STRING, SpecVisibility.DEFAULT)
    hudHeader(eventPlayer, "{0} m/s".format(eventPlayer.getHorizontalSpeed()), HudPosition.TOP, 0.1, eventPlayer.SpeedColor, HudReeval.STRING_AND_COLOR, SpecVisibility.DEFAULT)
    hudHeader(eventPlayer, "{0}{1} sec".format(eventPlayer.TimeCurrent, "{0}".format(10*eventPlayer.TimeCurrent).split(".")[1].charAt(1)), HudPosition.TOP, 0.2, Color.WHITE, HudReeval.STRING, SpecVisibility.DEFAULT)
    #Start
    async(Respawn, AsyncBehavior.NOOP)


rule "Start timer":
    @Event eachPlayer
    @Condition not eventPlayer.Mode
    @Condition not any([checkpoint for checkpoint in eventPlayer.Checkpoint])
    @Condition distance(PosStart, vect(updateEveryTick(eventPlayer.getPosition()).x, PosStart.y, updateEveryTick(eventPlayer.getPosition()).z)) > 2 or abs(updateEveryTick(eventPlayer.getPosition()).y - PosStart.y) > 3
    
    chase(eventPlayer.TimeCurrent, 5000, rate=1, ChaseReeval.NONE)
    if not Visible:
        return
    eventPlayer.setInvisibility(Invis.NONE)


rule "Checkpoint":
    @Event eachPlayer
    @Condition Checkpoint
    @Condition not eventPlayer.Finished
    @Condition not eventPlayer.Mode
    @Condition any([distance(checkpoint, vect(eventPlayer.getPosition().x, checkpoint.y, eventPlayer.getPosition().z)) <= 3.5 and eventPlayer.getPosition().y >= checkpoint.y for checkpoint in PosCheckpoint])
    
    if eventPlayer.TimeCurrent < 0.1:
        smallMessage(eventPlayer, "No timer start.")
        async(Respawn, AsyncBehavior.NOOP)
        return

    eventPlayer.CurrCheckpoint = PosCheckpoint.index([checkpoint for checkpoint in PosCheckpoint if distance(checkpoint, vect(eventPlayer.getPosition().x, checkpoint.y, eventPlayer.getPosition().z)) <= 3.5 and eventPlayer.getPosition().y >= checkpoint.y][0])
    if eventPlayer.CurrCheckpoint == -1 or eventPlayer.Checkpoint[eventPlayer.CurrCheckpoint]:
        smallMessage(eventPlayer, "Checkpoint already collected")
        return
    
    eventPlayer.Checkpoint[eventPlayer.CurrCheckpoint] = true
    if all([checkpoint for checkpoint in eventPlayer.Checkpoint]):
        smallMessage(eventPlayer, "Finish unlocked - {0}{1} sec".format(eventPlayer.TimeCurrent, "{0}".format(10*eventPlayer.TimeCurrent).split('.')[1].charAt(1)))
        return
    
    smallMessage(eventPlayer, "Checkpoints: {0} - {1}{2} sec".format("{0}/{1}".format(len([checkpoint for checkpoint in eventPlayer.Checkpoint if checkpoint]), len(PosCheckpoint)), eventPlayer.TimeCurrent, "{0}".format(10*eventPlayer.TimeCurrent).split('.')[1].charAt(1)))


rule "Checkpoint (no LoS)":
    @Event eachPlayer
    @Condition Checkpoint
    @Condition not eventPlayer.Finished
    @Condition not eventPlayer.Mode
    @Condition any([distance(checkpoint, vect(eventPlayer.getPosition().x, checkpoint.y, eventPlayer.getPosition().z)) <= 3.5 and eventPlayer.getPosition().y < checkpoint.y for checkpoint in PosCheckpoint])
    
    eventPlayer.CurrCheckpoint = PosCheckpoint.index([checkpoint for checkpoint in PosCheckpoint if distance(checkpoint, vect(eventPlayer.getPosition().x, checkpoint.y, eventPlayer.getPosition().z)) <= 3.5 and eventPlayer.getPosition().y < checkpoint.y][0])
    if (eventPlayer.CurrCheckpoint == -1 or eventPlayer.Checkpoint[eventPlayer.CurrCheckpoint]):
        return

    smallMessage(eventPlayer, l"{0} {1}".format(l"Checkpoint", l"Out of View"))


rule "Finish":
    @Event eachPlayer
    @Condition all([checkpoint for checkpoint in eventPlayer.Checkpoint])
    @Condition not eventPlayer.Finished
    @Condition not eventPlayer.Mode
    @Condition distance(PosFinish, vect(updateEveryTick(eventPlayer.getPosition().x), PosFinish.y, updateEveryTick(eventPlayer.getPosition().z))) <= 5
    @Condition updateEveryTick(eventPlayer.getPosition().y) >= PosFinish.y
    
    if eventPlayer.TimeCurrent < 0.1:
        smallMessage(eventPlayer, "No timer start.")
        async(Respawn, AsyncBehavior.NOOP)
        return

    stopChasingVariable(eventPlayer.TimeCurrent)
    eventPlayer.Attempts += 1

    if not eventPlayer.Category:
        if eventPlayer.TimeCurrent < eventPlayer.TimeBestStan:
            if eventPlayer.TimeCurrent < TimeThirdStan and eventPlayer != PlayerSecondStan and eventPlayer != PlayerFirstStan:
                TimeThirdStan = eventPlayer.TimeCurrent
                PlayerThirdStan = eventPlayer
            if eventPlayer.TimeCurrent < TimeSecondStan and eventPlayer != PlayerFirstStan:
                if eventPlayer != PlayerSecondStan:
                    TimeThirdStan = TimeSecondStan
                    PlayerThirdStan = PlayerSecondStan
                TimeSecondStan = eventPlayer.TimeCurrent
                PlayerSecondStan = eventPlayer
            if eventPlayer.TimeCurrent < TimeFirstStan:
                if eventPlayer != PlayerFirstStan:
                    TimeSecondStan = TimeFirstStan
                    PlayerSecondStan = PlayerFirstStan
                TimeFirstStan = eventPlayer.TimeCurrent
                PlayerFirstStan = eventPlayer
            eventPlayer.TimeBestStan = eventPlayer.TimeCurrent
            eventPlayer.NewBest = true
        else:
            bigMessage(eventPlayer, l"{0}!!!".format(l"Finished"))

    elif eventPlayer.Category == 1:
        if eventPlayer.TimeCurrent < eventPlayer.TimeBestGrav:
            if eventPlayer.TimeCurrent < TimeThirdGrav and eventPlayer != PlayerSecondGrav and eventPlayer != PlayerFirstGrav:
                TimeThirdGrav = eventPlayer.TimeCurrent
                PlayerThirdGrav = eventPlayer
            if eventPlayer.TimeCurrent < TimeSecondGrav and eventPlayer != PlayerFirstGrav:
                if eventPlayer != PlayerSecondGrav:
                    TimeThirdGrav = TimeSecondGrav
                    PlayerThirdGrav = PlayerSecondGrav
                TimeSecondGrav = eventPlayer.TimeCurrent
                PlayerSecondGrav = eventPlayer
            if eventPlayer.TimeCurrent < TimeFirstGrav:
                if eventPlayer != PlayerFirstGrav:
                    TimeSecondGrav = TimeFirstGrav
                    PlayerSecondGrav = PlayerFirstGrav
                TimeFirstGrav = eventPlayer.TimeCurrent
                PlayerFirstGrav = eventPlayer
            eventPlayer.TimeBestGrav = eventPlayer.TimeCurrent
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

    smallMessage(eventPlayer, l"{0} {1}".format(l"Finish", l"Out of View"))


rule "Finish (no Checkpoint)":
    @Event eachPlayer
    @Condition not all([checkpoint for checkpoint in eventPlayer.Checkpoint])
    @Condition not eventPlayer.Finished
    @Condition not eventPlayer.Mode
    @Condition distance(PosFinish, vect(eventPlayer.getPosition().x, PosFinish.y, eventPlayer.getPosition().z)) <= 5
    @Condition eventPlayer.getPosition().y >= PosFinish.y

    bigMessage(eventPlayer, l"{0} {1}".format(l"No", l"Checkpoint"))


rule "Finish Message (Best Time)":
    @Event eachPlayer
    @Condition eventPlayer.Finished
    @Condition eventPlayer.NewBest
    @Condition (not eventPlayer.Category and eventPlayer != PlayerFirstStan) or (eventPlayer.Category == 1 and eventPlayer != PlayerFirstGrav)
    
    bigMessage(eventPlayer, "New PB: {0}{1} sec".format(eventPlayer.TimeBestStan if not eventPlayer.Category else eventPlayer.TimeBestGrav, "{0}".format(10*(eventPlayer.TimeBestStan if not eventPlayer.Category else eventPlayer.TimeBestGrav)).split(".")[1].charAt(1)))


rule "Finish Message (Record Time)":
    @Event eachPlayer
    @Condition eventPlayer.Finished
    @Condition eventPlayer.NewBest
    @Condition (not eventPlayer.Category and eventPlayer == PlayerFirstStan) or (eventPlayer.Category == 1 and eventPlayer == PlayerFirstGrav)
    
    bigMessage([player for player in getAllPlayers() if player.Category == eventPlayer.Category], "New Record: {0}{1} sec - {2}!!!".format(eventPlayer.TimeBestStan if not eventPlayer.Category else eventPlayer.TimeBestGrav, "{0}".format(10*(eventPlayer.TimeBestStan if not eventPlayer.Category else eventPlayer.TimeBestGrav)).split(".")[1].charAt(1), eventPlayer))


rule "Floor":
    @Event eachPlayer
    @Condition eventPlayer.isOnGround()
    @Condition not eventPlayer.Mode
    @Condition distance(PosStart, vect(eventPlayer.getPosition().x, PosStart.y, eventPlayer.getPosition().z)) > 4
    @Condition distance(PosFinish, vect(eventPlayer.getPosition().x, PosFinish.y, eventPlayer.getPosition().z)) > 6
    @Condition not any([distance(checkpoint, vect(eventPlayer.getPosition().x, checkpoint.y, eventPlayer.getPosition().z)) <= 6 for checkpoint in PosCheckpoint]) or not Checkpoint
    
    async(Respawn, AsyncBehavior.NOOP)


rule "Ult Reset":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition not eventPlayer.Mode
    
    async(Respawn, AsyncBehavior.NOOP)


rule "Death":
    @Event playerDied
    @Condition eventPlayer.Mode != 2
    
    eventPlayer.resurrect()
    async(Respawn, AsyncBehavior.NOOP)


rule "Barrier":
    @Event eachPlayer
    @Condition any([distance(eventPlayer, barrier) <= 5 for barrier in PosBarrier])

    async(Respawn, AsyncBehavior.NOOP)


rule "Velocity Counter - Standard (Green)":
    @Event eachPlayer
    @Condition not eventPlayer.Category
    @Condition eventPlayer.getHorizontalSpeed() > 13.75

    eventPlayer.SpeedColor = Color.GREEN
    
    
rule "Velocity Counter - Standard (Yellow)":
    @Event eachPlayer
    @Condition not eventPlayer.Category
    @Condition eventPlayer.getHorizontalSpeed() > 11
    @Condition eventPlayer.getHorizontalSpeed() < 13.75

    eventPlayer.SpeedColor = Color.YELLOW


rule "Velocity Counter - Standard (Orange)":
    @Event eachPlayer
    @Condition not eventPlayer.Category
    @Condition eventPlayer.getHorizontalSpeed() > 6.88
    @Condition eventPlayer.getHorizontalSpeed() < 11

    eventPlayer.SpeedColor = Color.ORANGE
    
    
rule "Velocity Counter - Standard (Red)":
    @Event eachPlayer
    @Condition not eventPlayer.Category
    @Condition eventPlayer.getHorizontalSpeed() <= 6.88
    
    eventPlayer.SpeedColor = Color.RED


rule "Velocity Counter - Gravspeed (Green)":
    @Event eachPlayer
    @Condition eventPlayer.Category == 1
    @Condition eventPlayer.getHorizontalSpeed() > 17.2

    eventPlayer.SpeedColor = Color.GREEN


rule "Velocity Counter - Gravspeed (Yellow)":
    @Event eachPlayer
    @Condition eventPlayer.Category == 1
    @Condition eventPlayer.getHorizontalSpeed() > 13.15
    @Condition eventPlayer.getHorizontalSpeed() < 17.2

    eventPlayer.SpeedColor = Color.YELLOW


rule "Velocity Counter - Gravspeed (Orange)":
    @Event eachPlayer
    @Condition eventPlayer.Category == 1
    @Condition eventPlayer.getHorizontalSpeed() > 8.6
    @Condition eventPlayer.getHorizontalSpeed() < 13.15

    eventPlayer.SpeedColor = Color.ORANGE


rule "Velocity Counter - Gravspeed (Red)":
    @Event eachPlayer
    @Condition eventPlayer.Category == 1
    @Condition eventPlayer.getHorizontalSpeed() <= 8.6
    
    eventPlayer.SpeedColor = Color.RED


rule "Toggle Invisibility (Host only)":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.RELOAD) and eventPlayer.isHoldingButton(Button.CROUCH)
    @Condition eventPlayer == hostPlayer
    @Condition not eventPlayer.ExecutingMenu
    
    eventPlayer.ExecutingMenu = true
    if Visible:
        smallMessage(eventPlayer, l"{0} {1}".format(l"Players", l"Invisible"))
        getAllPlayers().setInvisibility(Invis.ALL)
        Visible = false
    else:
        smallMessage(eventPlayer, "{0} {1}".format(l"Players", l"Visible"))
        ([player for player in getAllPlayers() if not eventPlayer.Mode and (distance(PosStart, player.getPosition()) > 2 or not eventPlayer.isOnGround())]).setInvisibility(Invis.NONE)
        Visible = true
    waitUntil(not eventPlayer.isHoldingButton(Button.RELOAD), 9999)
    eventPlayer.ExecutingMenu = false


rule "Toggle Help":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) and eventPlayer.isHoldingButton(Button.CROUCH)
    @Condition not eventPlayer.ExecutingMenu
    
    eventPlayer.ExecutingMenu = true
    if eventPlayer.HideHelp:
        eventPlayer.HideHelp = false
    else:
        eventPlayer.HideHelp = true
    waitUntil(not eventPlayer.isHoldingButton(Button.INTERACT), 9999)
    eventPlayer.ExecutingMenu = false


rule "Cycle Auto Reset":
    @Event eachPlayer
    @Condition not eventPlayer.Mode
    @Condition eventPlayer.isHoldingButton(Button.MELEE) and eventPlayer.isHoldingButton(Button.CROUCH)
    @Condition not eventPlayer.ExecutingMenu
    
    eventPlayer.ExecutingMenu = true
    eventPlayer.AutoReset += 1
    if eventPlayer.AutoReset == 3:
        eventPlayer.AutoReset = 0
    if not eventPlayer.AutoReset:
        smallMessage(eventPlayer, "Auto Reset - Disabled")
    elif eventPlayer.AutoReset == 1:
        smallMessage(eventPlayer, "Auto Reset - Personal Best")
    elif eventPlayer.AutoReset == 2:
        smallMessage(eventPlayer, "Auto Reset - Record")
    waitUntil(not eventPlayer.isHoldingButton(Button.MELEE), 9999)
    eventPlayer.ExecutingMenu = false


rule "Auto Reset (Personal Best)":
    @Event eachPlayer
    @Condition not eventPlayer.Mode
    @Condition eventPlayer.AutoReset == 1
    @Condition eventPlayer.TimeCurrent > (eventPlayer.TimeBestStan if not eventPlayer.Category else eventPlayer.TimeBestGrav)
    
    smallMessage(eventPlayer, "Reset by 'Auto Reset'")
    async(Respawn, AsyncBehavior.NOOP)


rule "Auto Reset (Record)":
    @Event eachPlayer
    @Condition not eventPlayer.Mode
    @Condition eventPlayer.AutoReset == 2
    @Condition eventPlayer.TimeCurrent > (TimeFirstStan if not eventPlayer.Category else TimeFirstGrav)
    
    smallMessage(eventPlayer, "Reset by 'Auto Reset'")
    async(Respawn, AsyncBehavior.NOOP)


rule "Cycle Category":
    @Event eachPlayer
    @Condition not eventPlayer.Mode
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2) and eventPlayer.isHoldingButton(Button.CROUCH)
    @Condition not eventPlayer.ExecutingMenu

    eventPlayer.ExecutingMenu = true
    eventPlayer.Category += 1
    if eventPlayer.Category > 1:
        eventPlayer.Category = 0
    if eventPlayer.Category == 0:
        eventPlayer.setMoveSpeed(100)
        eventPlayer.setGravity(100)
        smallMessage(eventPlayer, "Now playing Standard")
    elif eventPlayer.Category == 1:
        eventPlayer.setMoveSpeed(125)
        eventPlayer.setGravity(80)
        smallMessage(eventPlayer, "Now playing Gravspeed")
    async(Respawn(), AsyncBehavior.NOOP)
    wait(0.2, Wait.IGNORE_CONDITION)
    eventPlayer.allowButton(Button.JUMP)
    waitUntil(not eventPlayer.isHoldingButton(Button.ABILITY_2), 9999)
    eventPlayer.ExecutingMenu = false


rule "Enable Practice Mode":
    @Event eachPlayer
    @Condition not eventPlayer.Mode
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) and not eventPlayer.isHoldingButton(Button.CROUCH)
    @Condition not eventPlayer.ExecutingMenu
    
    eventPlayer.ExecutingMenu = true
    stopChasingVariable(eventPlayer.TimeCurrent)
    eventPlayer.TimeCurrent = 0
    eventPlayer.Attempts = 0
    eventPlayer.Mode = 1
    bigMessage(eventPlayer, "Entering Practice Mode")
    eventPlayer.setInvisibility(Invis.ALL)
    waitUntil(not eventPlayer.isHoldingButton(Button.INTERACT), 9999)
    eventPlayer.ExecutingMenu = false


rule "Enable Fire status":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 1
    
    eventPlayer.setStatusEffect(null, Status.BURNING, 9999)
    eventPlayer.setStatusEffect(null, Status.INVINCIBLE, 9999)


rule "Disable Practice Mode":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 1
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) and not eventPlayer.isHoldingButton(Button.CROUCH)
    @Condition not eventPlayer.ExecutingMenu
    
    eventPlayer.ExecutingMenu = true
    if (eventPlayer.PracticeCheckpoint):
        destroyIcon(getLastCreatedEntity())
        eventPlayer.PracticeCheckpoint = false
    eventPlayer.Mode = 99
    bigMessage(eventPlayer, "Leaving Practice Mode")
    async(Respawn, AsyncBehavior.NOOP)
    waitUntil(not eventPlayer.isHoldingButton(Button.INTERACT), 9999)
    eventPlayer.ExecutingMenu = false


rule "Disable Fire status":
    @Event eachPlayer
    @Condition eventPlayer.Mode != 1
    
    eventPlayer.clearStatusEffect(Status.BURNING)
    eventPlayer.clearStatusEffect(Status.INVINCIBLE)


rule "Set Practice Checkpoint":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 1
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE)
    
    eventPlayer.PosPracticeCheckpoint = eventPlayer.getPosition()
    eventPlayer.FacingPracticeCheckpoint = eventPlayer.getFacingDirection()
    eventPlayer.VelocityPracticeCheckpoint = eventPlayer.getVelocity()
    eventPlayer.SpeedPracticeCheckpoint = eventPlayer.getSpeed()
    if (not eventPlayer.PracticeCheckpoint):
        eventPlayer.PracticeCheckpoint = true
        createIcon(eventPlayer, eventPlayer.PosPracticeCheckpoint, Icon.FLAG, IconReeval.POSITION, Color.GREEN, true)
    smallMessage(eventPlayer, l"{0} {1}".format(l"Checkpoint", l"Saved"))


rule "Delete Practice Checkpoint":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 1
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2)

    if (eventPlayer.PracticeCheckpoint):
        eventPlayer.PracticeCheckpoint = false
        destroyIcon(getLastCreatedEntity())
        smallMessage(eventPlayer, "{0} {1}".format(l"Checkpoint", l"Destroyed"))


rule "Ult Reset Checkpoint":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 1
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    
    async(Respawn, AsyncBehavior.NOOP)


rule "Enable Player Spectator Mode":
    @Event eachPlayer
    @Condition not eventPlayer.Mode
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2) and not eventPlayer.isHoldingButton(Button.CROUCH)
    @Condition not eventPlayer.ExecutingMenu
    
    eventPlayer.ExecutingMenu = true
    eventPlayer.Mode = 2
    stopChasingVariable(eventPlayer.TimeCurrent)
    eventPlayer.TimeCurrent = 0
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


rule "Enable Spectator Mode":
    @Event eachPlayer
    @Condition not eventPlayer.Mode
    @Condition eventPlayer.isHoldingButton(Button.RELOAD) and not eventPlayer.isHoldingButton(Button.CROUCH)
    @Condition not eventPlayer.ExecutingMenu
    
    eventPlayer.ExecutingMenu = true
    eventPlayer.Mode = 3
    eventPlayer.setGravity(0)
    if not eventPlayer.Category:
        eventPlayer.setMoveSpeed(225)
    elif eventPlayer.Category == 1:
        eventPlayer.setMoveSpeed(275)
    eventPlayer.setInvisibility(Invis.ALL)
    stopChasingVariable(eventPlayer.TimeCurrent)
    eventPlayer.TimeCurrent = 0
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
    if not eventPlayer.Category:
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


rule "Circle Fix":
    @Event eachPlayer
    @Condition distance(PosStart, vect(updateEveryTick(eventPlayer.getPosition()).x, PosStart.y, updateEveryTick(eventPlayer.getPosition()).z)) <= 2
    @Condition abs(updateEveryTick(eventPlayer.getPosition()).y - PosStart.y) <= 3
    @Condition updateEveryTick(eventPlayer.isOnGround())
    @Condition not eventPlayer.Reset
    @Condition eventPlayer.Mode <= 1
    @Condition not eventPlayer.PracticeCheckpoint
    @Condition not any([checkpoint for checkpoint in eventPlayer.Checkpoint])
    @Condition (not eventPlayer.Category and updateEveryTick(eventPlayer.getHorizontalSpeed()) <= 6.88) or (eventPlayer.Category == 1 and updateEveryTick(eventPlayer.getHorizontalSpeed()) <= 8.6)
    
    stopChasingVariable(eventPlayer.TimeCurrent)
    eventPlayer.TimeCurrent = 0
    eventPlayer.setInvisibility(Invis.ALL)
    wait(0.05)
    eventPlayer.allowButton(Button.JUMP)


rule "Match Time Frozen":
    @Condition isGameInProgress()
    @Condition Infinite
    @Condition getMatchTime() < 10
    
    wait()
    setMatchTime(Time + 10)


rule "End Match FFA":
    @Condition getCurrentGamemode() == Gamemode.FFA
    @Condition isGameInProgress()
    @Condition getMatchTime() == 0

    restartMatch()


def Respawn():
    @Name "Respawn"
    
    if eventPlayer.Mode <= 1:
        if eventPlayer.PracticeCheckpoint:
            eventPlayer.Attempts += 1
            eventPlayer.teleport(eventPlayer.PosPracticeCheckpoint)
            eventPlayer.setFacing(eventPlayer.FacingPracticeCheckpoint, Relativity.TO_WORLD)
            eventPlayer.applyImpulse(eventPlayer.getVelocity() * -0.001, 0.001, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
            if eventPlayer.VelocityPracticeCheckpoint:
                eventPlayer.applyImpulse(eventPlayer.VelocityPracticeCheckpoint, eventPlayer.SpeedPracticeCheckpoint, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
                return
            eventPlayer.applyImpulse(eventPlayer.getVelocity() * 0.001, 0.001, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
            eventPlayer.setStatusEffect(null, Status.ROOTED, 0.5)
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
    waitUntil(distance(eventPlayer.getPosition(), PosStart) < 1, 0.4)
    eventPlayer.Finished = false
    for eventPlayer.CheckpointLoop in range(0, len(eventPlayer.Checkpoint)):
        eventPlayer.Checkpoint[eventPlayer.CheckpointLoop] = false
    if eventPlayer.Mode > 1:
        eventPlayer.Attempts = 0
        eventPlayer.Mode = 0
        if not eventPlayer.Category:
            eventPlayer.setGravity(100)
            eventPlayer.setMoveSpeed(100)
        elif eventPlayer.Category == 1:
            eventPlayer.setGravity(80)
            eventPlayer.setMoveSpeed(125)

