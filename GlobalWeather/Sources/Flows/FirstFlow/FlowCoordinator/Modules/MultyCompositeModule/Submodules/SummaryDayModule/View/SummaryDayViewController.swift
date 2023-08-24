//
//  SummaryDayViewController.swift
//  GlobalWeather
//
//  Created by Kanat on 23.08.2023
//  
//

import UIKit
import Combine

class SummaryDayViewController: BaseViewController {
    var output: SummaryDayViewOutput?
    
    private var cancellables = Set<AnyCancellable>()
    private(set) var summaryDayPublisher = PassthroughSubject<WeatherDailyViewModel, Never>()

    @IBOutlet private weak var descriptionLabel: TopAlignedLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        output?.viewDidLoad()
        
        subscribeForViewInput()
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
}

// MARK: - Configure
extension SummaryDayViewController: SummaryDayViewInput {
    private func setupSubviews() {
    }
}

// MARK: View Input
extension SummaryDayViewController {
    private func subscribeForViewInput() {
        summaryDayPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] vm in
                self?.configure(vm)
            }
            .store(in: &cancellables)
    }
    
    private func configure(_ viewModel: WeatherDailyViewModel) {
        descriptionLabel.text = "Today: Mostly \(viewModel.conditionImage[0]). The high today was forecast as \(viewModel.temp_max[0])"
    }
}

// MARK: Button Action
extension SummaryDayViewController {
    
}

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
