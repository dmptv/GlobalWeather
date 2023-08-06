
import UIKit

class BaseCompositeModuleRouter<ContainersHolder: ContainersHolderProtocol, ROUTINGHANDLER>: Router<ROUTINGHANDLER> {
    public weak var containersHolder: ContainersHolder?
    
    public init(viewController: ViewControllerProtocol, containersHolder: ContainersHolder) {
        super.init(viewController: viewController)
        self.containersHolder = containersHolder
    }
    
    public func showSubmodule(_ presentable: PresentableProtocol, _ container: UIView) {
        guard let viewControllerToPresent = presentable.toPresent(),
            let viewController = viewController else {
            return
        }
        viewControllerToPresent.willMove(toParent: viewController)
        viewController.addChild(viewControllerToPresent)
        container.addSubview(viewControllerToPresent.view)
        viewControllerToPresent.view.fillSuperview()
        viewControllerToPresent.didMove(toParent: viewController)
    }
    
    
    public func showSubmodule(_ presentable: PresentableProtocol, _ containerController: UIViewController) {
        guard let viewControllerToPresent = presentable.toPresent(),
            viewController != nil else {
            return
        }
        containerController.addChildController(viewControllerToPresent) { view in
            view.fillSuperview()
        }
    }
}


