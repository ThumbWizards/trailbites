import Foundation

public class UserBackedIntegerSetting: IntegerSetting {
    let userDefaults: Foundation.UserDefaults
    let key: String
    public var value: Int? {
        get {
            return userDefaults.object(forKey: key) as? Int
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
