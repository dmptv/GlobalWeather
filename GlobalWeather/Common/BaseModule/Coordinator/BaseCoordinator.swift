import UIKit

open class BaseCoordinator<EXITPOINT>: CoordinatorProtocol {
    typealias ServiceLocatorAlias = DeviceServiceLocatorProtocol
    final class ServiceLocator: ServiceLocatorAlias { }
    
    private let device: DeviceServiceProtocol = ServiceLocator().deviceService()
    
    let router: CoordinatorRouterProtocol
    var childCoordinators: [CoordinatorProtocol] = []
    
    private var coordinationExitPointWeakContainer: WeakContainer<EXITPOINT>?
    var coordinationExitPoint: EXITPOINT? {
        get { coordinationExitPointWeakContainer?.value }
        set {
            guard let value = newValue else {
                coordinationExitPointWeakContainer = nil
                return
            }
            coordinationExitPointWeakContainer = WeakContainer(value: value)
        }
    }
    
    private var prevInterfaceOrientations: UIInterfaceOrientationMask?
    var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
    
    init(router: CoordinatorRouterProtocol) {
        self.router = router
    }
    
    func start(with option: DeepLinkOptionProtocol?) {
        
    }
    
    open func start() {
        start(with: nil)
    }
    
    func close() {
        performRouteForCloseRouting()
    }
    
    func goBack() {
        performRouteForBackRouting()
    }
    
    // add only unique object
    func addChild(_ coordinator: CoordinatorProtocol) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else {
            return
        }
        childCoordinators.append(coordinator)
        updateOrientation()
    }
    
    func removeChild(_ coordinator: CoordinatorProtocol?,
                            _ preUpdateOrientationBlock: EmptyBlock?) {
        guard childCoordinators.isEmpty == false, let coordinator = coordinator else {
            return
        }
        
        // Clear child-coordinators recursively
        if let coordinator = coordinator as? BaseCoordinator, !coordinator.childCoordinators.isEmpty {
            coordinator.childCoordinators.filter({ $0 !== coordinator }).forEach({ coordinator.removeChild($0) })
        }
        
        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
        
        prevInterfaceOrientations = nil
        
        preUpdateOrientationBlock?.execute(())
        updateOrientation()
    }
    
    func updateOrientationIfNeeded() -> UIInterfaceOrientationMask {
        defer {
            updateOrientation()
        }
        
        return supportedInterfaceOrientations
    }
    
    private func updateOrientation() {
        switch supportedInterfaceOrientations {
        case .landscapeLeft, .landscapeRight, .landscape:
            guard let prevOrientation = prevInterfaceOrientations else {
                device.updateOrientationIfNeeded(.landscapeLeft)
                return
            }
            
            let shouldRotate = !((UIDevice.current.orientation == .portrait ||
                UIDevice.current.orientation == .portraitUpsideDown) &&
                    (prevOrientation == .landscapeLeft ||
                        prevOrientation == .landscapeRight ||
                        prevOrientation == .landscape))
            
            guard shouldRotate else  {
                return
            }
            if UIDevice.current.orientation == .landscapeRight {
                device.updateOrientationIfNeeded(.landscapeRight)
            } else {
                device.updateOrientationIfNeeded(.landscapeLeft)
            }
        case .portrait:
            device.updateOrientationIfNeeded(.portrait)
        default:
            break
        }
        prevInterfaceOrientations = supportedInterfaceOrientations
    }
    
    // MARK: Remove after moving to modules
    func resetPrevOrientation() {
        prevInterfaceOrientations = nil
    }
}

extension BaseCoordinator: ModuleRoutingHandlingProtocol {
    func performRouteForCloseRouting() {
        (coordinationExitPoint as? CoordinationExitPointProtocol)?.performRouteForCloseRouting(self)
    }
    
    func performModuleRemovedRouting() {
        (coordinationExitPoint as? CoordinationExitPointProtocol)?.performModuleRemovedRouting(self)
    }
    
    func performRouteForBackRouting() {
        (coordinationExitPoint as? CoordinationExitPointProtocol)?.performRouteForBackRouting(self)
    }
    
    func performRouteForBackOrCloseRouting() {
        (coordinationExitPoint as? CoordinationExitPointProtocol)?.performRouteForBackOrCloseRouting(self)
    }
}
