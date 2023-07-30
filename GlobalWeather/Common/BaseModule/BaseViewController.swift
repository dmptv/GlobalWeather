import UIKit
import SkeletonView

public enum ViewDataState {
    case loading
    case loaded
    case error(Error)
}

public protocol BaseViewInput: class {
    func updateState(_ state: ViewDataState)
    func updateSkeleton(_ state: ViewDataState)
}

open class BaseViewController: UIViewController, ViewControllerProtocol {
    open var isShowNavigationBar = true
    open var isHidesBarsOnSwipe = false
    private let loadingIndicator = LoaderView()
    
    public init() {
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    open func updateState(_ state: ViewDataState) {
        switch state {
        case .loaded, .error:
            loadingIndicator.stopAnimation()
        case .loading:
            let view: UIView = navigationController?.view ?? self.view
            loadingIndicator.startAnimation(in: view)
        }
    }
    
    public func updateSkeleton(_ state: ViewDataState) {
        switch state {
        case .loaded, .error:
            view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
        case .loading:
            let lavenderColor = UIColor(red: 240/255, green: 242/255, blue: 255/255, alpha: 1)
            let anim = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
            view.showAnimatedGradientSkeleton(usingGradient: SkeletonGradient(baseColor: lavenderColor), animation: anim, transition: .crossDissolve(0.25))
        }
    }
}

private extension BaseViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove(_ child: UIViewController) {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
