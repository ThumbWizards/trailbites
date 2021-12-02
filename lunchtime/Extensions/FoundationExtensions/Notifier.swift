import Foundation

@objc public class Notifier: NSObject {
    private(set) var activeTokens = [NSObjectProtocol]()

    private let notificationProvider: NotificationProvider

    public init(with notificationProvider: NotificationProvider = NotificationCenter.default) {
        self.notificationProvider = notificationProvider
    }

    @objc public class func notifier() -> Notifier {
        return Notifier()
    }

    deinit {
        activeTokens.forEach { notificationProvider.removeObserver($0) }
    }

    public func post(_ notification: String, from object: Any? = nil, with userInfo: [AnyHashable: Any]? = nil) {
        self.notificationProvider.postNotification(name: notification,
                                                   object: object,
                                                   userInfo: userInfo)
    }

    public static func post(_ notification: String, from object: Any? = nil, with userInfo: [AnyHashable: Any]? = nil) {
        NotificationCenter.default.postNotification(name: notification,
                                                    object: object,
                                                    userInfo: userInfo)
    }

    @discardableResult
    public func notify(_ name: Notification.Name, block: @escaping ((Notification) -> Void)) -> NSObjectProtocol {
        return notify(name.rawValue, block: block)
    }

    @discardableResult
    @objc public func notify(_ notificationName: String, block: @escaping ((Notification) -> Void)) -> NSObjectProtocol {
        let token = notificationProvider.addObserver(notificationName,
                                                     object: nil,
                                                     queue: OperationQueue.main,
                                                     block: block)
        activeTokens.append(token)
        return token
    }

    public func removeObservation(for token: NSObjectProtocol) {
        if let index = activeTokens.firstIndex(where: { token.isEqual($0) }) {
            activeTokens.remove(at: index)
        }

        notificationProvider.removeObserver(token)
    }
}
