import Foundation

public class UserBackedObjectSetting: ObjectSetting {
    let userDefaults: UserDefaults
    let key: String
    public var value: Any? {
        get {
            return userDefaults.object(forKey: key)
        }
        set {
            userDefaults.set(newValue, forKey: key)
        }
    }

    public init(userDefaults: UserDefaults = UserDefaults.standard, key: String) {
        self.userDefaults = userDefaults
        self.key = key
    }
}
