//
//  LoaderView.swift
//  GlobalWeather
//
//  Created by Kanat on 30.07.2023.
//

import UIKit

var loaderViewColor: UIColor = #colorLiteral(red: 0.2118796408, green: 0.2519861162, blue: 0.2926436067, alpha: 1)

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
        backgroundColor = #colorLiteral(red: 0.9655296206, green: 0.9720321298, blue: 0.9782348275, alpha: 0.2)
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


