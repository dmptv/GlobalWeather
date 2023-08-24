import UIKit

enum LayoutConstraintType {
    case top
    case bottom
    case left
    case right
    case centerX
    case centerY
}

typealias LayoutConstraints = [LayoutConstraintType: NSLayoutConstraint]

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            clipsToBounds = true
            layer.cornerRadius = radius
            var cornerMask: CACornerMask = []
            if corners.contains(.topLeft) {
                cornerMask.insert(.layerMinXMinYCorner)
            }
            if corners.contains(.topRight) {
                cornerMask.insert(.layerMaxXMinYCorner)
            }
            if corners.contains(.bottomLeft) {
                cornerMask.insert(.layerMinXMaxYCorner)
            }
            if corners.contains(.bottomRight) {
                cornerMask.insert(.layerMaxXMaxYCorner)
            }
            layer.maskedCorners = cornerMask
        } else {
            let rectShape = CAShapeLayer()
            rectShape.bounds = frame
            rectShape.position = center
            rectShape.path = UIBezierPath(roundedRect: bounds,
                                          byRoundingCorners: corners,
                                          cornerRadii: CGSize(width: radius, height: radius)).cgPath
            layer.mask = rectShape
        }
    }
    
    @discardableResult
    func fillSuperview(_ edgeInsets: UIEdgeInsets = .zero) -> LayoutConstraints {
        var constraints = fillVerticallySuperview(edgeInsets.top, edgeInsets.bottom)
        let horizontalConstraints = fillHorizontallySuperview(edgeInsets.left, edgeInsets.right)
        for (key, value) in horizontalConstraints {
            constraints[key] = value
        }
        return constraints
    }

    @discardableResult
    func fillVerticallySuperview(_ topOffset: CGFloat = 0,
                                 _ bottomOffset: CGFloat = 0) -> LayoutConstraints {
        return [
            .top: topToSuperView(offset: topOffset),
            .bottom: bottomToSuperView(offset: bottomOffset)
        ]
    }

    @discardableResult
    func fillHorizontallySuperview(_ leftOffset: CGFloat = 0,
                                   _ rightOffset: CGFloat = 0) -> LayoutConstraints {
        return [
            .left: leftToSuperView(offset: leftOffset),
            .right: rightToSuperView(offset: rightOffset)
        ]
    }

    @discardableResult
    func height(_ height: CGFloat) -> NSLayoutConstraint {
        return addConstraint(attribute: .height,
                             toView: nil,
                             viewToAddConstraint: nil,
                             toViewAttribute: .height,
                             offset: height)
    }
    
    @discardableResult
    func heightEqual(_ view: UIView) -> NSLayoutConstraint {
        addConstraint(attribute: .height,
                      toView: view,
                      viewToAddConstraint: nil,
                      toViewAttribute: .height,
                      offset: 0)
    }

    @discardableResult
    func width(_ width: CGFloat) -> NSLayoutConstraint {
        return addConstraint(attribute: .width,
                             toView: nil,
                             viewToAddConstraint: nil,
                             toViewAttribute: .width,
                             offset: width)
    }
    
    @discardableResult
    func widthEqual(_ view: UIView) -> NSLayoutConstraint {
        addConstraint(attribute: .width,
                      toView: view,
                      viewToAddConstraint: nil,
                      toViewAttribute: .width,
                      offset: 0)
    }
    
    @discardableResult
    func aspect(_ aspect: CGFloat) -> NSLayoutConstraint {
        return addConstraint(attribute: .height,
                             toView: nil,
                             viewToAddConstraint: nil,
                             toViewAttribute: .width,
                             offset: 0.0,
                             multiplier: aspect)
    }

    @discardableResult
    func centerInSuperview(_ offset: CGFloat = 0) -> LayoutConstraints {
        return center(superview, offset)
    }

    @discardableResult
    func center(_ toView: UIView?, _ offset: CGFloat = 0) -> LayoutConstraints {
        return [
            .centerY: centerY(toView: toView, offset),
            .centerX: centerX(toView: toView, offset)
        ]
    }

    @discardableResult
    func centerYInSuperview(_ offset: CGFloat = 0) -> NSLayoutConstraint {
        return centerY(toView: superview, offset)
    }

    @discardableResult
    func centerY(toView: UIView?, _ offset: CGFloat = 0) -> NSLayoutConstraint {
        return addConstraint(attribute: .centerY,
                             toView: toView,
                             viewToAddConstraint: superview,
                             toViewAttribute: .centerY,
                             offset: offset)
    }

    @discardableResult
    func centerXInSuperview(_ offset: CGFloat = 0) -> NSLayoutConstraint {
        return centerX(toView: superview, offset)
    }

    @discardableResult
    func centerX(toView: UIView?, _ offset: CGFloat = 0) -> NSLayoutConstraint {
        return addConstraint(attribute: .centerX,
                             toView: toView,
                             viewToAddConstraint: superview,
                             toViewAttribute: .centerX,
                             offset: offset)
    }

    @discardableResult
    func leftToRight(view: UIView,
                     offset: CGFloat = 0,
                     relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        return addConstraint(attribute: .left,
                             toView: view,
                             viewToAddConstraint: superview,
                             toViewAttribute: .right,
                             offset: offset,
                             relation: relation)
    }

    @discardableResult
    func leftToSuperView(offset: CGFloat = 0,
                         relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        return left(view: superview, offset: offset, relation: relation)
    }
    
    @discardableResult
    func leftToSafeArea(offset: CGFloat = 0,
                        relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        left(view: superview, offset: offset, relation: relation, toSafeArea: true)
    }

    @discardableResult
    func left(view: UIView?,
              offset: CGFloat = 0,
              relation: NSLayoutConstraint.Relation = .equal,
              toSafeArea: Bool = false) -> NSLayoutConstraint {
        return addConstraint(attribute: .left,
                             toView: view,
                             viewToAddConstraint: superview,
                             toViewAttribute: .left,
                             offset: offset,
                             relation: relation,
                             toSafeArea: toSafeArea)
    }

    @discardableResult
    func rightToLeft(view: UIView,
                     offset: CGFloat = 0,
                     relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        return addConstraint(attribute: .right,
                             toView: view,
                             viewToAddConstraint: superview,
                             toViewAttribute: .left,
                             offset: offset,
                             relation: relation)
    }

    @discardableResult
    func rightToSuperView(offset: CGFloat = 0,
                          relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        return right(view: superview, offset: offset, relation: relation)
    }
    
    @discardableResult
    func rightToSafeArea(offset: CGFloat = 0,
                         relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        right(view: superview,
              offset: offset,
              relation: relation,
              toSafeArea: true)
    }

    @discardableResult
    func right(view: UIView?,
               offset: CGFloat = 0,
               relation: NSLayoutConstraint.Relation = .equal,
               toSafeArea: Bool = false) -> NSLayoutConstraint {
        return addConstraint(attribute: .right,
                             toView: view,
                             viewToAddConstraint: superview,
                             toViewAttribute: .right,
                             offset: offset,
                             relation: relation,
                             toSafeArea: toSafeArea)
    }

    @discardableResult
    func bottomToTop(view: UIView,
                     offset: CGFloat = 0,
                     relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        return addConstraint(attribute: .bottom,
                             toView: view,
                             viewToAddConstraint: superview,
                             toViewAttribute: .top,
                             offset: offset,
                             relation: relation)
    }

    @discardableResult
    func bottomToSuperView(offset: CGFloat = 0,
                           relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        return bottom(view: superview, offset: offset, relation: relation)
    }

    @discardableResult
    func bottom(view: UIView?,
                offset: CGFloat = 0,
                relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        return addConstraint(attribute: .bottom,
                             toView: view,
                             viewToAddConstraint: superview,
                             toViewAttribute: .bottom,
                             offset: offset,
                             relation: relation)
    }

    @discardableResult
    func topToBottom(view: UIView,
                     offset: CGFloat = 0,
                     relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        return addConstraint(attribute: .top,
                             toView: view,
                             viewToAddConstraint: superview,
                             toViewAttribute: .bottom,
                             offset: offset,
                             relation: relation)
    }

    @discardableResult
    func topToSuperView(offset: CGFloat = 0,
                        relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        return top(view: superview, viewToAddConstraint: superview, offset: offset, relation: relation)
    }

    @discardableResult
    func top(view: UIView?,
             viewToAddConstraint: UIView?,
             offset: CGFloat = 0,
             relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        return addConstraint(attribute: .top,
                             toView: view,
                             viewToAddConstraint: viewToAddConstraint,
                             toViewAttribute: .top,
                             offset: offset,
                             relation: relation)
    }

    @discardableResult
    private func addConstraint(attribute: NSLayoutConstraint.Attribute,
                               toView: UIView?,
                               viewToAddConstraint: UIView?,
                               toViewAttribute: NSLayoutConstraint.Attribute,
                               offset: CGFloat,
                               relation: NSLayoutConstraint.Relation = .equal,
                               multiplier: CGFloat = 1.0,
                               toSafeArea: Bool = false) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let toItem: Any?
        if toSafeArea, #available(iOS 11.0, *) {
            toItem = toView?.safeAreaLayoutGuide
        } else {
            toItem = toView
        }
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: attribute,
                                            relatedBy: relation,
                                            toItem: toItem,
                                            attribute: toViewAttribute,
                                            multiplier: multiplier,
                                            constant: offset)
        if let viewToAddConstraint = viewToAddConstraint {
            viewToAddConstraint.addConstraint(constraint)
        } else if let toView = toView {
            toView.addConstraint(constraint)
        } else {
            self.addConstraint(constraint)
        }

        return constraint
    }
}

extension UIView {
    func topAnchor(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Self {
        topAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    
    func leadingAnchor(to anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Self {
        leadingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    
    func bottomAnchor(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Self {
        bottomAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    
    func trailingAnchor(to anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Self {
        trailingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    
    func widthAnchor(constant: CGFloat) -> Self {
        widthAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }
    
    func heightAnchor(constant: CGFloat) -> Self {
        heightAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }
    
    func dimensionAnchors(width widthConstant: CGFloat, height heightConstant: CGFloat) -> Self {
        widthAnchor.constraint(equalToConstant: widthConstant).isActive = true
        heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
        return self
    }
    
    func dimensionAnchors(size: CGSize) -> Self {
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
        return self
    }
    
    func centerYAnchor(to anchor: NSLayoutYAxisAnchor) -> Self {
        centerYAnchor.constraint(equalTo: anchor).isActive = true
        return self
    }
    
    func centerXAnchor(to anchor: NSLayoutXAxisAnchor) -> Self {
        centerXAnchor.constraint(equalTo: anchor).isActive = true
        return self
    }
    
    func activateAnchors() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}
