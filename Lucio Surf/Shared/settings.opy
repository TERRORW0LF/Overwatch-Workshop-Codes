rule "Workshop Settings":
    LayoutArr = []
    LayoutArr[0] = 0 if createWorkshopSetting(bool, "Layout", "Layout 1", true, 0) else -1
    LayoutArr[1] = 1 if createWorkshopSetting(bool, "Layout", "Layout 2", true, 1) else -1
    LayoutArr[2] = 2 if createWorkshopSetting(bool, "Layout", "Layout 3", true, 2) else -1
    LayoutArr[3] = 3 if createWorkshopSetting(bool, "Layout", "Layout 4", true, 3) else -1
    LayoutArr[4] = 4 if createWorkshopSetting(bool, "Layout", "Layout 5", false, 4) else -1
    Layout = random.choice([layout for layout in LayoutArr if layout >= 0])
    CategoryArr = []
    CategoryArr[0] = 0 if createWorkshopSetting(bool, "Category", "Standard", true, 0) else -1
    CategoryArr[1] = 1 if createWorkshopSetting(bool, "Category", "Gravspeed", true, 1) else -1
    Category = random.choice([category for category in CategoryArr if category >= 0])
    Time = createWorkshopSetting(int[60:3600], "Time", "Seconds", 600, 0)
    Infinite = createWorkshopSetting(bool, "Time", "Infinite", false, 1)
    VoteMin = createWorkshopSetting(int[1:10], "Map skip", "Minimum Votes", 2, 0)
    VotePerc = createWorkshopSetting(float[0:100], "Map skip", "Minimum Percentage", 50, 1)
    