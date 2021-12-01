import Foundation

public extension OperationQueue {
    @objc func addOperationWithBlockAndWait(_ block: @escaping () -> Void) {
        addOperation(block)
        waitUntilAllOperationsAreFinished()
    }

    @discardableResult
    @objc func addOperation(delay: TimeInterval, block: @escaping (() -> Void)) -> Operation {
        let operation = DelayedOperation(after: delay, block: block)
        addOperation(operation)
        return operation
    }
}
