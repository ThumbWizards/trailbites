import Foundation

public extension OperationQueue {
    @objc static var `default`: OperationQueue {
        let queue = OperationQueue()
        queue.qualityOfService = .default
        return queue
    }

    @objc static var userInitiated: OperationQueue {
        let queue = OperationQueue()
        queue.qualityOfService = .userInitiated
        return queue
    }

    @objc static var background: OperationQueue {
        let queue = OperationQueue()
        queue.qualityOfService = .background
        return queue
    }
}
