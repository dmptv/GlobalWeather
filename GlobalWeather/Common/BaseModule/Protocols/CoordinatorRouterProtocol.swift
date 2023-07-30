import UIKit
import FloatingPanel

enum NavigationPushPopStyle: UInt {
    case fade
    case standart
}

enum NavigationStyle: UInt {
    case present
    case push
}

protocol CoordinatorRouterProtocol: AnyObject {
    var rootViewController: UIViewController { get }
    var didPresent: Bool { get set }
    
    func showScreen(_ module: PresentableProtocol)
    
    func present(_ module: PresentableProtocol)
    func present(_ module: PresentableProtocol, style: UIModalPresentationStyle)
    func present(_ module: PresentableProtocol, animated: Bool, style: UIModalPresentationStyle)
    
    func presentFloating(_ module: PresentableProtocol, positions: Set<FloatingPanelPosition>, basicPosition: FloatingPanelPosition)
    func presentFloating(_ module: PresentableProtocol, positions: Set<FloatingPanelPosition>, basicPosition: FloatingPanelPosition, grabberHandleHidden: Bool)
    func presentFloating(_ module: PresentableProtocol, delegate: FloatingPanelControllerDelegate, grabberHandleHidden: Bool)
    func presentFloatingIntrinsicLayout(_ module: PresentableProtocol)
    func presentFloatingIntrinsicLayout(_ module: PresentableProtocol, grabberHandleHidden: Bool)
    func presentFloatingIntrinsicLayout(_ module: PresentableProtocol, grabberHandleHidden: Bool, delegate: FloatingPanelControllerDelegate)
    
    func push(_ module: PresentableProtocol)
    func push(_ module: PresentableProtocol, _ style: NavigationPushPopStyle)
    func push(_ module: PresentableProtocol, _ style: NavigationPushPopStyle, hideBottomBar: Bool)
    func push(_ module: PresentableProtocol, _ style: NavigationPushPopStyle, animated: Bool)
    func push(_ module: PresentableProtocol, _ style: NavigationPushPopStyle, animated: Bool, completion: EmptyBlock?)
    func push(_ module: PresentableProtocol, _ style: NavigationPushPopStyle, animated: Bool, hideBottomBar: Bool, completion: EmptyBlock?)
    
    func popModule()
    func popModule(animated: Bool)
    func popModule(style: NavigationPushPopStyle, animated: Bool)
    
    func dismissModule()
    func dismissModule(animated: Bool, completion: EmptyBlock?)
    
    func popToFirstControllerInStack(animated: Bool)
    func popToFirstControllerInStack(style: NavigationPushPopStyle, animated: Bool)
    func popToRootViewController(animated: Bool)
    func popToSpecificVC(bottomBound: Int, upperBound: Int)
    
    func leaveOnlyTopControllerInStack()
    func setControllerInStack(_ module: PresentableProtocol, animated: Bool)
    func replaceLastControllerWith(_ module: PresentableProtocol, animated: Bool)
}

extension CoordinatorRouterProtocol {
    func present(_ module: PresentableProtocol)  {
        present(module, style: .overFullScreen)
    }
    
    func present(_ module: PresentableProtocol, style: UIModalPresentationStyle) {
        present(module, animated: true, style: style)
    }
    
    func presentFloating(_ module: PresentableProtocol, positions: Set<FloatingPanelPosition>, basicPosition: FloatingPanelPosition, grabberHandleHidden: Bool) {
        guard let contentVC = module.toPresent() else {
            return
        }
        let delegate = FloatingPanelDelegate(positions: positions, basicPosition: basicPosition)
        let fpc = FloatingPanelController(delegate: delegate)
        fpc.surfaceView.contentInsets = UIEdgeInsets(top: 27, left: 0, bottom: 0, right: 0)
        fpc.surfaceView.roundCorners(corners: [.topLeft, .topRight], radius: 20)
        fpc.surfaceView.clipsToBounds = true
        fpc.surfaceView.grabberHandle.isHidden = grabberHandleHidden
        fpc.set(contentViewController: contentVC)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            fpc.delegate = delegate
        }
        fpc.isRemovalInteractionEnabled = true // Optional: Let it removable by a swipe-down
        present(fpc, animated: true, style: .custom)
    }
    
    func presentFloating(_ module: PresentableProtocol, positions: Set<FloatingPanelPosition>, basicPosition: FloatingPanelPosition) {
        presentFloating(module, positions: positions, basicPosition: basicPosition, grabberHandleHidden: true)
    }
    
    func presentFloating(_ module: PresentableProtocol, delegate: FloatingPanelControllerDelegate, grabberHandleHidden: Bool) {
        guard let contentVC = module.toPresent() else {
            return
        }
        let fpc = FloatingPanelController(delegate: delegate)
        fpc.surfaceView.contentInsets = UIEdgeInsets(top: 27, left: 0, bottom: 0, right: 0)
        fpc.surfaceView.roundCorners(corners: [.topLeft, .topRight], radius: 20)
        fpc.surfaceView.clipsToBounds = true
        fpc.surfaceView.grabberHandle.isHidden = grabberHandleHidden
        fpc.set(contentViewController: contentVC)
        fpc.isRemovalInteractionEnabled = true // Optional: Let it removable by a swipe-down
        present(fpc, animated: true, style: .custom)
    }
    
    func presentFloatingIntrinsicLayout(_ module: PresentableProtocol) {
        presentFloatingIntrinsicLayout(module, grabberHandleHidden: true)
    }
    
    func presentFloatingIntrinsicLayout(_ module: PresentableProtocol, grabberHandleHidden: Bool) {
        let delegate = FloatingPanelIntrinsicLayoutDelegate()
        presentFloatingIntrinsicLayout(module, grabberHandleHidden: grabberHandleHidden, delegate: delegate)
    }
    
    func presentFloatingIntrinsicLayout(_ module: PresentableProtocol, grabberHandleHidden: Bool, delegate: FloatingPanelControllerDelegate) {
        guard let contentVC = module.toPresent() else {
            return
        }
        let fpc = FloatingPanelController(delegate: delegate)
        fpc.surfaceView.contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        fpc.surfaceView.roundCorners(corners: [.topLeft, .topRight], radius: 20)
        fpc.surfaceView.clipsToBounds = true
        fpc.surfaceView.grabberHandle.isHidden = grabberHandleHidden
        fpc.set(contentViewController: contentVC)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            fpc.delegate = delegate
        }
        fpc.isRemovalInteractionEnabled = true // Optional: Let it removable by a swipe-down
        present(fpc, animated: true, style: .custom)
    }
    
    func present(_ module: PresentableProtocol, animated: Bool, style: UIModalPresentationStyle) {
        guard let controller = module.toPresent() else {
            return
        }
        controller.modalPresentationStyle = style
        
        var presentingViewController: UIViewController = rootViewController
        while let nextPresentedController = presentingViewController.presentedViewController {
            presentingViewController = nextPresentedController
        }
        
        presentingViewController.present(controller, animated: animated, completion: nil)
        rootViewController.setNeedsStatusBarAppearanceUpdate()
        didPresent = true
    }
    
    func dismissModule() {
        dismissModule(animated: true, completion: nil)
    }
    
    func dismissModule(animated: Bool, completion: EmptyBlock?) {
        //        if #available(iOS 13, *) {
        //            rootViewController.dismiss(animated: animated, completion: { completion?.execute(()) })
        //        } else {
        //            if rootViewController.presentingViewController != nil {
        //                rootViewController.dismiss(animated: animated, completion: { completion?.execute(()) })
        //            } else {
        //                completion?.execute(())
        //            }
        //        }
        rootViewController.dismiss(animated: animated, completion: { completion?.execute(()) })
    }
    
    func push(_ module: PresentableProtocol)  {
        push(module, .standart, animated: true)
    }
    
    func push(_ module: PresentableProtocol, _ style: NavigationPushPopStyle)  {
        push(module, style, animated: true)
    }
    
    func push(_ module: PresentableProtocol, _ style: NavigationPushPopStyle, hideBottomBar: Bool)  {
        push(module, style, animated: true, hideBottomBar: hideBottomBar, completion: nil)
    }
    
    func push(_ module: PresentableProtocol, _ style: NavigationPushPopStyle, animated: Bool)  {
        push(module, style, animated: animated, completion: nil)
    }
    
    func push(_ module: PresentableProtocol, _ style: NavigationPushPopStyle, animated: Bool, completion: EmptyBlock?) {
        push(module, style, animated: animated, hideBottomBar: false, completion: completion)
    }
    
    func popModule() {
        popModule(animated: true)
    }
    
    func popModule(animated: Bool) {
        popModule(style: .standart, animated: animated)
    }
    
    func popToFirstControllerInStack(animated: Bool) {
        popToFirstControllerInStack(style: .standart, animated: animated)
    }
    
    func popToSpecificVC(bottomBound: Int, upperBound: Int) {
        popToSpecificVC(bottomBound: bottomBound, upperBound: upperBound)
    }
    
    // MARK: PresentableProtocol
    func toPresent() -> UIViewController? {
        return rootViewController
    }
}
