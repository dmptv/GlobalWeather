import UIKit

extension UIViewController {
    func addChildController(_ viewController: UIViewController, _ constraintsBlock: (_ view: UIView) -> Void) {
        addChildController(viewController, view, constraintsBlock)
    }
    
    func addChildController(_ viewController: UIViewController, _ toView: UIView, _ constraintsBlock: (_ view: UIView) -> Void) {
        viewController.willMove(toParent: self)
        addChild(viewController)
        toView.addSubview(viewController.view)
        constraintsBlock(viewController.view)
        viewController.didMove(toParent: self)
    }
    
    func lastChild() -> UIViewController {
        guard let lastChildController = children.last else {
            return self
        }
        return lastChildController.lastChild()
    }

    func firstNavigationItem() -> UINavigationItem {
        if parent is UINavigationController {
            return self.navigationItem
        }
        return parent?.firstNavigationItem() ?? self.navigationItem
    }
    
    var isPushed: Bool {
        var firstParentInStack = self

        while !(firstParentInStack.parent is UINavigationController) && firstParentInStack.parent != nil  {
            firstParentInStack = firstParentInStack.parent ?? firstParentInStack
        }
        
        if let nav = firstParentInStack.parent as? UINavigationController,
           nav.children.first !== firstParentInStack {
            return true
        } else {
            return false
        }
    }
    
    /// A Boolean value that determines whether the view controller is first in its navigation stack
    var isRootViewController: Bool {
        self === navigationController?.viewControllers.first
    }
}


