import UIKit

open class BaseFlowCoordinator<EXITPOINT>: BaseCoordinator<EXITPOINT>, FlowExitPointProtocol {
    func performRouteForCloseRouting(_ coordinator: CoordinatorProtocol) {
        removeChild(coordinator, EmptyBlock {
            coordinator.router.dismissModule()
        })
    }
    
    func performModuleRemovedRouting(_ coordinator: CoordinatorProtocol) {
        removeChild(coordinator)
    }
    
    func performRouteForBackRouting(_ coordinator: CoordinatorProtocol) {
        removeChild(coordinator, EmptyBlock {
            coordinator.router.popModule(animated: true)
        })
    }
    
    func performRouteForBackOrCloseRouting(_ coordinator: CoordinatorProtocol) {
        removeChild(coordinator, EmptyBlock {
            let vc = coordinator.router.rootViewController
            let isRoot = vc.isRootViewController
            if isRoot {
                coordinator.router.dismissModule()
            } else {
                coordinator.router.popModule(animated: true)
            }
        })
    }
}
