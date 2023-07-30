import UIKit
import FloatingPanel

public protocol BaseModuleRoutableProtocol {
    var viewController: ViewControllerProtocol? { get }
    
    func goBackRouting()
    func closeRouting()
    func goBackOrCloseRouting()
    func removeRouting()
}

open class Router<ROUTINGHANDLER>: BaseModuleRoutableProtocol {
    private var moduleRoutingHandlerWeakContainer: WeakContainer<ROUTINGHANDLER>?
    public var moduleRoutingHandler: ROUTINGHANDLER? {
        get {
            moduleRoutingHandlerWeakContainer?.value
        } set {
            if let value = newValue {
                moduleRoutingHandlerWeakContainer = WeakContainer(value: value)
            } else {
                moduleRoutingHandlerWeakContainer = nil
            }
        }
    }
    
    public weak var viewController: ViewControllerProtocol?
    
    deinit {
        (moduleRoutingHandler as? ModuleRoutingHandlingProtocol)?.performModuleRemovedRouting()
    }
    
    public init(viewController: ViewControllerProtocol?) {
        self.viewController = viewController
    }
    
    public func presentFloating(_ module: PresentableProtocol, positions: Set<FloatingPanelPosition>, basicPosition: FloatingPanelPosition) {
        guard let contentVC = module.toPresent() else {
            return
        }
        let delegate = FloatingPanelDelegate(positions: positions, basicPosition: basicPosition)
        let fpc = FloatingPanelController(delegate: delegate)
        fpc.surfaceView.contentInsets = UIEdgeInsets(top: 27, left: 0, bottom: 0, right: 0)
        fpc.surfaceView.roundCorners(corners: [.topLeft, .topRight], radius: 20)
        fpc.surfaceView.clipsToBounds = true
        fpc.surfaceView.grabberHandle.isHidden = true
        fpc.set(contentViewController: contentVC)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            fpc.delegate = delegate
        }
        fpc.isRemovalInteractionEnabled = true // Optional: Let it removable by a swipe-down
        present(fpc, animated: true, style: .custom)
    }
    
    public func presentFloatingIntrinsicLayout(_ module: PresentableProtocol) {
        guard let contentVC = module.toPresent() else {
            return
        }
        let delegate = FloatingPanelIntrinsicLayoutDelegate()
        let fpc = FloatingPanelController(delegate: delegate)
        fpc.surfaceView.contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        fpc.surfaceView.roundCorners(corners: [.topLeft, .topRight], radius: 20)
        fpc.surfaceView.clipsToBounds = true
        fpc.surfaceView.grabberHandle.isHidden = true
        fpc.set(contentViewController: contentVC)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            fpc.delegate = delegate
        }
        fpc.isRemovalInteractionEnabled = true // Optional: Let it removable by a swipe-down
        present(fpc, animated: true, style: .custom)
    }
    
    public func present(_ module: PresentableProtocol, animated: Bool, style: UIModalPresentationStyle) {
        guard let controller = module.toPresent() else {
            return
        }
        controller.modalPresentationStyle = style
        
        var presentingViewController: UIViewController? = viewController
        while let nextPresentedController = presentingViewController?.presentedViewController {
            presentingViewController = nextPresentedController
        }
        
        presentingViewController?.present(controller, animated: animated, completion: nil)
        viewController?.setNeedsStatusBarAppearanceUpdate()
    }
}

public extension Router {
    func goBackRouting() {
        (moduleRoutingHandler as? ModuleRoutingHandlingProtocol)?.performRouteForBackRouting()
    }
    
    func closeRouting() {
        (moduleRoutingHandler as? ModuleRoutingHandlingProtocol)?.performRouteForCloseRouting()
    }
    
    func goBackOrCloseRouting() {
        (moduleRoutingHandler as? ModuleRoutingHandlingProtocol)?.performRouteForBackOrCloseRouting()
    }
    
    func removeRouting() {
        (moduleRoutingHandler as? ModuleRoutingHandlingProtocol)?.performModuleRemovedRouting()
    }
}

extension Router: PresentableProtocol {
    public func toPresent() -> UIViewController? {
        return viewController
    }
}
