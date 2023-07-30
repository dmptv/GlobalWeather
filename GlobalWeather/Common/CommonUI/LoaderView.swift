//
//  LoaderView.swift
//  GlobalWeather
//
//  Created by Kanat on 30.07.2023.
//

import UIKit

public var loaderViewColor: UIColor = #colorLiteral(red: 0.2118796408, green: 0.2519861162, blue: 0.2926436067, alpha: 1)

public class LoaderView: UIView {
    private let loadingIndicator = UIActivityIndicatorView()
    
    public init() {
        super.init(frame: .zero)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        backgroundColor = #colorLiteral(red: 0.9655296206, green: 0.9720321298, blue: 0.9782348275, alpha: 0.2)
        addSubview(loadingIndicator)
        
        loadingIndicator.style = .whiteLarge
        loadingIndicator.centerInSuperview()
        loadingIndicator.hidesWhenStopped = true
    }
    
    public func startAnimation(in view: UIView) {
        isHidden = false
        view.addSubview(self)
        frame = view.bounds
        fillSuperview()
        loadingIndicator.color = loaderViewColor
        loadingIndicator.startAnimating()
    }
    
    public func stopAnimation() {
        isHidden = true
        loadingIndicator.stopAnimating()
        removeFromSuperview()
    }
}

