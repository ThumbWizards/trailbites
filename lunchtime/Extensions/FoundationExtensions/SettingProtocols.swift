import Foundation

public protocol ObjectSetting: AnyObject {
    var value: Any? { get set }
}

@objc public protocol BooleanSetting: AnyObject {
    var value: Bool { get set }
}

public protocol DateSetting {
    var value: Date? { get set }
}

@objc public protocol StringSetting: AnyObject {
    var value: String? { get set }
}

public protocol IntegerSetting: AnyObject {
    var value: Int? { get set }
}

public protocol DoubleSetting: AnyObject {
    var value: Double? { get set }
}

public protocol DictionarySetting: AnyObject {
    var value: [String: String]? { get set }
}
