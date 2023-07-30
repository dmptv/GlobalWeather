import UIKit

open class BaseCoordinatorRouter: NSObject, CoordinatorRouterProtocol {
    private var completions: [UIViewController: EmptyBlock] = [:]
    private var currentController: UIViewController?
    
    let rootViewController: UIViewController
    var didPresent = false
    
    init(_ rootViewController: UIViewController = BaseRouterController()) {
        self.rootViewController = rootViewController
        super.init()
        self.rootViewController.navigationController?.delegate = self
    }
    
    func showScreen(_ module: PresentableProtocol) {
        guard let viewController = module.toPresent() else {
            return
        }
        
        completions.forEach { $0.value.execute(()) }
        currentController?.view.removeFromSuperview()
        currentController?.removeFromParent()
        
        currentController = viewController
        rootViewController.addChildController(viewController, { view in
            view.fillSuperview()
        })
        rootViewController.setNeedsStatusBarAppearanceUpdate()
    }
    
    func push(_ module: PresentableProtocol, _ style: NavigationPushPopStyle, animated: Bool, hideBottomBar: Bool, completion: EmptyBlock?) {
        guard let controller = module.toPresent() else {
            return
        }
        guard controller is UINavigationController == false else {
            assertionFailure("Deprecated push UINavigationController.")
            return
        }
        
        if let completion = completion {
            completions[controller] = completion
        }
        
        controller.hidesBottomBarWhenPushed = hideBottomBar
        let navController = rootViewController as? UINavigationController ?? (rootViewController.navigationController ??
                                                                              (rootViewController.children.first as? UINavigationController))
        
        navController?.pushViewController(controller, animated: animated)
    }
    
    func popModule(style: NavigationPushPopStyle, animated: Bool)  {
        let navigationController = rootViewController.navigationController ??
        (rootViewController.children.first as? UINavigationController)
        if let controller = navigationController?.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }
    
    func popToFirstControllerInStack(style: NavigationPushPopStyle, animated: Bool) {
        let navigationController = rootViewController.navigationController ??
        (rootViewController.children.first as? UINavigationController)
        if let controllers = navigationController?.popToRootViewController(animated: animated) {
            controllers.forEach { runCompletion(for: $0) }
        }
    }
    
    func popToSpecificVC(bottomBound: Int, upperBound: Int) {
        let navigationController = rootViewController.navigationController ??
        (rootViewController.children.first as? UINavigationController)
        if var controllers = navigationController?.viewControllers,
           controllers.count >= upperBound, bottomBound <= upperBound {
            controllers.removeSubrange(bottomBound..<upperBound)
            navigationController?.viewControllers = controllers
        }
    }
    
    func leaveOnlyTopControllerInStack() {
        let navigationController = rootViewController.navigationController ??
        (rootViewController.children.first as? UINavigationController)
        if let controllers = navigationController?.viewControllers,
           controllers.count > 1,
           let topController = controllers.last {
            navigationController?.viewControllers = [topController]
        }
    }
    
    func setControllerInStack(_ module: PresentableProtocol, animated: Bool) {
        let navigationController = rootViewController.navigationController ??
        (rootViewController.children.first as? UINavigationController)
        if let toPresent = module.toPresent() {
            navigationController?.setViewControllers([toPresent], animated: animated)
        }
    }
    
    func replaceLastControllerWith(_ module: PresentableProtocol, animated: Bool) {
        guard let navigationController = rootViewController.navigationController ??
                (rootViewController.children.first as? UINavigationController),
              let toPresent = module.toPresent() else {
            assertionFailure("No navigationController found")
            return
        }
        var controllers = navigationController.viewControllers
        let lastController = controllers.removeLast()
        runCompletion(for: lastController)
        controllers.append(toPresent)
        navigationController.setViewControllers(Array(controllers), animated: animated)
    }
    
    func popToRootViewController(animated: Bool) {
        if let controllers = rootViewController.navigationController?.popToViewController(rootViewController, animated: animated) {
            controllers.forEach { runCompletion(for: $0) }
        }
    }
    
    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else {
            return
        }
        completion.execute(())
        completions.removeValue(forKey: controller)
    }
}

class BaseRouterController: UIViewController { }

// MARK: UINavigationController Delegate
extension BaseCoordinatorRouter: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool) {
        guard let poppedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
              !navigationController.viewControllers.contains(poppedViewController) else {
            return
        }
        
        runCompletion(for: poppedViewController)
    }
}
