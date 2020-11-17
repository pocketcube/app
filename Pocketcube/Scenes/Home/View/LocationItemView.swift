//
//  LocationItemView.swift
//  Pocketcube
//
//  Created by Miguel Pimentel on 17/11/20.
//

import UIKit
import SnapKit

class LocationItemView: UIView {

    // MARK: - Properties

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.axis = .vertical

        return stackView
    }()

    lazy var blurEffectView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: effect)
        blurEffectView.frame = frame
        blurEffectView.clipsToBounds = true
        blurEffectView.layer.cornerRadius = 5

        return blurEffectView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "INFORMAÇÕES DO SATÉLITE"
        label.textColor = .white
        label.font = AppFont.regular.size(18)
        label.textAlignment = .center

        return label
    }()

    lazy var velocityLabel: UILabel = {
        let label = UILabel()
        label.text = "VELOCIDADE: -"
        label.textColor = .white
        label.font = AppFont.regular.size(18)
        label.textAlignment = .center

        return label
    }()

    lazy var altitudeLabel: UILabel = {
        let label = UILabel()
        label.text = "ALTITUDE: -"
        label.textColor = .white
        label.font = AppFont.regular.size(18)
        label.textAlignment = .center

        return label
    }()

    lazy var positionLabel: UILabel = {
        let label = UILabel()
        label.text = "LATITUDE:  -  LONGITUDE: -"
        label.textColor = .white
        label.font = AppFont.regular.size(40)
        label.textAlignment = .center

        return label
    }()

    // MARK: - Initializer

    init() {
        super.init(frame: CGRect.zero)
        addShadows()

        addSubview(blurEffectView)

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(velocityLabel)
        stackView.addArrangedSubview(altitudeLabel)
        stackView.addArrangedSubview(positionLabel)

        addSubview(stackView)

        blurEffectView.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.width.equalToSuperview()
        }

        stackView.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.width.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.width.equalToSuperview()
        }

        velocityLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.width.equalToSuperview()
        }

        altitudeLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.width.equalToSuperview()
        }

        positionLabel.snp.makeConstraints {
            $0.height.equalTo(20)
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
