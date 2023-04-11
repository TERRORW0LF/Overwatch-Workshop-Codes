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
globalvar MapName 24


#Player variables

playervar TimeCurrent 0
playervar TimeExtra 1
playervar TimeBestGrav 2
playervar TimeBestStan 3
playervar NewBest 4
playervar Checkpoint 5
playervar Finished 6
playervar Category 7
playervar AutoReset 8
playervar HideHud 9
playervar Mode 10
playervar Attempts 11
playervar SpeedColor 12
playervar ExecutingMenu 13
playervar Speed 14
playervar CurrCheckpoint 15
playervar CheckpointLoop 16
playervar Reset 17
playervar FFAReset 18
playervar PracticeCheckpoint 22
playervar PosPracticeCheckpoint 23
playervar FacingPracticeCheckpoint 24
playervar VelocityPracticeCheckpoint 25
playervar SpeedPracticeCheckpoint 26
playervar PosNow 30
playervar PosPrev 31
playervar SpeedNow 32
playervar SpeedPrev 33
playervar PosNorm 34
playervar Angle 35
playervar TimeExtra2 36


#Subroutine names

subroutine Respawn 0


#Debug
rule "Debug (Global)":
    @Disabled


rule "Debug (Player)":
    @Disabled
    @Event eachPlayer

    hudHeader(eventPlayer, "{0}".format(eventPlayer.getPosition()), HudPosition.TOP, 4, Color.WHITE, HudReeval.STRING)
    hudHeader(eventPlayer, "{0}.{1} sec".format(floor(eventPlayer.TimeExtra + 0.001 / 10), "{0}".format(round((1000 * eventPlayer.TimeExtra) % 1000 + 1000)).substring(1, 3)), HudPosition.TOP, 5, Color.WHITE, HudReeval.STRING, SpecVisibility.DEFAULT)


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
    if getCurrentMap() == Map.BLIZZ_WORLD:
        PosStart = vect(3, -0.1, 21.5)
        PosFinish = vect(-122.14, -0.5, 110.64)
        MapName = "BW"
        return
    if getCurrentMap() == Map.BUSAN:
        #Downtown
        if getCurrentObjective() == 0:
            PosStart = vect(101.64, 15.93, -126.23)
            PosFinish = vect(-3.5, 15.8, -125)
            MapName = "BD"
            return
        #MEKA Base
        if getCurrentObjective() == 2:
            PosStart = vect(165, 10.1, 255)
            PosFinish = vect(275.5, 10, 210.5)
            MapName = "BM"
            return
        #Sanctuary
        if getCurrentObjective() == 1:
            PosStart = vect(-255.5, 9.36, 147)
            PosFinish = vect(-397, 9.1, 171)
            MapName = "BS"
            return
    if getCurrentMap() == Map.CHATEAU_GUILLARD:
        PosStart = vect(176.515, 0, 52.458)
        PosFinish = vect(233.22, 3.9, 110.969)
        PosBarrier = [vect(175, -5, 51.64), vect(177.29, -5, 49.88)]
        MapName = "CG"
        return
    if getCurrentMap() == Map.CIRCUIT_ROYAL:
        PosStart = vect(-78.48, 4.21, -78.5)
        PosFinish = vect(108.7, 10.9, 11.81)
        MapName = "CR"
        return
    if getCurrentMap() == Map.COLOSSEO:
        PosStart = vect(-89.44, 9, -25.68)
        PosFinish = vect(99, 8.9, -13)
        MapName = "CS"
        return
    if getCurrentMap() == Map.DORADO:
        PosStart = vect(12.5, 0, 6)
        PosFinish = vect(184.19, 13.7, 40.32)
        MapName = "DR"
        return
    if getCurrentMap() == Map.EICHENWALDE:
        PosStart = vect(2, 6, 0.5)
        PosFinish = vect(123.63, 8.62, -27.05)
        MapName = "EW"
        return
    if getCurrentMap() == Map.ESPERANCA:
        PosStart = vect(-109.68, -1, -56.06)
        PosFinish = vect(94.7, -1.1, -84.88)
        MapName = "ER"
        return
    if getCurrentMap() == Map.HANAMURA:
        PosStart = vect(57, -1.87, 33.65)
        PosFinish = vect(-10.57, -1.02, -84.71)
        MapName = "HM"
        return
    if getCurrentMap() == Map.HAVANA:
        PosStart = vect(-95.37, 4, -93.5)
        PosFinish = vect(140.14, 5.9, -46.38)
        MapName = "HV"
        return
    if getCurrentMap() == Map.HOLLYWOOD:
        PosStart = vect(-52, -0.25, 12.5)
        PosFinish = vect(-35.08, 1.65, -134.97)
        MapName = "HW"
        return
    if getCurrentMap() == Map.HORIZON_LUNAR_COLONY:
        PosStart = vect(19, 13, -45.5)
        PosFinish = vect(-24.74, 2.5, -121)
        MapName = "HC"
        return
    if getCurrentMap() == Map.ILIOS_LIGHTHOUSE:
        PosStart = vect(329, -25.6, 22)
        PosFinish = vect(290, -25.74, -89)
        MapName = "IL"
        return
    if getCurrentMap() == Map.ILIOS_RUINS:
        PosStart = vect(112, 65.39, -178)
        PosFinish = vect(-58.5, 60.3, -150)
        MapName = "IR"
        return
    if getCurrentMap() == Map.ILIOS_WELL:
        PosStart = vect(-157, -5.06, -77.36)
        PosFinish = vect(-264.5, -5.2, 29.5)
        MapName = "IW"
        return
    if getCurrentMap() == Map.JUNKERTOWN:
        PosStart = vect(-47.67, 9.5, -49.62)
        PosFinish = vect(-92.82, 5.28, -119.06)
        MapName = "JT"
        return
    if getCurrentMap() == Map.KANEZAKA:
        PosStart = vect(-14.495, 6, 42.699)
        PosFinish = vect(-39.953, 7.9, -54.264)
        MapName = "KZ"
        return
    if getCurrentMap() == Map.KINGS_ROW:
        PosStart = vect(-12, -0.12, 12.5)
        PosFinish = vect(-149.09, -3.1, 24.25)
        MapName = "KR"
        return
    if getCurrentMap() == Map.LIJIANG_CONTROL_CENTER:
        PosStart = vect(44, 265, 327)
        PosFinish = vect(-35.5, 266.9, 316.75)
        MapName = "LC"
        return
    if getCurrentMap() == Map.LIJIANG_GARDEN:
        PosStart = vect(64.5, 94, 145.5)
        PosFinish = vect(-61, 93.9, 148)
        MapName = "LG"
        return
    if getCurrentMap() == Map.LIJIANG_NIGHT_MARKET:
        PosStart = vect(61, 2, -34)
        PosFinish = vect(-54.25, 5.9, -11.75)
        MapName = "LM"
        return
    if getCurrentMap() == Map.MALEVENTO:
        PosStart = vect(22.672, 2, -25.413)
        PosFinish = vect(-0.175, 2.4, 46.063)
        MapName = "MV"
        return
    if getCurrentMap() == Map.MIDTOWN:
        PosStart = vect(41.22, 3.98, 126.22)
        PosFinish = vect(128.32, 0.8, -65.74)
        MapName = "MT"
        return
    if getCurrentMap() == Map.NEPAL_SANCTUM:
        PosStart = vect(81, 131.8, 36)
        PosFinish = vect(81, 131.7, -35.5)
        MapName = "NS"
        return
    if getCurrentMap() == Map.NEPAL_SHRINE:
        PosStart = vect(-38.5, 14.88, 60)
        PosFinish = vect(-49, 14.9, -74)
        MapName = "NE"
        return
    if getCurrentMap() == Map.NEPAL_VILLAGE:
        PosStart = vect(-191, -98.23, 60)
        PosFinish = vect(-176.5, -99.5, -71)
        MapName = "NV"
        return
    if getCurrentMap() == Map.NEW_QUEEN_STREET:
        PosStart = vect(77.5, 8, -55.34)
        PosFinish = vect(-79, 7.9, 4.4)
        MapName = "NQ"
        return
    /*if getCurrentMap() == Map.NUMBANI:
        PosStart = vect(18, 0.08, 13)
        PosFinish = vect(206.99, -2.29, 22.14)
        MapName = "NB"
        return*/
    if getCurrentMap() == Map.OASIS_CITY_CENTER:
        PosStart = vect(100, 1, 311)
        PosFinish = vect(195, 0.75, 200)
        MapName = "OC"
        return
    if getCurrentMap() == Map.OASIS_GARDENS:
        PosStart = vect(181, 8, -220.3)
        PosFinish = vect(103, 7.9, -285.5)
        MapName = "OG"
        return
    if getCurrentMap() == Map.OASIS_UNIVERSITY:
        PosStart = vect(-188, 18, 50.5)
        PosFinish = vect(-188.25, 17.9, -58)
        MapName = "OU"
        return
    if getCurrentMap() == Map.PARAISO:
        PosStart = vect(-48, -2.91, 77)
        PosFinish = vect(-37.25, 0.9, -143.14)
        MapName = "PI"
        return
    if getCurrentMap() == Map.PARIS:
        PosStart = vect(-14.4, 14, -35.75)
        PosFinish = vect(-104, 14.5, -100)
        MapName = "PR"
        return
    if getCurrentMap() == Map.PETRA:
        PosStart = vect(39.378, -10.12, 36.503)
        PosFinish = vect(-38.385, -12, -15.7)
        MapName = "PT"
        return
    if getCurrentMap() == Map.RIALTO:
        PosStart = vect(107, -1.25, -16)
        PosFinish = vect(-57, 2.5, -131.67)
        MapName = "RT"
        return
    if getCurrentMap() == Map.ROUTE66:
        PosStart = vect(38.5, 5.5, 36.5)
        PosFinish = vect(-92.49, 6.4, -23.25)
        MapName = "R6"
        return
    if getCurrentMap() == Map.SHAMBALI_MONASTERY:
        PosStart = vect(20.75, 9, -14.83)
        PosFinish = vect(-22.46, 30.15, 202.14)
        MapName = "SM"
    if getCurrentMap() == Map.TEMPLE_OF_ANUBIS:
        PosStart = vect(-1, -2.32, -9)
        PosFinish = vect(-7.5, 4.57, 111.3)
        MapName = "TA"
        return
    if getCurrentMap() == Map.VOLSKAYA:
        PosStart = vect(15.74, -4.64, 22.19)
        PosFinish = vect(-94.24, -2.08, 49.3)
        MapName = "VS"
        return
    if getCurrentMap() == Map.WATCHPOINT_GIBRALTAR:
        PosStart = vect(39, 4, -124.5)
        PosFinish = vect(82.46, -1, 39.99)
        MapName = "WG"
        return


rule "Start - Maps (Season 2)":
    @Condition Season == 1
    
    Checkpoint = false
    if getCurrentMap() == Map.BLIZZ_WORLD:
        PosStart = vect(-121.57, -0.4, 116.2)
        PosFinish = vect(3, -0.2, 21.5)
        MapName = "BW"
        return
    if getCurrentMap() == Map.BUSAN:
        #Downtown
        if getCurrentObjective() == 0:
            PosStart = vect(-1.544, 15.93, -128.594)
            PosFinish = vect(99, 14.5, -125.5)
            MapName = "BD"
            return
        #MEKA Base
        if getCurrentObjective() == 2:
            PosStart = vect(275.5, 10.1, 210.5)
            PosFinish = vect(165, 10, 255)
            MapName = "BM"
            return
        #Sanctuary
        if getCurrentObjective() == 1:
            PosStart = vect(-391.367, 9.36, 168.276)
            PosFinish = vect(-255.5, 9.26, 147)
            MapName = "BS"
            return
    if getCurrentMap() == Map.CHATEAU_GUILLARD:
        PosStart = vect(236.155, 4, 102.912)
        PosFinish = vect(176.515, -1, 52.458)
        MapName = "CG"
        return
    if getCurrentMap() == Map.CIRCUIT_ROYAL:
        PosStart = vect(108.96, 10.96, 11.66)
        PosFinish = vect(-72.29, 3.9, -72.73)
        MapName = "CR"
        return
    if getCurrentMap() == Map.COLOSSEO:
        PosStart = vect(95.53, 9, -14.64)
        PosFinish = vect(-87.73, 8.9, -32.18)
        MapName = "CS"
        return
    if getCurrentMap() == Map.DORADO:
        PosStart = vect(192.23, 14.1, 37.31)
        PosFinish = vect(12.5, -0.3, 6)
        MapName = "DR"
        return
    if getCurrentMap() == Map.EICHENWALDE:
        PosStart = vect(126.088, 14.76, -17.073)
        PosFinish = vect(2, 5.9, 0.5)
        MapName = "EW"
        return
    if getCurrentMap() == Map.ESPERANCA:
        PosStart = vect(92.82, -1, -85.71)
        PosFinish = vect(-106.63, -1.1, -58.81)
        MapName = "ER"
        return
    if getCurrentMap() == Map.HANAMURA:
        PosStart = vect(-6.786, -0.92, -84.457)
        PosFinish = vect(58, -2.1, 34)
        MapName = "HM"
        return
    if getCurrentMap() == Map.HAVANA:
        PosStart = vect(138.376, 6, -34.025)
        PosFinish = vect(-98, 3.9, -93)
        MapName = "HV"
        return
    if getCurrentMap() == Map.HOLLYWOOD:
        PosStart = vect(-31.19, 1.75, -138.17)
        PosFinish = vect(-52, -0.5, 12.5)
        MapName = "HW"
        return
    if getCurrentMap() == Map.HORIZON_LUNAR_COLONY:
        PosStart = vect(-19.673, 2.75, -120.219)
        PosFinish = vect(19, 6.9, -45.5)
        MapName = "HC"
        return
    if getCurrentMap() == Map.ILIOS_LIGHTHOUSE:
        PosStart = vect(288.533, -25.57, -100.389)
        PosFinish = vect(329, -25.7, 22)
        MapName = "IL"
        return
    if getCurrentMap() == Map.ILIOS_RUINS:
        PosStart = vect(-58.5, 60.58, -150)
        PosFinish = vect(112, 60.3, -178)
        MapName = "IR"
        return
    if getCurrentMap() == Map.ILIOS_WELL:
        PosStart = vect(-264.5, -5.1, 29.5)
        PosFinish = vect(-159, -5.2, -75.5)
        MapName = "IW"
        return
    if getCurrentMap() == Map.JUNKERTOWN:
        PosStart = vect(-88.12, 6.44, -107.5)
        PosFinish = vect(-46.5, 9.4, -47.5)
        MapName = "JT"
        return
    if getCurrentMap() == Map.KANEZAKA:
        PosStart = vect(-37.609, 8, -51.548)
        PosFinish = vect(-13.4, 5.7, 41.9)
        MapName = "KZ"
        return
    if getCurrentMap() == Map.KINGS_ROW:
        PosStart = vect(-157.049, 0.07, 38.51)
        PosFinish = vect(-12, -0.2, 12.5)
        MapName = "KR"
        return
    if getCurrentMap() == Map.LIJIANG_CONTROL_CENTER:
        PosStart = vect(-35.5, 267, 316.75)
        PosFinish = vect(44, 264.9, 327)
        MapName = "LC"
        return
    if getCurrentMap() == Map.LIJIANG_GARDEN:
        PosStart = vect(-65.211, 94, 145.476)
        PosFinish = vect(64.5, 93.9, 145.5)
        MapName = "LG"
        return
    if getCurrentMap() == Map.LIJIANG_NIGHT_MARKET:
        PosStart = vect(-56.087, 1.86, -35.084)
        PosFinish = vect(61, 1.8, -34)
        MapName = "LM"
        return
    if getCurrentMap() == Map.MALEVENTO:
        PosStart = vect(0.164, 2.67, 42.701)
        PosFinish = vect(22.672, 1.9, -25.413)
        MapName = "MV"
        return
    if getCurrentMap() == Map.MIDTOWN:
        PosStart = vect(126.07, 1.09, -76.23)
        PosFinish = vect(40.22, 3.9, 123.15)
        MapName = "MT"
        return
    if getCurrentMap() == Map.NEPAL_SANCTUM:
        PosStart = vect(81, 131.8, -35.5)
        PosFinish = vect(81, 131.7, 36)
        MapName = "NS"
        return
    if getCurrentMap() == Map.NEPAL_SHRINE:
        PosStart = vect(-70.647, 15.7, -64.165)
        PosFinish = vect(-38.5, 13.6, 60)
        MapName = "NE"
        return
    if getCurrentMap() == Map.NEPAL_VILLAGE:
        PosStart = vect(-182, -99.08, -74.5)
        PosFinish = vect(-191, -98.7, 60)
        MapName = "NV"
        return
    if getCurrentMap() == Map.NEW_QUEEN_STREET:
        PosStart = vect(-82.67, 8.21, 3.75)
        PosFinish = vect(76.21, 7.9, -46.4)
        MapName = "NQ"
        return
    /*if getCurrentMap() == Map.NUMBANI:
        PosStart = vect(199.54, 4.2, 37.77)
        PosFinish = vect(18, -0.3, 13)
        MapName = "NB"
        return*/
    if getCurrentMap() == Map.OASIS_CITY_CENTER:
        PosStart = vect(211.712, 1, 203.561)
        PosFinish = vect(101, 0.75, 309.5)
        MapName = "OC"
        return
    if getCurrentMap() == Map.OASIS_GARDENS:
        PosStart = vect(102.21, 8, -272.96)
        PosFinish = vect(182, 7.4, -223.5)
        MapName = "OG"
        return
    if getCurrentMap() == Map.OASIS_UNIVERSITY:
        PosStart = vect(-190, 19.07, -67.81)
        PosFinish = vect(-188, 16.9, 50.5)
        MapName = "OU"
        return
    if getCurrentMap() == Map.PARAISO:
        PosStart = vect(-48.76, 2.75, -140.07)
        PosFinish = vect(-63.31, -2.2, 69.42)
        MapName = "PI"
        return
    if getCurrentMap() == Map.PARIS:
        PosStart = vect(-87.011, 13, -104.458)
        PosFinish = vect(-14.4, 13.9, -35.75)
        MapName = "PR"
        return
    if getCurrentMap() == Map.PETRA:
        PosStart = vect(-38.385, -10.5, -15.7)
        PosFinish = vect(39.378, -11, 36.503)
        MapName = "PT"
        return
    if getCurrentMap() == Map.RIALTO:
        PosStart = vect(-65.683, 4.75, -144.738)
        PosFinish = vect(106.5, -1.5, -15.5)
        MapName = "RT"
        return
    if getCurrentMap() == Map.ROUTE66:
        PosStart = vect(-89.63, 6.5, -29.58)
        PosFinish = vect(38.5, 4.6, 36.5)
        MapName = "R6"
        return
    if getCurrentMap() == Map.SHAMBALI_MONASTERY:
        PosStart = vect(-24, 30.65, 200.22)
        PosFinish = vect(16, 7.9, -10)
        MapName = "SM"
    if getCurrentMap() == Map.TEMPLE_OF_ANUBIS:
        PosStart = vect(-11.096, 4.66, 110.46)
        PosFinish = vect(-1, -2.8, -9)
        MapName = "TA"
        return
    if getCurrentMap() == Map.VOLSKAYA:
        PosStart = vect(-92.538, 2.02, 59.543)
        PosFinish = vect(18, -5.1, 23)
        MapName = "VS"
        return
    if getCurrentMap() == Map.WATCHPOINT_GIBRALTAR:
        PosStart = vect(65.23, 1, 46.5)
        PosFinish = vect(39, 3.9, -124.5)
        MapName = "WG"
        return


rule "Start - Maps (Season 3)":
    @Condition Season == 2
    
    Checkpoint = true
    if getCurrentMap() == Map.BLIZZ_WORLD:
        PosStart = vect(23.31, 2, 79.2)
        PosCheckpoint = [vect(-72.57, 6.5, 105.2)]
        PosFinish = vect(-8, -1.1, 103.66)
        MapName = "BW"
        return
    if getCurrentMap() == Map.BUSAN:
        #Downtown
        if getCurrentObjective() == 0:
            PosStart = vect(51.9, 21.4, -129)
            PosCheckpoint = [vect(51.9, 4.78, -74)]
            PosFinish = vect(51.9, 10.9, -147.9)
            MapName = "BD"
            return
        #MEKA Base
        if getCurrentObjective() == 2:
            PosStart = vect(210, 9.1, 212)
            PosCheckpoint = [vect(205.5, 9, 202)]
            PosFinish = vect(226, 9, 250)
            MapName = "BM"
            return
        #Sanctuary
        if getCurrentObjective() == 1:
            PosStart = vect(-328.5, 8, 180.5)
            PosCheckpoint = [vect(-328.5, 9.72, 107.4)]
            PosFinish = vect(-328.5, 9, 195)
            MapName = "BS"
            return
    if getCurrentMap() == Map.CHATEAU_GUILLARD:
        PosStart = vect(191.7, 9, 111.2)
        PosCheckpoint = [vect(229.8, -1.5, 52.88)]
        PosFinish = vect(180.24, 8.9, 104)
        MapName = "CG"
        return
    if getCurrentMap() == Map.CIRCUIT_ROYAL:
        PosStart = vect(-19.88, 11, -60)
        PosCheckpoint = [vect(11.1, 9.5, -34.7)]
        PosFinish = vect(79.91, 17.6, 50.08)
        MapName = "CR"
        return
    if getCurrentMap() == Map.COLOSSEO:
        PosStart = vect(44.5, 4, -40.35)
        PosCheckpoint = [vect(0, -0.1, 10)]
        PosFinish = vect(-68.7, 4, -57.8)
        MapName = "CS"
        return
    if getCurrentMap() == Map.DORADO:
        PosStart = vect(167.15, 18.01, 68)
        PosCheckpoint = [vect(68, 16.9, 40)]
        PosFinish = vect(125, 6.9, -18)
        MapName = "DR"
        return
    if getCurrentMap() == Map.EICHENWALDE:
        PosStart = vect(54.97, 22.68, -104.11)
        PosCheckpoint = [vect(4.93, 4.9, -14.1)]
        PosFinish = vect(64.74, 15.5, -61.86)
        MapName = "EW"
        return
    if getCurrentMap() == Map.ESPERANCA:
        PosStart = vect(-39.86, -2, -26.51)
        PosCheckpoint = [vect(12.23, -6.1, -75.73)]
        PosFinish = vect(106, -1.1, -58.6)
        MapName = "ER"
        return
    if getCurrentMap() == Map.HANAMURA:
        PosStart = vect(55.024, -1.92, 41.766)
        PosCheckpoint = [vect(76.329, -3.55, 97.421)]
        PosFinish = vect(91.752, -2.1, 17.33)
        MapName = "HM"
        return
    if getCurrentMap() == Map.HAVANA:
        PosStart = vect(100.75, 2.14, -83.53)
        PosCheckpoint = [vect(6, 5.7, -75)]
        PosFinish = vect(42.47, 5.9, -47)
        MapName = "HV"
        return
    if getCurrentMap() == Map.HOLLYWOOD:
        PosStart = vect(-29.04, 13.86, -12.75)
        PosCheckpoint = [vect(19.77, 4.8, 59.12)]
        PosFinish = vect(-42.39, -0.25, 54.98)
        MapName = "HW"
        return
    if getCurrentMap() == Map.HORIZON_LUNAR_COLONY:
        PosStart = vect(20.101, 6, -107.386)
        PosCheckpoint = [vect(94.12, 10.4, -56.787)]
        PosFinish = vect(47.863, 5.9, -37.389)
        MapName = "HC"
        return
    if getCurrentMap() == Map.ILIOS_LIGHTHOUSE:
        PosStart = vect(319.790, -23.670, -35.640)
        PosCheckpoint = [vect(365, -25.73, -54.5)]
        PosFinish = vect(307.8, -22.1, 31.4)
        MapName = "IL"
        return
    if getCurrentMap() == Map.ILIOS_RUINS:
        PosStart = vect(28.5, 57.37, -141.5)
        PosCheckpoint = [vect(-55, 65, -178)]
        PosFinish = vect(11.9, 66.2, -144.2)
        MapName = "IR"
        return
    if getCurrentMap() == Map.ILIOS_WELL:
        PosStart = vect(-195, 1, -3)
        PosCheckpoint = [vect(-284, -0.55, 10)]
        PosFinish = vect(-271.9, -1.4, 53.5)
        MapName = "IW"
        return
    if getCurrentMap() == Map.JUNKERTOWN:
        PosStart = vect(32.55, 15.2, -89.45)
        PosCheckpoint = [vect(-18, 6.4, -90)]
        PosFinish = vect(-46.5, 9.4, -47.5)
        MapName = "JT"
        return
    if getCurrentMap() == Map.KANEZAKA:
        PosStart = vect(-58.95, 11, -38)
        PosCheckpoint = [vect(-4.6, 5.8, 17.77)]
        PosFinish = vect(-59.5, 10.9, -16)
        MapName = "KZ"
        return
    if getCurrentMap() == Map.KINGS_ROW:
        PosStart = vect(14.73, 6, 18.19)
        PosCheckpoint = [vect(-60, -0.2, -47.5)]
        PosFinish = vect(-98.35, 0.6, -6.78)
        MapName = "KR"
        return
    if getCurrentMap() == Map.LIJIANG_CONTROL_CENTER:
        PosStart = vect(0, 278.12, 295)
        PosCheckpoint = [vect(0, 274, 330)]
        PosFinish = vect(0, 269.9, 254)
        MapName = "LC"
        return
    if getCurrentMap() == Map.LIJIANG_GARDEN:
        PosStart = vect(-65, 94, 145)
        PosCheckpoint = [vect(0, 94.9, 125)]
        PosFinish = vect(52, 90, 182)
        MapName = "LG"
        return
    if getCurrentMap() == Map.LIJIANG_NIGHT_MARKET:
        PosStart = vect(1, -0.920, -75.370)
        PosCheckpoint = [vect(49, 1.76, -47)]
        PosFinish = vect(1, -0.1, -10)
        MapName = "LM"
        return
    if getCurrentMap() == Map.MALEVENTO:
        PosStart = vect(35.8, 6, 36.15)
        PosCheckpoint = [vect(-27, -2.1, 8.5)]
        PosFinish = vect(27, 1.9, -28)
        MapName = "MV"
        return
    if getCurrentMap() == Map.MIDTOWN:
        PosStart = vect(47.73, 3.84, -41.25)
        PosCheckpoint = [vect(-30.54, 3.9, 45.31)]
        PosFinish = vect(-16.41, 3.9, 98.35)
        MapName = "MT"
        return
    if getCurrentMap() == Map.NEPAL_SANCTUM:
        PosStart = vect(78, 129.8, -59)
        PosCheckpoint = [vect(81, 127.9, 8)]
        PosFinish = vect(102, 131.9, 78)
        MapName = "NS"
        return
    if getCurrentMap() == Map.NEPAL_SHRINE:
        PosStart = vect(-26, 10.62, -34)
        PosCheckpoint = [vect(-63, 12.9, 0)]
        PosFinish = vect(-24, 14.9, 82)
        MapName = "NE"
        return
    if getCurrentMap() == Map.NEPAL_VILLAGE:
        PosStart = vect(-164.03, -89.3, 5.14)
        PosCheckpoint = [vect(-220, -94.1, 0)]
        PosFinish = vect(-207, -87.1, -44)
        MapName = "NV"
        return
    if getCurrentMap() == Map.NEW_QUEEN_STREET:
        PosStart = vect(-59.69, 8.02, -1.29)
        PosCheckpoint = [vect(0, 1.9, -42.2)]
        PosFinish = vect(66.14, 7.9, 9.89)
        MapName = "NQ"
        return
    /*if getCurrentMap() == Map.NUMBANI:
        PosStart = vect(87.83, 4.25, -23.57)
        PosCheckpoint = [vect(129.52, -3.85, 38.61)]
        PosFinish = vect(204.25, -2.25, 22.61)
        MapName = "NB"
        return*/
    if getCurrentMap() == Map.OASIS_CITY_CENTER:
        PosStart = vect(166, 4, 270)
        PosCheckpoint = [vect(102, -2, 288)]
        PosFinish = vect(119, 0.5, 223)
        MapName = "OC"
        return
    if getCurrentMap() == Map.OASIS_GARDENS:
        PosStart = vect(172.57, 7.45, -170.32)
        PosCheckpoint = [vect(141.33, 7.3, -247.33)]
        PosFinish = vect(101.5, -1, -207.5)
        MapName = "OG"
        return
    if getCurrentMap() == Map.OASIS_UNIVERSITY:
        PosStart = vect(-198, 9, 0)
        PosCheckpoint = [vect(-220, 18.9, 0)]
        PosFinish = vect(-175, 15.9, 61.5)
        MapName = "OU"
        return
    if getCurrentMap() == Map.PARAISO:
        PosStart = vect(-7.7, 3.75, 36.99)
        PosCheckpoint = [vect(24.91, 4.8, -110.14)]
        PosFinish = vect(-56.2, -1.1, 28.5)
        MapName = "PI"
        return
    if getCurrentMap() == Map.PARIS:
        PosStart = vect(-77.279, 12.07, -2.75)
        PosCheckpoint = [vect(-43.506, 11, -34.903)]
        PosFinish = vect(-119.113, 9.9, -69.934)
        MapName = "PR"
        return
    if getCurrentMap() == Map.PETRA:
        PosStart = vect(-24.96, -5.24, 57.99)
        PosCheckpoint = [vect(21, -5.8, -13)]
        PosFinish = vect(26.86, -11.7, 32)
        MapName = "PT"
        return
    if getCurrentMap() == Map.RIALTO:
        PosStart = vect(110.31, -0.25, -34.22)
        PosCheckpoint = [vect(33, 0.55, -36.59)]
        PosFinish = vect(-15, 5.65, -55)
        MapName = "RT"
        return
    if getCurrentMap() == Map.ROUTE66:
        PosStart = vect(37.82, 2.01, 16.71)
        PosCheckpoint = [vect(16, 7.8, -23)]
        PosFinish = vect(51, 0.1, 45)
        MapName = "R6"
        return
    if getCurrentMap() == Map.SHAMBALI_MONASTERY:
        PosStart = vect(25, 14, 63.75)
        PosCheckpoint = [vect(-60, 22.9, 126)]
        PosFinish = vect(12.36, 26.9, 117.14)
        MapName = "SM"
        return
    if getCurrentMap() == Map.TEMPLE_OF_ANUBIS:
        PosStart = vect(-58.89, 6.51, 44.81)
        PosCheckpoint = [vect(16.802, 2.3, 106.979)]
        PosFinish = vect(-36.8, 9, 2.543)
        MapName = "TA"
        return
    if getCurrentMap() == Map.VOLSKAYA:
        PosStart = vect(-32.21, -2.94, 46.15)
        PosCheckpoint = [vect(16.248, -5.1, 25.782)]
        PosFinish = vect(2.417, -8, 107.37)
        MapName = "VS"
        return
    if getCurrentMap() == Map.WATCHPOINT_GIBRALTAR:
        PosStart = vect(5.42, -5, -81.88)
        PosCheckpoint = [vect(89, 2.9, -27)]
        PosFinish = vect(97.362, -6, 38.946)
        MapName = "WP"
        return


rule "Start - Maps (Season 4)":
    @Condition Season == 3
    
    if getCurrentMap() == Map.BLIZZ_WORLD:
        PosStart = vect(52.118, -0.81, -7.795)
        PosCheckpoint = [vect(53.816, -6.5, -87.717)]
        PosFinish = vect(-57.568, -3.9, -5.401)
        Checkpoint = true
        MapName = "BW"
        return
    if getCurrentMap() == Map.BUSAN:
        #Downtown
        if not getCurrentObjective():
            PosStart = vect(88.77, 15, -141.2)
            PosCheckpoint = [vect(22.583, 7.9, -81.736)]
            PosFinish = vect(-12.436, 15.9, -117.693)
            Checkpoint = true
            MapName = "BD"
            return
        #MEKA Base
        if getCurrentObjective() == 2:
            PosStart = vect(163.6, 10.09, 270.97)
            PosFinish = vect(247.878, 13, 199.614)
            Checkpoint = false
            MapName = "BM"
            return
        #Sanctuary
        if getCurrentObjective() == 1:
            PosStart = vect(-284.514, 12.05, 174.822)
            PosCheckpoint = [vect(-382.463, 9, 138.889)]
            PosFinish = vect(-271.677, 9, 137.999)
            Checkpoint = true
            MapName = "BS"
            return
    if getCurrentMap() == Map.CHATEAU_GUILLARD:
        PosStart = vect(207.33, 9, 44.4)
        PosCheckpoint = [vect(161, -1, 117.51)]
        PosFinish = vect(226.5, 11.2, 64.5)
        Checkpoint = true
        MapName = "CG"
        return
    if getCurrentMap() == Map.CIRCUIT_ROYAL:
        PosStart = vect(95.54, 17.96, 47.36)
        PosCheckpoint = [vect(58, 14.9, -7)]
        PosFinish = vect(-77.34, 5.9, -15.69)
        Checkpoint = true
        MapName = "CR"
        return
    if getCurrentMap() == Map.COLOSSEO:
        PosStart = vect(129.83, 9, -64.82)
        PosCheckpoint = [vect(-14.81, 2.9, -38.8)]
        PosFinish = vect(-85.38, -0.1, 17.52)
        Checkpoint = true
        MapName = "CS"
        return
    if getCurrentMap() == Map.DORADO:
        PosStart = vect(62.246, 13.42, 21.758)
        PosCheckpoint = [vect(117.076, 17.9, 5.438)]
        PosFinish = vect(26.047, 3.9, -41.35)
        Checkpoint = true
        MapName = "DR"
        return
    if getCurrentMap() == Map.EICHENWALDE:
        PosStart = vect(2.656, 6, 0.346)
        PosCheckpoint = [vect(31.753, 13.5, -79.386)]
        PosFinish = vect(83.903, 12.6, -87.977)
        Checkpoint = true
        MapName = "EW"
        return
    if getCurrentMap() == Map.ESPERANCA:
        PosStart = vect(109.9, -1, -56)
        PosCheckpoint = [vect(0, -0.3, -3.35)]
        PosFinish = vect(-62.63, -6.1, -82.11)
        Checkpoint = true
        MapName = "ER"
        return
    if getCurrentMap() == Map.HANAMURA:
        PosStart = vect(85.867, -2.02, 16.524)
        PosCheckpoint = [vect(64.123, -3.4, 84.188)]
        PosFinish = vect(30.542, 1.9, 40.845)
        Checkpoint = true
        MapName = "HM"
        return
    if getCurrentMap() == Map.HAVANA:
        PosStart = vect(-107.29, 3.85, -57.71)
        PosFinish = vect(65.054, 10.82, -83.635)
        Checkpoint = false
        MapName = "HV"
        return
    if getCurrentMap() == Map.HOLLYWOOD:
        PosStart = vect(-25.875, 1.75, 21.201)
        PosCheckpoint = [vect(12.661, 1.6, -86.28)]
        PosFinish = vect(-38.232, 8.62, -116.867)
        Checkpoint = true
        MapName = "HW"
        return
    if getCurrentMap() == Map.HORIZON_LUNAR_COLONY:
        PosStart = vect(-38.253, 10, -122.811)
        PosCheckpoint = [vect(43.183, 13.9, -77.129)]
        PosFinish = vect(25.671, 6.9, -15.62)
        Checkpoint = true
        MapName = "HC"
        return
    if getCurrentMap() == Map.ILIOS_LIGHTHOUSE:
        PosStart = vect(284.738, -17.94, -75.819)
        PosCheckpoint = [vect(363.517, -18.4, -53.426)]
        PosFinish = vect(336.947, -25.7, 22.725)
        Checkpoint = true
        MapName = "IL"
        return
    if getCurrentMap() == Map.ILIOS_RUINS:
        PosStart = vect(111.647, 65.39, -177.77)
        PosCheckpoint = [vect(28.446, 61.39, -143.87)]
        PosFinish = vect(-55.178, 65.3, -178.229)
        Checkpoint = true
        MapName = "IR"
        return
    if getCurrentMap() == Map.ILIOS_WELL:
        PosStart = vect(-258.986, -0.5, 48.481)
        PosCheckpoint = [vect(-224.969, 5.3, -33.21)]
        PosFinish = vect(-144.5, -3.5, -83.33)
        Checkpoint = true
        MapName = "IW"
    if getCurrentMap() == Map.JUNKERTOWN:
        PosStart = vect(-49.399, 9.49, -42.145)
        PosCheckpoint = [vect(-46.378, 17.6, -90.257)]
        PosFinish = vect(40.235, 8.7, -51.024)
        Checkpoint = true
        MapName = "JT"
        return
    if getCurrentMap() == Map.KANEZAKA:
        PosStart = vect(13.77, 6, -11.85)
        PosCheckpoint = [vect(-46.3, 5.9, 25.78)]
        PosFinish = vect(-0.83, 7.9, -46.33)
        Checkpoint = true
        MapName = "KZ"
        return
    if getCurrentMap() == Map.KINGS_ROW:
        PosStart = vect(4.5, 6, -4.17)
        PosCheckpoint = [vect(-83.851, 0, 4.438)]
        PosFinish = vect(-118.429, -1.4, 24.984)
        Checkpoint = true
        MapName = "KR"
        return
    if getCurrentMap() == Map.LIJIANG_CONTROL_CENTER:
        PosStart = vect(-26.497, 270, 340.286)
        PosCheckpoint = [vect(10.656, 269.9, 261.943)]
        PosFinish = vect(27.763, 269.9, 355.578)
        Checkpoint = true
        MapName = "LC"
        return
    if getCurrentMap() == Map.LIJIANG_GARDEN:
        PosStart = vect(66.16, 94.4, 159.33)
        PosCheckpoint = [vect(-0.067, 95.9, 107.872)]
        PosFinish = vect(-68.698, 97.9, 163.209)
        Checkpoint = true
        MapName = "LG"
        return
    if getCurrentMap() == Map.LIJIANG_NIGHT_MARKET:
        PosStart = vect(61.03, 6, -10.232)
        PosCheckpoint = [vect(1.479, -1.1, -59.482)]
        PosFinish = vect(-58.911, 5.9, -10.302)
        Checkpoint = true
        MapName = "LM"
        return
    if getCurrentMap() == Map.MALEVENTO:
        PosStart = vect(-19.45, -3, -25.76)
        PosCheckpoint = [vect(0, 2.4, 44.52)]
        PosFinish = vect(27, 1.9, -28)
        Checkpoint = true
        MapName = "MV"
        return
    if getCurrentMap() == Map.MIDTOWN:
        PosStart = vect(132.2, 1.26, -38.57)
        PosCheckpoint = [vect(65.5, 5.5, 27.33)]
        PosFinish = vect(-8.1, 4.8, 27)
        Checkpoint = true
        MapName = "MT"
        return
    if getCurrentMap() == Map.NEPAL_SANCTUM:
        PosStart = vect(107.5, 134, -82.56)
        PosCheckpoint = [vect(55.295, 129.7, 0.52)]
        PosFinish = vect(102.618, 131.7, 78.165)
        Checkpoint = true
        MapName = "NS"
        return
    if getCurrentMap() == Map.NEPAL_SHRINE:
        PosStart = vect(-22.24, 22, 75.23)
        PosFinish = vect(-50.994, 14.9, -77.311)
        Checkpoint = false
        MapName = "NE"
        return
    if getCurrentMap() == Map.NEPAL_VILLAGE:
        PosStart = vect(-168.653, -97.53, -48.431)
        PosCheckpoint = [vect(-221.123, -89.5, 0.323)]
        PosFinish = vect(-147.782, -92.5, 62.105)
        Checkpoint = true
        MapName = "NV"
        return
    if getCurrentMap() == Map.NEW_QUEEN_STREET:
        PosStart = vect(-60.9, 8, -40)
        PosCheckpoint = [vect(0, -0.2, 10.5)]
        PosFinish = vect(76.24, 7.9, -49.12)
        Checkpoint = true
        MapName = "NQ"
        return
    /*if getCurrentMap() == Map.NUMBANI:
        PosStart = vect(144.571, 2.25, 29.313)
        PosCheckpoint = [vect(49.435, 1.6, -6.419)]
        PosFinish = vect(163.628, 4.15, -0.052)
        Checkpoint = true
        MapName = "NB"
        return*/
    if getCurrentMap() == Map.OASIS_CITY_CENTER:
        PosStart = vect(85.57, 1, 297.8)
        PosCheckpoint = [vect(157.26, 3.9, 264.225)]
        PosFinish = vect(157.23, 0.8, 205.119)
        Checkpoint = true
        MapName = "OC"
        return
    if getCurrentMap() == Map.OASIS_GARDENS:
        PosStart = vect(73.282, 7.5, -285.746)
        PosFinish = vect(155.223, 9.9, -186.502)
        Checkpoint = false
        MapName = "OG"
        return
    if getCurrentMap() == Map.OASIS_UNIVERSITY:
        PosStart = vect(-204.28, 19, -67.99)
        PosCheckpoint = [vect(-172.403, 16.9, 2.078)]
        PosFinish = vect(-188.53, 17.9, 60.728)
        Checkpoint = true
        MapName = "OU"
        return
    if getCurrentMap() == Map.PARAISO:
        PosStart = vect(-26.56, 2.75, -165.08)
        PosCheckpoint = [vect(7.36, 3.4, -24.55)]
        PosFinish = vect(-56.2, -1.1, 28.5)
        Checkpoint = true
        MapName = "PI"
        return
    if getCurrentMap() == Map.PARIS:
        PosStart = vect(-119.964, 9.86, -51.908)
        PosCheckpoint = [vect(-44.044, 11, -33.258)]
        PosFinish = vect(15.807, 9.8, -57.496)
        Checkpoint = true
        MapName = "PR"
        return
    if getCurrentMap() == Map.PETRA:
        PosStart = vect(-42.24, -12.88, 17.35)
        PosCheckpoint = [vect(2, -9, -3)]
        PosFinish = vect(23.35, -13.2, 53.1)
        Checkpoint = true
        MapName = "PT"
        return
    if getCurrentMap() == Map.RIALTO:
        PosStart = vect(-31.663, 1.75, -115.564)
        PosFinish = vect(160.704, -3.678, -62.886)
        Checkpoint = false
        MapName = "RT"
        return
    if getCurrentMap() == Map.ROUTE66:
        PosStart = vect(71.704, -0.06, 11.87)
        PosCheckpoint = [vect(-42.605, 3.3, 5.206)]
        PosFinish = vect(-100.763, 8.4, 8.128)
        Checkpoint = true
        MapName = "R6"
        return
    if getCurrentMap() == Map.SHAMBALI_MONASTERY:
        PosStart = vect(-40.68, 31, 213.38)
        PosCheckpoint = [vect(6.42, 18.8, 90)]
        PosFinish = vect(-14.75, 7.9, -5.12)
        Checkpoint = true
        MapName = "SM"
        return
    if getCurrentMap() == Map.TEMPLE_OF_ANUBIS:
        PosStart = vect(9.122, 4.4, 124.801)
        PosFinish = vect(14.464, 10, 12.459)
        Checkpoint = false
        MapName = "TA"
        return
    if getCurrentMap() == Map.VOLSKAYA:
        PosStart = vect(-96.722, -2.48, 24.146)
        PosCheckpoint = [vect(-37.356, 1.9, 98.043)]
        PosFinish = vect(-30.133, 1.9, 38.232)
        Checkpoint = true
        MapName = "VS"
        return
    if getCurrentMap() == Map.WATCHPOINT_GIBRALTAR:
        PosStart = vect(81.6, 3, -35.51)
        PosCheckpoint = [vect(66.186, -2.1, -114.804)]
        PosFinish = vect(22.688, -6.1, -159.187)
        Checkpoint = true
        MapName = "WG"
        return
            
            
rule "Start - Maps (Season 5)":
    @Condition Season == 4
    
    Checkpoint = true
    if getCurrentMap() == Map.BLIZZ_WORLD:
        PosStart = vect(-46.717, 4.7, 86.88)
        PosCheckpoint = [vect(0.922, -1, 107.766), vect(2.998, -4.2, -18.814), vect(-122.15, -0.3, 110.5)]
        PosFinish = vect(-50.14, -0.3, 93.171)
        MapName = "BW"
        return
    if getCurrentMap() == Map.BUSAN:
        #Downtown
        if not getCurrentObjective():
            PosStart = vect(52.012, 10, -117.491)
            PosCheckpoint = [vect(51.837, 4.8, -77.729), vect(-10.418, 15.9, -125.283), vect(114.197, 15.9, -125.294)]
            PosFinish = vect(52.012, 14.4, -117.491)
            MapName = "BD"
            return
        #MEKA Base
        if getCurrentObjective() == 2:
            PosStart = vect(217.009, 10.09, 228.832)
            PosCheckpoint = [vect(272.082, 10, 212.348), vect(167.216, 10, 257.301), vect(217.798, 17, 230.83)]
            PosFinish = vect(222.709, 9, 242.021)
            MapName = "BM"
            return
        #Sanctuary
        if getCurrentObjective() == 1:
            PosStart = vect(-328.384, 8.8, 144.334)
            PosCheckpoint = [vect(-389.913, 9, 139.646), vect(-328.561, 8, 180.59), vect(-266.552, 9, 138.877), vect(-327.941, 9.7, 117.976)]
            PosFinish = vect(-328.184, 13.5, 140.64)
            MapName = "BS"
            return
    if getCurrentMap() == Map.CHATEAU_GUILLARD:
        PosStart = vect(206.25, 0, 84.5)
        PosCheckpoint = [vect(218.29, 11.9, 51.29), vect(220.7, 4.9, 111.92), vect(173.15, 6.9, 66.05), vect(182.76, 8.9, 101.38)]
        PosFinish = vect(206.25, 8.9, 81.73)
        MapName = "CG"
        return
    if getCurrentMap() == Map.CIRCUIT_ROYAL:
        PosStart = vect(8.52, 5.82, 0.69)
        PosCheckpoint = [vect(104.36, 9.7, 28.74), vect(11.1, 9.5, -34.7), vect(27.34, 1, 37.78), vect(-63.78, 4, -41.41), vect(-22.04, 5.8, -42.31)]
        PosFinish = vect(11, 5.9, 6.39)
        MapName = "CR"
        return
    if getCurrentMap() == Map.COLOSSEO:
        PosStart = vect(0, 2.58, -6.14)
        PosCheckpoint = [vect(-18.16, 2.9, 27.9), vect(40.32, 1.9, 18.87), vect(-55, 2, -58.33), vect(83.28, 8.01, -30), vect(-83.28, 8.01, -30)]
        PosFinish = vect(0, 0.9, -18)
        MapName = "CS"
        return
    if getCurrentMap() == Map.DORADO:
        PosStart = vect(84.979, 20, 17.035)
        PosCheckpoint = [vect(136.754, 10.9, 45.919), vect(35.461, 9.7, -33.067), vect(8.526, -2, 22.064), vect(193.551, 14, 43.411)]
        PosFinish = vect(98.023, 17.9, 5.085)
        MapName = "DR"
        return
    if getCurrentMap() == Map.EICHENWALDE:
        PosStart = vect(69.737, 18.36, -66.742)
        PosCheckpoint = [vect(31.753, 13.5, -79.386), vect(142.5, 11.7, -38.836), vect(3.39, -0.1, -8.241)]
        PosFinish = vect(73.816, 12.6, -75.982)
        MapName = "EW"
        return
    if getCurrentMap() == Map.ESPERANCA:
        PosStart = vect(-39.86, -2, -26.51)
        PosCheckpoint = [vect(12.23, -6.1, -75.73)]
        PosFinish = vect(106, -1.1, -58.6)
        MapName = "ER"
        return
    if getCurrentMap() == Map.HANAMURA:
        PosStart = vect(11.329, 0, -24.036)
        PosCheckpoint = [vect(66.147, -2, -3.121), vect(-23.977, -0.95, -72.131)]
        PosFinish = vect(12.963, 6.7, -23.213)
        MapName = "HM"
        return
    if getCurrentMap() == Map.HAVANA:
        PosStart = vect(25.471, 6, -70.081)
        PosCheckpoint = [vect(138.605, 4.8, -25.422), vect(107.194, 1.2, -26.704), vect(-30.023, 9.9, -98.164), vect(-84.714, 3.8, -55.305)]
        PosFinish = vect(27.096, 9.9, -78.649)
        MapName = "HV"
        return
    if getCurrentMap() == Map.HOLLYWOOD:
        PosStart = vect(7.65, 6, -55.154)
        PosCheckpoint = [vect(16.595, -0.1, 62.76), vect(-12.548, -0.1, 64.54), vect(-37.391, 1.7, -140.414), vect(-4.969, 1.5, -99.506), vect(-47.322, -0.5, 12.226)]
        PosFinish = vect(8.044, 1.5, -48.109)
        MapName = "HW"
        return
    if getCurrentMap() == Map.HORIZON_LUNAR_COLONY:
        PosStart = vect(57.716, 8.77, -97.643)
        PosCheckpoint = [vect(-32.413, 4.4, -135.156), vect(24.286, 6.9, -20.328), vect(94.019, 11, -57.378)]
        PosFinish = vect(43.878, 13.5, -77.993)
        MapName = "HC"
        return
    if getCurrentMap() == Map.ILIOS_LIGHTHOUSE:
        PosStart = vect(336.294, -23.7, -42.507)
        PosCheckpoint = [vect(336.182, -25.7, 22.951), vect(290.258, -25.7, -88.687), vect(357.797, -25.7, -50.871), vect(322.5, -23.7, -36.7)]
        PosFinish = vect(338.282, -25.7, -43.21)
        MapName = "IL"
        return
    if getCurrentMap() == Map.ILIOS_RUINS:
        PosStart = vect(28.4, 60.47, -164.42)
        PosCheckpoint = [vect(87.767, 58.3, -148.654), vect(113.185, 65.3, -178.097), vect(-55.96, 60.3, -158.273)]
        PosFinish = vect(28.411, 57.3, -156.448)
        MapName = "IR"
        return
    if getCurrentMap() == Map.ILIOS_WELL:
        PosStart = vect(-201.811, 0.8, -10.588)
        PosCheckpoint = [vect(-155.044, -4, -58.727), vect(-179.473, -0.5, -87.438), vect(-258.817, -5.2, 21.142)]
        PosFinish = vect(-199.735, 9.8, -7.602)
        MapName = "IW"
        return
    if getCurrentMap() == Map.JUNKERTOWN:
        PosStart = vect(-43.021, 12.48, -61.452)
        PosCheckpoint = [vect(4.734, 6.4, -52.832), vect(37.373, 8.8, -74.34), vect(-84.607, 13.4, -159.448), vect(-49.728, 7.3, -118.016)]
        PosFinish = vect(-36.35, 4.2, -68.046)
        MapName = "JT"
        return
    if getCurrentMap() == Map.KANEZAKA:
        PosStart = vect(-30.18, 6.56, -8.78)
        PosCheckpoint = [vect(-44.21, 5.9, 26.86), vect(-4.37, 5.6, 17.15), vect(-1, 7.9, -45.85), vect(-43.25, 8.9, -52.15)]
        PosFinish = vect(-30.84, 10.7, -9.62)
        MapName = "KZ"
        return
    if getCurrentMap() == Map.KINGS_ROW:
        PosStart = vect(-56.613, -0.3, -42.469)
        PosCheckpoint = [vect(-154.342, -3.3, 24.929), vect(6.499, -0.2, -28.248), vect(-25.912, -0.2, 10.967)]
        PosFinish = vect(-70.902, 4.4, -36.354)
        MapName = "KR"
        return
    if getCurrentMap() == Map.LIJIANG_CONTROL_CENTER:
        PosStart = vect(0.023, 270, 301.513)
        PosCheckpoint = [vect(36.745, 264.9, 336.094), vect(-36.683, 264.9, 336.086), vect(0.125, 269.9, 260.847)]
        PosFinish = vect(-0.021, 267.3, 280)
        MapName = "JC"
        return
    if getCurrentMap() == Map.LIJIANG_GARDEN:
        PosStart = vect(0, 94, 142.57)
        PosCheckpoint = [vect(0, 95.9, 110), vect(56.906, 93.9, 145.431), vect(-64.365, 97.9, 162.007)]
        PosFinish = vect(0, 93.9, 150)
        MapName = "LG"
        return
    if getCurrentMap() == Map.LIJIANG_NIGHT_MARKET:
        PosStart = vect(1, -0.63, -21.52)
        PosCheckpoint = [vect(1.061, -1.1, -73.3), vect(27.511, -0.1, -18.133), vect(-56.438, 1.8, -29.101)]
        PosFinish = vect(0.84, -1.2, -29.825)
        MapName = "LM"
        return
    if getCurrentMap() == Map.MALEVENTO:
        PosStart = vect(1.14, 2, 15.5)
        PosCheckpoint = [vect(0, 1.4, 34), vect(29, 4.5, -5), vect(1, -3.6, -30), vect(-27, -2.1, 8)]
        PosFinish = vect(0, 0.9, 9.5)
        MapName = "MV"
        return
    if getCurrentMap() == Map.MIDTOWN:
        PosStart = vect(47.73, 3.84, -41.25)
        PosCheckpoint = [vect(-30.54, 3.9, 45.31)]
        PosFinish = vect(-16.41, 3.9, 98.35)
        MapName = "MT"
        return
    if getCurrentMap() == Map.NEPAL_SANCTUM:
        PosStart = vect(67.643, 132, 0.073)
        PosCheckpoint = [vect(97.8, 131.7, 73.715), vect(96.973, 131.7, -0.008), vect(56.276, 129.7, -0.025), vect(70.755, 127.7, -63.246)]
        PosFinish = vect(83.1, 127.9, 0.05)
        MapName = "NS"
        return
    if getCurrentMap() == Map.NEPAL_SHRINE:
        PosStart = vect(-52.552, 13.13, 0)
        PosCheckpoint = [vect(-53.696, 14.7, -63.339), vect(-53.662, 14.7, 63.728)]
        PosFinish = vect(-50, 12.7, 0)
        MapName = "NE"
        return
    if getCurrentMap() == Map.NEPAL_VILLAGE:
        PosStart = vect(-183.773, -94.08, 0)
        PosCheckpoint = [vect(-171.284, -99.3, -62.016), vect(-155.566, -91.2, 45.98), vect(-186.996, -96.6, 72.119)]
        PosFinish = vect(-181.606, -88, 0)
        MapName = "NV"
        return
    if getCurrentMap() == Map.NEW_QUEEN_STREET:
        PosStart = vect(-59.69, 8.02, -1.29)
        PosCheckpoint = [vect(0, 1.9, -42.2)]
        PosFinish = vect(66.14, 7.9, 9.89)
        MapName = "NQ"
        return
    /*if getCurrentMap() == Map.NUMBANI:
        PosStart = vect(161.121, -4, 6.575)
        PosCheckpoint = [vect(207.578, -2.2, 31.463), vect(203.656, -3.9, 1.168), vect(120.67, -5.8, -17.039), vect(131.903, -3.8, 40.896), vect(59.889, -0.8, -25.254), vect(8.506, 0.2, 37.804)]
        PosFinish = vect(169.395, 4.2, 6.428)
        MapName = "NB"
        return*/
    if getCurrentMap() == Map.OASIS_CITY_CENTER:
        PosStart = vect(143.522, 2.15, 247.456)
        PosCheckpoint = [vect(125.589, 0.9, 229.793), vect(91.966, 0.9, 305.984), vect(158.681, 3.9, 262.665), vect(183.478, -3.5, 207.761)]
        PosFinish = vect(143.522, 9.9, 247.456)
        MapName = "OC"
        return
    if getCurrentMap() == Map.OASIS_GARDENS:
        PosStart = vect(122.619, 6.27, -228.847)
        PosCheckpoint = [vect(185.4, 7.9, -203.4), vect(83.077, 5.4, -262.511), vect(120.717, 7.4, -267.995)]
        PosFinish = vect(121.375, 11.4, -227.604)
        MapName = "OG"
        return
    if getCurrentMap() == Map.OASIS_UNIVERSITY:
        PosStart = vect(-196.495, 15, 0)
        PosCheckpoint = [vect(-196.1, 16.9, 57.72), vect(-171.972, 14.9, -44.885), vect(-207.617, 17.9, -62.585)]
        PosFinish = vect(-202.067, 18.9, -0.002)
        MapName = "OU"
        return
    if getCurrentMap() == Map.PARAISO:
        PosStart = vect(-7.7, 3.75, 36.99)
        PosCheckpoint = [vect(24.91, 4.8, -110.14)]
        PosFinish = vect(-56.2, -1.1, 28.5)
        MapName = "PI"
        return
    if getCurrentMap() == Map.PARIS:
        PosStart = vect(-27.132, 13, 6.412)
        PosCheckpoint = [vect(7.458, 9.9, -58.2), vect(-53.175, 12, 12.32), vect(-73.074, 14.9, -86.629), vect(-118.024, 12.9, -92.921), vect(-83.325, 11.7, -58.477)]
        PosFinish = vect(-58.73, 11, -13.232)
        MapName = "PR"
        return
    if getCurrentMap() == Map.PETRA:
        PosStart = vect(2, -11, 21.26)
        PosCheckpoint = [vect(27, -11.3, 31.8), vect(-23.9, -9, 18), vect(-21.34, -9.5, -10), vect(19.12, -6.1, -12.85)]
        PosFinish = vect(2, -1.1, 30)
        MapName = "PT"
        return
    if getCurrentMap() == Map.RIALTO:
        PosStart = vect(2.38, -11, 21.24)
        PosCheckpoint = [vect(85.068, -0.5, -49.805), vect(107.15, -1.3, -1.272), vect(-25.075, -1.8, -60.92), vect(-57.09, 4.7, -145.623)]
        PosFinish = vect(2, -1.1, 30)
        MapName = "RT"
        return
    if getCurrentMap() == Map.ROUTE66:
        PosStart = vect(-10.146, 8.13, -8.694)
        PosCheckpoint = [vect(-43.069, 3.3, 5.652), vect(-68.091, 6.4, -14.181), vect(44.356, 2.3, 62.423)]
        PosFinish = vect(-23.554, 3.2, -15.238)
        MapName = "R6"
        return
    if getCurrentMap() == Map.SHAMBALI_MONASTERY:
        PosStart = vect(25, 14, 63.75)
        PosCheckpoint = [vect(-60, 22.9, 126)]
        PosFinish = vect(12.36, 26.9, 117.14)
        MapName = "SM"
        return
    if getCurrentMap() == Map.TEMPLE_OF_ANUBIS:
        PosStart = vect(-31.404, 1.3, 27.937)
        PosCheckpoint = [vect(12.334, -2.6, -1.291), vect(15.76, 0.4, 98.839), vect(-20.635, 2.5, 104.372), vect(-8.628, -2.5, -15.143)]
        PosFinish = vect(-21.014, 4.5, 35.175)
        MapName = "TA"
        return
    if getCurrentMap() == Map.VOLSKAYA:
        PosStart = vect(-38.235, -2.51, 54.73)
        PosCheckpoint = [vect(-98.926, -2.5, 23.314), vect(-104.674, -4, 68.186), vect(23.227, -4.1, 100.796), vect(-23.84, -5, 38.582)]
        PosFinish = vect(-56.662, -4.2, 71.855)
        MapName = "VS"
        return
    if getCurrentMap() == Map.WATCHPOINT_GIBRALTAR:
        PosStart = vect(70.129, 3, -44.346)
        PosCheckpoint = [vect(94.532, -1, 42.21), vect(96.233, 1, 15.036), vect(28.308, -6.1, -158.458), vect(66.1, -2.6, -114.92), vect(64.438, 0.3, 13.364)]
        PosFinish = vect(59.279, -3.2, -39.483)
        PosBarrier = [vect(38.005, 4.175, -76.422), vect(38.619, -3.844, -76.96)]
        MapName = "WG"
        return


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
    hudHeader([player for player in getAllPlayers() if not player.Category], "Lucio Surf v5.9 | {0}S{1}".format(Season + 1, MapName), HudPosition.RIGHT, 0, Color.YELLOW, HudReeval.VISIBILITY)
    hudHeader([player for player in getAllPlayers() if player.Category == 1], "Lucio Surf v5.9 | {0}G{1}".format(Season + 1, MapName), HudPosition.RIGHT, 0, Color.YELLOW, HudReeval.VISIBILITY)
    #Leaderboards
    hudHeader([player for player in getAllPlayers() if not player.Category and player.HideHud <= 1], "3 - {0}.{1} sec - {2}".format(floor(TimeThirdStan + 0.001 / 1000), "{0}".format(floor((1000 * TimeThirdStan + 0.001)) % 1000 + 1000).substring(1, 3), PlayerThirdStan), HudPosition.RIGHT, 3, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader([player for player in getAllPlayers() if not player.Category and player.HideHud <= 1], "2 - {0}.{1} sec - {2}".format(floor(TimeSecondStan + 0.001 / 1000), "{0}".format(floor((1000 * TimeSecondStan + 0.001)) % 1000 + 1000).substring(1, 3), PlayerSecondStan), HudPosition.RIGHT, 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader([player for player in getAllPlayers() if not player.Category], "1 - {0}.{1} sec - {2}".format(floor(TimeFirstStan + 0.001 / 1000), "{0}".format(floor((1000 * TimeFirstStan + 0.001)) % 1000 + 1000).substring(1, 3), PlayerFirstStan), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader([player for player in getAllPlayers() if player.Category == 1 and player.HideHud <= 1], "3 - {0}.{1} sec - {2}".format(floor(TimeThirdGrav + 0.001 / 1000), "{0}".format(floor((1000 * TimeThirdGrav + 0.001)) % 1000 + 1000).substring(1, 3), PlayerThirdGrav), HudPosition.RIGHT, 3, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader([player for player in getAllPlayers() if player.Category == 1 and player.HideHud <= 1], "2 - {0}.{1} sec - {2}".format(floor(TimeSecondGrav + 0.001 / 1000), "{0}".format(floor((1000 * TimeSecondGrav + 0.001)) % 1000 + 1000).substring(1, 3), PlayerSecondGrav), HudPosition.RIGHT, 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader([player for player in getAllPlayers() if player.Category == 1], "1 - {0}.{1} sec - {2}".format(floor(TimeFirstGrav + 0.001 / 1000), "{0}".format(floor((1000 * TimeFirstGrav + 0.001)) % 1000 + 1000).substring(1, 3), PlayerFirstGrav), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    #Help text standard
    hudSubtext(getAllPlayers(), "Cycle HUD - Crouch + Interact", HudPosition.LEFT, 3, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and not player.Mode], "Reset - Ultimate", HudPosition.LEFT, 4, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and player == hostPlayer], "Toggle Invisibility - Crouch + Reload", HudPosition.LEFT, 5, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and not player.Mode], "Cycle Auto Reset - Crouch + Melee", HudPosition.LEFT, 7, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and not player.Mode], "Cycle Category - Crouch + Ability 2", HudPosition.LEFT, 8, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and not player.Mode], "Practice Mode - Interact", HudPosition.LEFT, 9, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and not player.Mode], "Player Spectator Mode - Ability 2", HudPosition.LEFT, 10, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and not player.Mode], "Spectator Mode - Reload", HudPosition.LEFT, 11, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    #Help text practice
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and player.Mode == 1], "Standard Mode - Interact", HudPosition.LEFT, 7, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and player.Mode == 1], "Ult Reset (Checkpoint) - Ultimate", HudPosition.LEFT, 8, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and player.Mode == 1], "Set Checkpoint - Secondary Fire", HudPosition.LEFT, 9, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and player.Mode == 1], "Delete Checkpoint - Ability 2", HudPosition.LEFT, 10, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    #Help text playerspec
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and player.Mode == 2], "Standard Mode - Ability 2", HudPosition.LEFT, 7, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and player.Mode == 2], "Spectate next - Primary Fire", HudPosition.LEFT, 8, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and player.Mode == 2], "Spectate previous - Secondary Fire", HudPosition.LEFT, 9, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)    
    #Help text spectator
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and player.Mode == 3], "Standard Mode - Reload", HudPosition.LEFT, 7, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and player.Mode == 3], "Stop - Primary Fire", HudPosition.LEFT, 8, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
    hudSubtext([player for player in getAllPlayers() if not player.HideHud and player.Mode == 3], "Slow Move - Secondary Fire", HudPosition.LEFT, 9, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)


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
    eventPlayer.HideHud = 1
    if (getCurrentGamemode() != Gamemode.FFA):
        eventPlayer.FFAReset = true
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
    hudHeader(eventPlayer if not eventPlayer.Category else null, "Best - {0}.{1} sec".format(floor(eventPlayer.TimeBestStan + 0.001 / 1000), "{0}".format(floor((1000 * eventPlayer.TimeBestStan + 0.001)) % 1000 + 1000).substring(1, 3)), HudPosition.LEFT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader(eventPlayer if eventPlayer.Category == 1 else null, "Best - {0}.{1} sec".format(floor(eventPlayer.TimeBestGrav + 0.001 / 1000), "{0}".format(floor((1000 * eventPlayer.TimeBestGrav + 0.001)) % 1000 + 1000).substring(1, 3)), HudPosition.LEFT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader(eventPlayer if eventPlayer.HideHud <= 1 else null, "ATTEMPTS: {0}".format(eventPlayer.Attempts), HudPosition.LEFT, 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader(eventPlayer, "{0} m/s".format(eventPlayer.getHorizontalSpeed()), HudPosition.TOP, 0.1, eventPlayer.SpeedColor, HudReeval.STRING_AND_COLOR, SpecVisibility.DEFAULT)
    hudHeader(eventPlayer, "{0}.{1} sec".format(floor(eventPlayer.TimeCurrent + 0.001 / 1000), "{0}".format(floor((1000 * eventPlayer.TimeCurrent + 0.001)) % 1000 + 1000).substring(1, 4)), HudPosition.TOP, 0.2, Color.WHITE, HudReeval.STRING, SpecVisibility.DEFAULT)
    #Start
    async(Respawn, AsyncBehavior.NOOP)


rule "Last Frame Data":
    @Event eachPlayer

    while true:
        eventPlayer.PosNow = eventPlayer.getPosition()
        eventPlayer.SpeedNow = eventPlayer.getHorizontalSpeed()
        wait()
        eventPlayer.PosPrev = eventPlayer.PosNow
        eventPlayer.SpeedPrev = eventPlayer.SpeedNow


rule "Start timer":
    @Event eachPlayer
    @Condition not eventPlayer.Mode or (eventPlayer.Mode == 1 and not eventPlayer.PracticeCheckpoint)
    @Condition not any([checkpoint for checkpoint in eventPlayer.Checkpoint]) or eventPlayer.Mode == 1
    @Condition updateEveryTick(distance(PosStart, vect(eventPlayer.getPosition().x, PosStart.y, eventPlayer.getPosition().z)) > 2 or abs(eventPlayer.getPosition().y - PosStart.y) > 3)
    
    chase(eventPlayer.TimeCurrent, 5000, rate=1, ChaseReeval.NONE)

    /*2 methods of starting timer: either further than 2 m away, or more than 3 m up. Start is a cylinder.*/
    if distance(vect(eventPlayer.PosPrev.x, PosStart.y, eventPlayer.PosPrev.z), PosStart) <= 2 and distance(vect(eventPlayer.PosNow.x, PosStart.y, eventPlayer.PosNow.z), PosStart) > 2:
        /*Get angle between the travel line and (1, 0, 0) and add 180°. I don't know why the 180°s are necessary, but they are.*/
        eventPlayer.Angle = horizontalAngleOfDirection(Vector.RIGHT) + horizontalAngleOfDirection(vect(eventPlayer.PosNow.x - eventPlayer.PosPrev.x, 0, eventPlayer.PosNow.z - eventPlayer.PosPrev.z))
        /*Translate the travel line so that PosStart is considered the origin, then rotate by the calculated angle.
          This will result in the travel line being of the from y = c, with c being the z-coordinate of a point on the line.
          For optimization purposes only PosNow gets transformed, bc we know that the slope is 0.*/
        eventPlayer.PosNorm = vect((eventPlayer.PosNow.x - PosStart.x) * cosDeg(eventPlayer.Angle) - (eventPlayer.PosNow.z - PosStart.z) * sinDeg(eventPlayer.Angle), 0, (eventPlayer.PosNow.x - PosStart.x) * sinDeg(eventPlayer.Angle) + (eventPlayer.PosNow.z - PosStart.z) * cosDeg(eventPlayer.Angle))
        /*calculate extra time with
            0.016 - (1/speed) x
          with x being the dinstance between PosNow and the intersection of the travel line and the start circle (x^2 + c^2 = r^2 => x = sqrt(r^2 - c^2).
          This formula is a near perfect approximation for the actual formula in the relevant area (0 <= y <= 0.016).
          The rotation leaves the intersect and posNow always in the postivie for x, with PosNowm.x >= sqrt(...).*/
        eventPlayer.TimeExtra = 0.016 - (eventPlayer.PosNorm.x - sqrt(4 - eventPlayer.PosNorm.z*eventPlayer.PosNorm.z)) / eventPlayer.SpeedNow
    else:
        eventPlayer.TimeExtra = 0
    if eventPlayer.PosNow.y - PosStart.y > 3:
        /*Crude approximation with disregard to speed. This case will not happen in 99% of the starts.*/
        eventPlayer.TimeExtra2 = 0.016 * ((eventPlayer.PosNow.y - PosStart.y - 3) / (eventPlayer.PosNow.y - eventPlayer.PosPrev.y))
        /*If both cases happen chose the higher extra time.*/
        eventPlayer.TimeExtra = eventPlayer.TimeExtra if eventPlayer.TimeExtra > eventPlayer.TimeExtra2 else eventPlayer.TimeExtra2
    eventPlayer.TimeCurrent += eventPlayer.TimeExtra

    if not Visible or eventPlayer.Mode == 1:
        return
    eventPlayer.setInvisibility(Invis.NONE)


rule "Start timer (Practice)":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 1
    @Condition eventPlayer.PracticeCheckpoint
    @Condition eventPlayer.SpeedPracticeCheckpoint == 0
    @Condition updateEveryTick(distance(eventPlayer.PosPracticeCheckpoint, vect(eventPlayer.getPosition().x, eventPlayer.PosPracticeCheckpoint.y, eventPlayer.getPosition().z)) > 2 or abs(eventPlayer.getPosition().y - eventPlayer.PosPracticeCheckpoint.y) > 3)
    
    chase(eventPlayer.TimeCurrent, 5000, rate=1, ChaseReeval.NONE)

    
rule "Checkpoint":
    @Event eachPlayer
    @Condition Checkpoint
    @Condition not eventPlayer.Finished
    @Condition eventPlayer.Mode <= 1
    @Condition any([distance(checkpoint, vect(eventPlayer.getPosition().x, checkpoint.y, eventPlayer.getPosition().z)) <= 3.5 and eventPlayer.getPosition().y >= checkpoint.y for checkpoint in PosCheckpoint])
    
    if eventPlayer.Mode == 1:
        smallMessage(eventPlayer, "{0}.{1}".format(floor(eventPlayer.TimeCurrent + 0.001 / 10), "{0}".format(round((1000 * eventPlayer.TimeCurrent) % 1000 + 1000)).substring(1, 3)))
        return

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
        smallMessage(eventPlayer, l"{0} - {1}".format(l"{0} {1}".format(l"Finish", l"Unlocked"), l"{0} sec".format(eventPlayer.TimeCurrent)))
        return
    
    smallMessage(eventPlayer, l"{0}: {1}".format(l"Checkpoints", "{0}/{1} - {2}".format(len([checkpoint for checkpoint in eventPlayer.Checkpoint if checkpoint]), len(PosCheckpoint), "{0}.{1} sec".format(floor(eventPlayer.TimeCurrent + 0.001 / 10), "{0}".format(round((1000 * eventPlayer.TimeCurrent) % 1000 + 1000)).substring(1, 3)))))


rule "Checkpoint (no LoS)":
    @Event eachPlayer
    @Condition Checkpoint
    @Condition not eventPlayer.Finished
    @Condition eventPlayer.Mode <= 1
    @Condition any([distance(checkpoint, vect(eventPlayer.getPosition().x, checkpoint.y, eventPlayer.getPosition().z)) <= 3.5 and eventPlayer.getPosition().y < checkpoint.y for checkpoint in PosCheckpoint])
    
    eventPlayer.CurrCheckpoint = PosCheckpoint.index([checkpoint for checkpoint in PosCheckpoint if distance(checkpoint, vect(eventPlayer.getPosition().x, checkpoint.y, eventPlayer.getPosition().z)) <= 3.5 and eventPlayer.getPosition().y < checkpoint.y][0])
    if (eventPlayer.CurrCheckpoint == -1 or eventPlayer.Checkpoint[eventPlayer.CurrCheckpoint]):
        return

    smallMessage(eventPlayer, l"{0} {1}".format(l"Checkpoint", l"Out of View"))


rule "Finish":
    @Event eachPlayer
    @Condition all([checkpoint for checkpoint in eventPlayer.Checkpoint]) or eventPlayer.Mode == 1
    @Condition not eventPlayer.Finished
    @Condition eventPlayer.Mode <= 1
    @Condition updateEveryTick(distance(PosFinish, vect(eventPlayer.getPosition().x, PosFinish.y, eventPlayer.getPosition().z)) <= 5)
    @Condition updateEveryTick(eventPlayer.getPosition().y >= PosFinish.y)
    @Condition eventPlayer.FFAReset
    
    if eventPlayer.Mode == 1:
        stopChasingVariable(eventPlayer.TimeCurrent)
        return

    if eventPlayer.TimeCurrent < 0.1:
        smallMessage(eventPlayer, "No timer start.")
        async(Respawn, AsyncBehavior.NOOP)
        return

    stopChasingVariable(eventPlayer.TimeCurrent)
    eventPlayer.Attempts += 1

    /*Get angle between the travel line and (-1, 0, 0) (OW's coordinate system is left handed).*/
    eventPlayer.Angle = horizontalAngleOfDirection(Vector.RIGHT) + horizontalAngleOfDirection(vect(eventPlayer.PosNow.x - eventPlayer.PosPrev.x, 0, eventPlayer.PosNow.z - eventPlayer.PosPrev.z))
    /*Translate the travel line so that PosFinish is considered the origin, then rotate by the calculated angle.
      This will result in the travel line being of the from y = c, with c being the z-coordinate of a point on the line.
      For optimization purposes only PosPrev gets transformed, bc we know that the slope is 0.*/
    eventPlayer.PosNorm = vect((eventPlayer.PosPrev.x - PosFinish.x) * cosDeg(eventPlayer.Angle) - (eventPlayer.PosPrev.z - PosFinish.z) * sinDeg(eventPlayer.Angle), 0, (eventPlayer.PosPrev.x - PosFinish.x) * sinDeg(eventPlayer.Angle) + (eventPlayer.PosPrev.z - PosFinish.z) * cosDeg(eventPlayer.Angle))
    /*calculate extra time with
        (1/speed) x
      with x being the dinstance between PosPrev and the intersection of the travel line and the start circle (x^2 + c^2 = r^2 => x = sqrt(r^2 - c^2).
      This formula is a near perfect approximation for the actual formula in the relevant area (0 <= y <= 0.016).
      The rotation leaves the intersect always in the negative. Sqrt(...) returns the positive intersection point.
      We therefore need the negative of the root to get an accureate result [0.016 - (-sqrt(...) - PosNorm.x) / SpeedPrev => 0.016 + (sqrt(...) + PosNorm.x) / SpeedPrev].
      PosNorm.x <= -sqrt(...)*/
    eventPlayer.TimeExtra = 0.016 + (sqrt(25 - eventPlayer.PosNorm.z*eventPlayer.PosNorm.z) + eventPlayer.PosNorm.x) / eventPlayer.SpeedPrev
    eventPlayer.TimeCurrent -= eventPlayer.TimeExtra

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
    /*This wait is needed so that the "Finish Messages" rules announce the correct player. Otherwise the messages would have the old player's name in them instead.*/
    wait()
    eventPlayer.Finished = true


rule "Finish (no LoS)":
    @Event eachPlayer
    @Condition not eventPlayer.Finished
    @Condition eventPlayer.Mode <= 1
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
    
    bigMessage(eventPlayer, "New PB: {0}.{1} sec".format(floor((eventPlayer.TimeBestStan if not eventPlayer.Category else eventPlayer.TimeBestGrav) + 0.001 / 1000), "{0}".format(floor((1000 * (eventPlayer.TimeBestStan if not eventPlayer.Category else eventPlayer.TimeBestGrav) + 0.001)) % 1000 + 1000).substring(1, 3)))

rule "Finish Message (Record Time)":
    @Event eachPlayer
    @Condition eventPlayer.Finished
    @Condition eventPlayer.NewBest
    @Condition (not eventPlayer.Category and eventPlayer == PlayerFirstStan) or (eventPlayer.Category == 1 and eventPlayer == PlayerFirstGrav)
    
    bigMessage([player for player in getAllPlayers() if player.Category == eventPlayer.Category], "New Record: {0}.{1} sec - {2}!!!".format(floor((eventPlayer.TimeBestStan if not eventPlayer.Category else eventPlayer.TimeBestGrav) + 0.001 / 1000), "{0}".format(floor((1000 * (eventPlayer.TimeBestStan if not eventPlayer.Category else eventPlayer.TimeBestGrav) + 0.001)) % 1000 + 1000).substring(1, 3), eventPlayer))


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
    @Condition eventPlayer.Mode == 0
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
        ([player for player in getAllPlayers() if not player.Mode and not (distance(PosStart, vect(player.getPosition().x, PosStart.y, player.getPosition().z)) <= 2 and abs(player.getPosition().y - PosStart.y) <= 3)]).setInvisibility(Invis.NONE)
        Visible = true
    waitUntil(not eventPlayer.isHoldingButton(Button.RELOAD), 9999)
    eventPlayer.ExecutingMenu = false


rule "Cycle HUD":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) and eventPlayer.isHoldingButton(Button.CROUCH)
    @Condition not eventPlayer.ExecutingMenu
    
    eventPlayer.ExecutingMenu = true
    if eventPlayer.HideHud == 0:
        eventPlayer.HideHud++
    elif eventPlayer.HideHud == 1:
        eventPlayer.disableHeroHUD()
        eventPlayer.HideHud++
    else:
        eventPlayer.enableHeroHud()
        eventPlayer.HideHud = 0
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
    eventPlayer.Finished = false
    eventPlayer.TimeCurrent = 0
    eventPlayer.TimeExtra = 0
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
    if eventPlayer.PracticeCheckpoint:
        if eventPlayer.SpeedPracticeCheckpoint == 0:
            destroyEffect(getLastCreatedEntity())
        else:
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
    
    if eventPlayer.PracticeCheckpoint:
        if eventPlayer.SpeedPracticeCheckpoint == 0:
            destroyEffect(getLastCreatedEntity())
        else:
            destroyIcon(getLastCreatedEntity())
    eventPlayer.PosPracticeCheckpoint = eventPlayer.getPosition()
    eventPlayer.FacingPracticeCheckpoint = eventPlayer.getFacingDirection()
    eventPlayer.VelocityPracticeCheckpoint = eventPlayer.getVelocity()
    eventPlayer.SpeedPracticeCheckpoint = eventPlayer.getSpeed()
    
    eventPlayer.PracticeCheckpoint = true
    if eventPlayer.SpeedPracticeCheckpoint == 0:
        createEffect(eventPlayer, Effect.RING, Color.GREEN, eventPlayer.PosPracticeCheckpoint, 2, EffectReeval.NONE)
    else:
        createIcon(eventPlayer, eventPlayer.PosPracticeCheckpoint, Icon.FLAG, IconReeval.POSITION, Color.GREEN, true)
    smallMessage(eventPlayer, l"{0} {1}".format(l"Checkpoint", l"Saved"))


rule "Delete Practice Checkpoint":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 1
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2)

    if (eventPlayer.PracticeCheckpoint):
        eventPlayer.PracticeCheckpoint = false
        if eventPlayer.SpeedPracticeCheckpoint == 0:
            destroyEffect(getLastCreatedEntity())
        else:
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
    eventPlayer.TimeExtra = 0
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
    @Condition updateEveryTick(distance(PosStart, vect(eventPlayer.getPosition().x, PosStart.y, eventPlayer.getPosition().z)) <= 2)
    @Condition updateEveryTick(abs(eventPlayer.getPosition().y - PosStart.y) <= 3)
    @Condition eventPlayer.isOnGround()
    @Condition not eventPlayer.Reset
    @Condition eventPlayer.Mode <= 1
    @Condition not eventPlayer.PracticeCheckpoint
    @Condition not any([checkpoint for checkpoint in eventPlayer.Checkpoint])
    @Condition updateEveryTick((not eventPlayer.Category and eventPlayer.getHorizontalSpeed() <= 6.88) or (eventPlayer.Category == 1 and eventPlayer.getHorizontalSpeed() <= 8.6))
    
    stopChasingVariable(eventPlayer.TimeCurrent)
    eventPlayer.TimeCurrent = 0
    eventPlayer.TimeExtra = 0
    eventPlayer.setInvisibility(Invis.ALL)
    wait(0.05)
    eventPlayer.allowButton(Button.JUMP)


rule "Circle Fix (Practice)":
    @Event eachPlayer
    @Condition eventPlayer.Mode == 1
    @Condition eventPlayer.PracticeCheckpoint
    @Condition updateEveryTick(distance(eventPlayer.PosPracticeCheckpoint, vect(eventPlayer.getPosition().x, eventPlayer.PosPracticeCheckpoint.y, eventPlayer.getPosition().z)) <= 2)
    @Condition updateEveryTick(abs(eventPlayer.getPosition().y - eventPlayer.PosPracticeCheckpoint.y) <= 3)
    @Condition eventPlayer.isOnGround()
    @Condition not eventPlayer.Reset
    @Condition updateEveryTick((not eventPlayer.Category and eventPlayer.getHorizontalSpeed() <= 6.88) or (eventPlayer.Category == 1 and eventPlayer.getHorizontalSpeed() <= 8.6))
    
    stopChasingVariable(eventPlayer.TimeCurrent)
    eventPlayer.TimeCurrent = 0
    eventPlayer.TimeExtra = 0
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
            eventPlayer.setFacing(eventPlayer.FacingPracticeCheckpoint, Relativity.TO_WORLD)
            if eventPlayer.SpeedPracticeCheckpoint:
                eventPlayer.Attempts += 1
                eventPlayer.teleport(eventPlayer.PosPracticeCheckpoint)
                eventPlayer.applyImpulse(eventPlayer.getVelocity() * -0.001, 0.001, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
                eventPlayer.applyImpulse(eventPlayer.VelocityPracticeCheckpoint, eventPlayer.SpeedPracticeCheckpoint, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
                stopChasingVariable(eventPlayer.TimeCurrent)
                eventPlayer.TimeCurrent = 0
                eventPlayer.TimeExtra = 0
                chase(eventPlayer.TimeCurrent, 5000, rate=1, ChaseReeval.NONE)
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
    if eventPlayer.Mode == 1 and eventPlayer.PracticeCheckpoint:
        eventPlayer.teleport(eventPlayer.PosPracticeCheckpoint)
    else:
        eventPlayer.teleport(PosStart)
    eventPlayer.applyImpulse(eventPlayer.getVelocity() * -0.001, 0.001, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.applyImpulse(eventPlayer.getVelocity() * 0.001, 0.001, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
    eventPlayer.setStatusEffect(null, Status.ROOTED, 0.5)
    waitUntil(distance(eventPlayer.getPosition(), PosStart) < 1, 0.4)
    eventPlayer.Finished = false
    for eventPlayer.CheckpointLoop in range(0, len(eventPlayer.Checkpoint)):
        eventPlayer.Checkpoint[eventPlayer.CheckpointLoop] = false
    if eventPlayer.Mode > 1:
        eventPlayer.Attempts = -1
        eventPlayer.Mode = 0
        if not eventPlayer.Category:
            eventPlayer.setGravity(100)
            eventPlayer.setMoveSpeed(100)
        elif eventPlayer.Category == 1:
            eventPlayer.setGravity(80)
            eventPlayer.setMoveSpeed(125)

