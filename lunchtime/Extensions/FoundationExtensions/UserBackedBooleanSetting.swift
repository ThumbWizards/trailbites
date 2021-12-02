import Foundation

public class UserBackedBooleanSetting: BooleanSetting {
    let userDefaults: Foundation.UserDefaults
    let key: String

    public var value: Bool {
        get {
            return userDefaults.bool(forKey: key)
        }

        set {
            userDefaults.set(newValue, forKey: key)
        }
    }

    public init(userDefaults: Foundation.UserDefaults = Foundation.UserDefaults.standard, key: String) {
        self.userDefaults = userDefaults
        self.key = key
    }
}
