import UIKit

public protocol DeviceServiceProtocol {
    var guid: String { get }
    var orientation: UIDeviceOrientation { get }
    
    func updateOrientationIfNeeded(_ orientation: UIDeviceOrientation)
}

public class DeviceService: DeviceServiceProtocol {
    public init() { }
    
    public var guid: String {
        UIDevice.current.identifierForVendor?.uuidString ?? "no_guid"
    }
    
    public var orientation: UIDeviceOrientation {
        UIDevice.current.orientation
    }
    
    public func updateOrientationIfNeeded(_ orientation: UIDeviceOrientation) {
        UIDevice.current.setValue(orientation.rawValue, forKey: "orientation")
    }
}

public protocol DeviceServiceLocatorProtocol {
    func deviceService() -> DeviceServiceProtocol
}

public extension DeviceServiceLocatorProtocol {
    func deviceService() -> DeviceServiceProtocol {
        DeviceService()
    }
}

