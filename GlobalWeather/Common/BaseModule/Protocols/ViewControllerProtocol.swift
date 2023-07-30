import UIKit

public protocol ViewControllerProtocol: UIViewController { }
extension UIViewController: PresentableProtocol {
    public func toPresent() -> UIViewController? {
        return self
    }
}
