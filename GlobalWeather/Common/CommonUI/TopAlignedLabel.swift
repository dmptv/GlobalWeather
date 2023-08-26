//
//  TopAlignedLabel.swift
//  GlobalWeather
//
//  Created by Kanat on 24.08.2023.
//

import UIKit

class TopAlignedLabel: UILabel {
    override func drawText(in rect: CGRect) {
        guard let text = text else {
            super.drawText(in: rect)
            return
        }
                
        let style = NSMutableParagraphStyle()
        style.alignment = textAlignment
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font ?? UIFont.boldSystemFont(ofSize: 20),
            .foregroundColor: textColor ?? UIColor(red: 0.41, green: 0.69, blue: 0.89, alpha: 1.00)
,
            .paragraphStyle: style
        ]
        
        let size = text.boundingRect(with: rect.size,
                                     options: [.usesLineFragmentOrigin],
                                     attributes: attributes,
                                     context: nil).size
        
        let newRect = CGRect(x: rect.origin.x,
                             y: rect.origin.y,
                             width: rect.size.width,
                             height: size.height)
        
        super.drawText(in: newRect)
    }
}
