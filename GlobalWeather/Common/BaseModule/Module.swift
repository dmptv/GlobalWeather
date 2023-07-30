import UIKit

struct Module<Input, Output>: PresentableProtocol {
    var view: UIViewController
    
    var input: Input
    var output: WeakContainer<Output>?
    
    init(view: UIViewController, input: Input, output: Output?) {
        self.view = view
        
        self.input = input
        if let output = output {
            self.output = WeakContainer(value: output)
        }
    }
    
    func toPresent() -> UIViewController? {
        return view
    }
}

