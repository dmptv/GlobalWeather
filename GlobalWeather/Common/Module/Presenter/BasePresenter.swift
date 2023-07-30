import UIKit

open class BasePresenter<O, I, R, V>: NSObject {
    public let interactor: I?
    public let router: R?
    private let viewWeakContainer: WeakContainer<V>
    private let moduleOutputWeakContainer: WeakContainer<O>?
    
    public var view: V? {
        return viewWeakContainer.value
    }
    
    public var moduleOutput: O? {
        return moduleOutputWeakContainer?.value
    }
    
    public init(interactor: I?, router: R?, view: V, moduleOutput: O?) {
        self.interactor = interactor
        self.router = router
        self.viewWeakContainer = WeakContainer(value: view)
        if let moduleOutput = moduleOutput {
            moduleOutputWeakContainer = WeakContainer(value: moduleOutput)
        } else {
            moduleOutputWeakContainer = nil
        }
    }
        
    open func viewDidLoad() { }
}

extension BasePresenter: ViewOutputProtocol {
    public var moduleRoutable: BaseModuleRoutableProtocol? {
        return router as? BaseModuleRoutableProtocol
    }
    
    public func didGoBack() {
        moduleRoutable?.goBackRouting()
    }
    
    public func didClose() {
        moduleRoutable?.closeRouting()
    }
    
    public func didGoBackOrClose() {
        moduleRoutable?.goBackOrCloseRouting()
    }
    
    public func didRemove() {
        moduleRoutable?.removeRouting()
    }
}
