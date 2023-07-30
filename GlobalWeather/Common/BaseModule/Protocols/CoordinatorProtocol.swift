import UIKit

protocol CoordinatorProtocol: AnyObject, PresentableProtocol {
    var supportedInterfaceOrientations: UIInterfaceOrientationMask { get }
    var router: CoordinatorRouterProtocol { get }
    
    func start()
    func start(with option: DeepLinkOptionProtocol?)
    
    func addChild(_ coordinator: CoordinatorProtocol)
    func removeChild(_ coordinator: CoordinatorProtocol?)
    func removeChild(_ coordinator: CoordinatorProtocol?, _ preUpdateOrientationBlock: EmptyBlock?)
    
    func close()
    func goBack()
    
    func updateOrientationIfNeeded() -> UIInterfaceOrientationMask
}

extension CoordinatorProtocol {
    func toPresent() -> UIViewController? {
        return router.toPresent()
    }
    
    func removeChild(_ coordinator: CoordinatorProtocol?) {
        removeChild(coordinator, nil)
    }
}

protocol CoordinationExitPointProtocol: AnyObject {
    func performRouteForBackRouting(_ coordinator: CoordinatorProtocol)
    func performRouteForCloseRouting(_ coordinator: CoordinatorProtocol)
    func performModuleRemovedRouting(_ coordinator: CoordinatorProtocol)
    func performRouteForBackOrCloseRouting(_ coordinator: CoordinatorProtocol)
}

protocol FlowExitPointProtocol: CoordinationExitPointProtocol {
    
}
