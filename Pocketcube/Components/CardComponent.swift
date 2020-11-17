//
//  CardComponent.swift
//  Pocketcube
//
//  Created by Miguel Pimentel on 10/10/20.
//

import UIKit
import SnapKit

class CardView: UIView {

    // MARK: - Properties

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Temperature"
        label.textColor = .white
        label.font = AppFont.regular.size(18)
        label.textAlignment = .center

        return label
    }()

    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.textColor = .white
        label.font = AppFont.regular.size(40)
        label.textAlignment = .center

        return label
    }()

    lazy var metricsLabel: UILabel = {
        let label = UILabel()
        label.text = "ºC"
        label.textColor = .white
        label.font = AppFont.regular.size(26)
        label.textAlignment = .center

        return label
    }()

    lazy var blurEffectView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: effect)
        blurEffectView.frame = frame
        blurEffectView.clipsToBounds = true
        blurEffectView.layer.cornerRadius = 5

        return blurEffectView
    }()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.axis = .vertical

        return stackView
    }()

    // MARK: - Initializer

    init() {
        super.init(frame: CGRect.zero)
        addShadows()

        addSubview(blurEffectView)

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(valueLabel)
        stackView.addArrangedSubview(metricsLabel)

        addSubview(stackView)

        blurEffectView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }

        titleLabel.snp.makeConstraints {
            $0.width.equalToSuperview()
        }

        valueLabel.snp.makeConstraints {
            $0.width.equalToSuperview()
        }

        valueLabel.snp.makeConstraints {
            $0.width.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Setup

    private func addShadows() {
        backgroundColor = .clear
        layer.cornerRadius = 10.0
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 2.0, height: 1.0)
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.15
    }
}
