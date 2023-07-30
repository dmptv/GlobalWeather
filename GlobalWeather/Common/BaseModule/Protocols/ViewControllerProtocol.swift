import UIKit

protocol ViewControllerProtocol: UIViewController { }
extension UIViewController: PresentableProtocol {
    func toPresent() -> UIViewController? {
        return self
    }
}
