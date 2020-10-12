//
//  ViewController.swift
//  Pocketcube
//
//  Created by Miguel Pimentel on 09/10/20.
//

import UIKit
import SnapKit

enum AppFont: String {
    case light = "Light"
    case regular = "Regular"
    case bold = "Bold"

    func size(_ size: CGFloat) -> UIFont {
        if let font = UIFont(name: "Lato-Regular", size: size + 1.0) {
            return font
        }
        fatalError("Font 'Lato-Regular.ttf' does not exist.")
    }
}

class ViewController: UIViewController {

    lazy var cardView: CardView = {
        let cardView = CardView()
        return cardView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "POCKETCUBE"
        label.textColor = .white
        label.font = AppFont.regular.size(20)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        view.setGradientBackground()

        // Teste Purpose

        let progressComponent = RadialProgressComponent(frame: CGRect(x: view.center.x, y: view.center.y, width: 100, height: 100))
        progressComponent.progressView.progressColor = .green
        progressComponent.progressView.trackColor = .white

        view.addSubview(progressComponent)
        view.addSubview(cardView)
        view.addSubview(titleLabel)

        progressComponent.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.greaterThanOrEqualTo(100)
        }

        cardView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(50)
            $0.height.equalTo(400)
            $0.width.equalTo(250)
            $0.centerY.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(50)
            $0.width.equalTo(200)
            $0.height.equalTo(70)
        }

        progressComponent.progressView.setProgressWithAnimation(duration: 2.0, value: 0.8)
    }
}
