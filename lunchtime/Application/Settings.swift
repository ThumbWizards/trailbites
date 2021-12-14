public struct Settings {
    public static let all: Settings = Settings()

    public static let lastLaunchVersionKey: StringSetting = UserBackedStringSetting(key: "LastLaunchVersionKey")

    // Stores the users preference for light/dark mode
    //
    public static let themeOverride: IntegerSetting = UserBackedIntegerSetting(key: "themeOverride")

    // Stores the saved filter and whether it is descending (default false)
    //
    public static let ratingsFilterAscending: BooleanSetting = UserBackedBooleanSetting(key: "ratingsFilterAscending")
}
