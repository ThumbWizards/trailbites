import Foundation

@objc public protocol NotificationProvider {
    func post(name: NSNotification.Name, object: Any?)
    func postNotification(name: String, object: Any?, userInfo: [AnyHashable: Any]?)
    @discardableResult
    func addObserver(_ name: String, object obj: Any?, queue: OperationQueue?, block: @escaping ((Notification) -> Void)) -> NSObjectProtocol
    func removeObserver(_ observer: Any)
}

extension NotificationCenter: NotificationProvider {

    public func post(name: NSNotification.Name, object: Any?) {
        post(name: name, object: object)
    }

    public func postNotification(name: String, object: Any? = nil, userInfo: [AnyHashable: Any]? = nil) {
        post(name: NSNotification.Name(rawValue: name), object: object, userInfo: userInfo)
    }

    @discardableResult
    public func addObserver(_ name: Notification.Name, object obj: Any? = nil, queue: OperationQueue? = OperationQueue.main, block: @escaping ((Notification) -> Void)) -> NSObjectProtocol {
        return addObserver(name.rawValue, object: obj, queue: queue, block: block)
    }

    @discardableResult
    public func addObserver(_ name: String, object obj: Any? = nil, queue: OperationQueue? = OperationQueue.main, block: @escaping ((Notification) -> Void)) -> NSObjectProtocol {
        return addObserver(forName: NSNotification.Name(rawValue: name), object: obj, queue: queue, using: block)
    }
}
