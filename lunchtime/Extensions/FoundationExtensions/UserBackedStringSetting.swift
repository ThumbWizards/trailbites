import Foundation

public class UserBackedStringSetting: StringSetting {
    let userDefaults: UserDefaults
    let key: String
    private let defaultValue: String?
    public var value: String? {
        get {
            return userDefaults.object(forKey: key) as? String ?? defaultValue
        }
        set {
            userDefaults.set(newValue, forKey: key)
        }
    }

    public init(userDefaults: UserDefaults = UserDefaults.standard, key: String, defaultValue: String? = nil) {
        self.userDefaults = userDefaults
        self.key = key
        self.defaultValue = defaultValue
    }
}
