//
//  SBFloatingPanelDelegate.swift
//  GlobalWeather
//
//  Created by Kanat on 30.07.2023.
//

import FloatingPanel

public protocol SBFloatingPanelProtocol: class {
    func floatingPanelDidEndRemove(_ floatingViewController: UIViewController)
    func floatingPanelDidEndDraggingToRemove(_ floatingViewController: UIViewController)
}

public extension SBFloatingPanelProtocol {
    public func floatingPanelDidEndDraggingToRemove(_ floatingViewController: UIViewController) {}
}

public protocol SBFloatingPanelControllerDelegate: FloatingPanelControllerDelegate {
}

public class SBFloatingPanelDelegate: NSObject, SBFloatingPanelControllerDelegate {
    public weak var delegate: SBFloatingPanelProtocol?
    let positions: Set<FloatingPanelPosition>
    let basicPosition: FloatingPanelPosition
    
    public init(positions: Set<FloatingPanelPosition>, basicPosition: FloatingPanelPosition, delegate: SBFloatingPanelProtocol? = nil) {
        self.positions = positions
        self.basicPosition = basicPosition
        self.delegate = delegate
        super.init()
    }
    
    public func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        SBFloatingPanelLayout(positions: positions, basicPosition: basicPosition)
    }
    
    public func floatingPanelDidEndRemove(_ vc: FloatingPanelController) {
        // TODO: - Implement removing coordinator from stack after dismissing
        delegate?.floatingPanelDidEndRemove(vc)
    }
}

public class SBFloatingPanelIntrinsicLayoutDelegate: NSObject, SBFloatingPanelControllerDelegate {
    public weak var delegate: SBFloatingPanelProtocol?
    
    public init(delegate: SBFloatingPanelProtocol?) {
        self.delegate = delegate
        super.init()
    }
    
    public func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        RemovablePanelLayout()
    }
    
    public func floatingPanelDidEndRemove(_ vc: FloatingPanelController) {
        // TODO: - Implement removing coordinator from stack after dismissing
        delegate?.floatingPanelDidEndRemove(vc)
    }
    
    public func floatingPanelDidEndDraggingToRemove(_ vc: FloatingPanelController, withVelocity velocity: CGPoint) {
        delegate?.floatingPanelDidEndDraggingToRemove(vc)
    }
}

public class FloatingPanelDelegate: NSObject, FloatingPanelControllerDelegate {
    public weak var delegate: SBFloatingPanelProtocol?
    let positions: Set<FloatingPanelPosition>
    let basicPosition: FloatingPanelPosition
    
    public init(positions: Set<FloatingPanelPosition>, basicPosition: FloatingPanelPosition, delegate: SBFloatingPanelProtocol? = nil) {
        self.positions = positions
        self.basicPosition = basicPosition
        self.delegate = delegate
        super.init()
    }
    
    public func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        SBFloatingPanelLayout(positions: positions, basicPosition: basicPosition)
    }
    
    public func floatingPanelDidEndRemove(_ vc: FloatingPanelController) {
        // TODO: - Implement removing coordinator from stack after dismissing
        delegate?.floatingPanelDidEndRemove(vc)
    }
}

public class FloatingPanelIntrinsicLayoutDelegate: NSObject, FloatingPanelControllerDelegate {
    public weak var delegate: SBFloatingPanelProtocol?
    
    public override init() {
        super.init()
    }
    
    public init(delegate: SBFloatingPanelProtocol?) {
        self.delegate = delegate
        super.init()
    }
    
    public func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        RemovablePanelLayout()
    }
    
    public func floatingPanelDidEndRemove(_ vc: FloatingPanelController) {
        // TODO: - Implement removing coordinator from stack after dismissing
        delegate?.floatingPanelDidEndRemove(vc)
    }
}
