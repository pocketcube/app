//
//  RadiaProgressComponent.swift
//  Pocketcube
//
//  Created by Miguel Pimentel on 11/10/20.
//

import UIKit
import SnapKit

class RadialProgressComponent: UIView {

    // MARK: - Properties

    private lazy var blurEffectView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: effect)
        blurEffectView.frame = frame
        blurEffectView.clipsToBounds = true
        blurEffectView.layer.cornerRadius = 5


        return blurEffectView
    }()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.axis = .vertical

        return stackView
    }()

    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.text = "20"
        label.textColor = .white
        label.font = UIFont(descriptor: UIFontDescriptor(), size: 30)

        return label
    }()

    lazy var progressView: CircularProgressView = {
        let frame = CGRect(x: center.x, y: center.y, width: 80, height: 80)
        let radialView = CircularProgressView(frame: frame)

        return radialView
    }()

    // MARK: - Initialize

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(blurEffectView)
        addSubview(progressView)
        progressView.addSubview(stackView)
        stackView.addArrangedSubview(valueLabel)
    }

    private func setupConstraints() {
        blurEffectView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        progressView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }

        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(50)
        }
    }
}
