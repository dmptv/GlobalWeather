import UIKit

class BasePresenter<O, I, R, V>: NSObject {
    let interactor: I?
    let router: R?
    private let viewWeakContainer: WeakContainer<V>
    private let moduleOutputWeakContainer: WeakContainer<O>?
    
    var view: V? {
        return viewWeakContainer.value
    }
    
    var moduleOutput: O? {
        return moduleOutputWeakContainer?.value
    }
    
    init(interactor: I?, router: R?, view: V, moduleOutput: O?) {
        self.interactor = interactor
        self.router = router
        self.viewWeakContainer = WeakContainer(value: view)
        if let moduleOutput = moduleOutput {
            moduleOutputWeakContainer = WeakContainer(value: moduleOutput)
        } else {
            moduleOutputWeakContainer = nil
        }
    }
        
    func viewDidLoad() { }
}

extension BasePresenter: ViewOutputProtocol {
    var moduleRoutable: BaseModuleRoutableProtocol? {
        return router as? BaseModuleRoutableProtocol
    }
    
    func didGoBack() {
        moduleRoutable?.goBackRouting()
    }
    
    func didClose() {
        moduleRoutable?.closeRouting()
    }
    
    func didGoBackOrClose() {
        moduleRoutable?.goBackOrCloseRouting()
    }
    
    func didRemove() {
        moduleRoutable?.removeRouting()
    }
}

