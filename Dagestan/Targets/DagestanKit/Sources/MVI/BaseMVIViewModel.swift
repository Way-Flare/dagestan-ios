import Foundation

open class BaseMviViewModel<StateType: MVIStatable>: StateHolderable, MVIInteractionable {
    private let queue = DispatchQueue(label: "viewModelQueue", attributes: .concurrent)

    public func reduce(call: @escaping (StateType) -> StateType) {
        queue.async(flags: .barrier) {
            guard let currentState = self.state else {
                preconditionFailure("Invalid current state")
            }

            let bufferState = call(currentState)
            DispatchQueue.main.async { self.state = bufferState }
        }
    }

    public private(set) var state: StateType? {
        willSet {
            guard state != newValue else { return }

            queue.sync {
                objectWillChange.send()
            }
        }
    }

    open func performInstall() {
        if state == nil {
            self.state = createInitialState()
        }

        install()
    }

    open func install() {}

    open func createInitialState() -> StateType {
        preconditionFailure("createInitialState() must be implemented by ancestors")
    }

    public func performUninstall() {
        uninstall()
    }

    open func uninstall() {}

    public init() {}
}
