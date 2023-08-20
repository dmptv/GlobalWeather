

import UIKit

protocol ViewOutputProtocol: AnyObject {
    func viewDidLoad()
    
    func didGoBack()
    func didClose()
    func didGoBackOrClose()
    func didRemove()
}
