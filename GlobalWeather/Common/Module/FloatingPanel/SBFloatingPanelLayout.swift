//
//  SBFloatingPanelLayout.swift
//  GlobalWeather
//
//  Created by Kanat on 30.07.2023.
//

import FloatingPanel

public protocol SBFloatingPanelLayoutProtocol {
    
}

public class SBFloatingPanelLayout: SBFloatingPanelLayoutProtocol, FloatingPanelLayout {
    let basicPosition: FloatingPanelPosition
    let positions: Set<FloatingPanelPosition>
    
    public init(positions: Set<FloatingPanelPosition>, basicPosition: FloatingPanelPosition) {
        self.positions = positions
        self.basicPosition = basicPosition
    }
    
    public var initialPosition: FloatingPanelPosition {
        return basicPosition
    }
    
    public var supportedPositions: Set<FloatingPanelPosition> {
        return positions
    }
    
    public func backdropAlphaFor(position: FloatingPanelPosition) -> CGFloat {
        switch position {
        case .full: return 0.9
        case .half: return 0.48
        case .tip: return 0.2
        default: return 0 // Or `case .hidden: return nil`
        }
    }
    
    public func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        let screenHeight = UIScreen.main.bounds.height
        switch position {
        case .full: return 16.0 // A top inset from safe area
        case .half: return screenHeight * 0.73 // A bottom inset from the safe area
        case .tip: return 44.0 // A bottom inset from the safe area
        default: return nil // Or `case .hidden: return nil`
        }
    }
}

public class RemovablePanelLayout: FloatingPanelIntrinsicLayout {
    public init() {}
    
    public var supportedPositions: Set<FloatingPanelPosition> {
        return [.full]
    }
    
    public func backdropAlphaFor(position: FloatingPanelPosition) -> CGFloat {
        switch position {
        case .full: return 0.48
        case .half: return 0.2
        case .tip: return 0.2
        default: return 0 // Or `case .hidden: return nil`
        }
    }
}
