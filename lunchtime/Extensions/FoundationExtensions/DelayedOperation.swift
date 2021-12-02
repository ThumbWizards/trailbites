import Foundation

class DelayedOperation: Operation {
    typealias VoidBlock = (() -> Void)

    private var timer: Timer?
    let seconds: TimeInterval
    let block: VoidBlock

    @objc dynamic private var internalExecuting = false
    override var isExecuting: Bool {
        return internalExecuting
    }

    init(after seconds: TimeInterval, block: @escaping VoidBlock) {
        self.seconds = seconds
        self.block = block

        super.init()
    }

    deinit {
        cancel()
    }

    override func main() {
        if isCancelled {
            return
        }

        internalExecuting = true

        timer = Timer(timeInterval: seconds,
                        target: self,
                        selector: #selector(DelayedOperation.performBlockAndFinish),
                        userInfo: nil,
                        repeats: false)

        guard let timer = timer else {
            cancel()
            return
        }

        RunLoop.current.add(timer, forMode: RunLoop.Mode.default)
    }

    @objc private func performBlockAndFinish() {
        if isCancelled {
            return
        }

        block()

        internalExecuting = false
    }

    override func cancel() {
        timer?.invalidate()
        timer = nil

        super.cancel()
    }
}

extension DelayedOperation {
    @objc dynamic private class func keyPathsForValuesAffectingIsExecuting() -> Set<String> {
        return ["internalExecuting"]
    }
}
