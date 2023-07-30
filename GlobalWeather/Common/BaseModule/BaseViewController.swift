import UIKit
import SkeletonView

enum ViewDataState {
    case loading
    case loaded
    case error(Error)
}

protocol BaseViewInput: AnyObject {
    func updateState(_ state: ViewDataState)
    func updateSkeleton(_ state: ViewDataState)
}

class BaseViewController: UIViewController, ViewControllerProtocol {
    var isShowNavigationBar = true
    var isHidesBarsOnSwipe = false
    private let loadingIndicator = LoaderView()
    
    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func updateState(_ state: ViewDataState) {
        switch state {
        case .loaded, .error:
            loadingIndicator.stopAnimation()
        case .loading:
            let view: UIView = navigationController?.view ?? self.view
            loadingIndicator.startAnimation(in: view)
        }
    }
    
    func updateSkeleton(_ state: ViewDataState) {
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
