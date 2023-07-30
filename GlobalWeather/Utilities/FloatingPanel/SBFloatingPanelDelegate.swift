//
//  SBFloatingPanelDelegate.swift
//  GlobalWeather
//
//  Created by Kanat on 30.07.2023.
//

import FloatingPanel

protocol SBFloatingPanelProtocol: AnyObject {
    func floatingPanelDidEndRemove(_ floatingViewController: UIViewController)
    func floatingPanelDidEndDraggingToRemove(_ floatingViewController: UIViewController)
}

extension SBFloatingPanelProtocol {
    func floatingPanelDidEndDraggingToRemove(_ floatingViewController: UIViewController) {}
}

protocol SBFloatingPanelControllerDelegate: FloatingPanelControllerDelegate {
}

class SBFloatingPanelDelegate: NSObject, SBFloatingPanelControllerDelegate {
    weak var delegate: SBFloatingPanelProtocol?
    let positions: Set<FloatingPanelPosition>
    let basicPosition: FloatingPanelPosition
    
    init(positions: Set<FloatingPanelPosition>, basicPosition: FloatingPanelPosition, delegate: SBFloatingPanelProtocol? = nil) {
        self.positions = positions
        self.basicPosition = basicPosition
        self.delegate = delegate
        super.init()
    }
    
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        SBFloatingPanelLayout(positions: positions, basicPosition: basicPosition)
    }
    
    func floatingPanelDidEndRemove(_ vc: FloatingPanelController) {
        // TODO: - Implement removing coordinator from stack after dismissing
        delegate?.floatingPanelDidEndRemove(vc)
    }
}

class SBFloatingPanelIntrinsicLayoutDelegate: NSObject, SBFloatingPanelControllerDelegate {
    weak var delegate: SBFloatingPanelProtocol?
    
    init(delegate: SBFloatingPanelProtocol?) {
        self.delegate = delegate
        super.init()
    }
    
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        RemovablePanelLayout()
    }
    
    func floatingPanelDidEndRemove(_ vc: FloatingPanelController) {
        // TODO: - Implement removing coordinator from stack after dismissing
        delegate?.floatingPanelDidEndRemove(vc)
    }
    
    func floatingPanelDidEndDraggingToRemove(_ vc: FloatingPanelController, withVelocity velocity: CGPoint) {
        delegate?.floatingPanelDidEndDraggingToRemove(vc)
    }
}

class FloatingPanelDelegate: NSObject, FloatingPanelControllerDelegate {
    weak var delegate: SBFloatingPanelProtocol?
    let positions: Set<FloatingPanelPosition>
    let basicPosition: FloatingPanelPosition
    
    init(positions: Set<FloatingPanelPosition>, basicPosition: FloatingPanelPosition, delegate: SBFloatingPanelProtocol? = nil) {
        self.positions = positions
        self.basicPosition = basicPosition
        self.delegate = delegate
        super.init()
    }
    
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        SBFloatingPanelLayout(positions: positions, basicPosition: basicPosition)
    }
    
    func floatingPanelDidEndRemove(_ vc: FloatingPanelController) {
        // TODO: - Implement removing coordinator from stack after dismissing
        delegate?.floatingPanelDidEndRemove(vc)
    }
}

class FloatingPanelIntrinsicLayoutDelegate: NSObject, FloatingPanelControllerDelegate {
    weak var delegate: SBFloatingPanelProtocol?
    
    override init() {
        super.init()
    }
    
    init(delegate: SBFloatingPanelProtocol?) {
        self.delegate = delegate
        super.init()
    }
    
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        RemovablePanelLayout()
    }
    
    func floatingPanelDidEndRemove(_ vc: FloatingPanelController) {
        // TODO: - Implement removing coordinator from stack after dismissing
        delegate?.floatingPanelDidEndRemove(vc)
    }
}
