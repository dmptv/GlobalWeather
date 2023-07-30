import UIKit

protocol DeviceServiceProtocol {
    var guid: String { get }
    var orientation: UIDeviceOrientation { get }
    
    func updateOrientationIfNeeded(_ orientation: UIDeviceOrientation)
}

class DeviceService: DeviceServiceProtocol {
    init() { }
    
    var guid: String {
        UIDevice.current.identifierForVendor?.uuidString ?? "no_guid"
    }
    
    var orientation: UIDeviceOrientation {
        UIDevice.current.orientation
    }
    
    func updateOrientationIfNeeded(_ orientation: UIDeviceOrientation) {
        UIDevice.current.setValue(orientation.rawValue, forKey: "orientation")
    }
}

protocol DeviceServiceLocatorProtocol {
    func deviceService() -> DeviceServiceProtocol
}

extension DeviceServiceLocatorProtocol {
    func deviceService() -> DeviceServiceProtocol {
        DeviceService()
    }
}

