
import UIKit

protocol ModuleRoutingHandlingProtocol: AnyObject {
    func performRouteForBackRouting()
    func performRouteForCloseRouting()
    func performModuleRemovedRouting()
    func performRouteForBackOrCloseRouting()
}
