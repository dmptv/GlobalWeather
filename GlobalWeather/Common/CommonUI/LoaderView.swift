//
//  LoaderView.swift
//  GlobalWeather
//
//  Created by Kanat on 30.07.2023.
//

import UIKit

var loaderViewColor: UIColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)

class LoaderView: UIView {
    private let loadingIndicator = UIActivityIndicatorView()
    
    init() {
        super.init(frame: .zero)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        backgroundColor = .gray
        addSubview(loadingIndicator)
        
        loadingIndicator.style = .large
        loadingIndicator.centerInSuperview()
        loadingIndicator.hidesWhenStopped = true
    }
    
    func startAnimation(in view: UIView) {
        isHidden = false
        view.addSubview(self)
        frame = view.bounds
        fillSuperview()
        loadingIndicator.color = loaderViewColor
        loadingIndicator.startAnimating()
    }
    
    func stopAnimation() {
        isHidden = true
        loadingIndicator.stopAnimating()
        removeFromSuperview()
    }
}


