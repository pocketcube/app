//
//  MenuButtonItem.swift
//  Pocketcube
//
//  Created by Miguel Pimentel on 14/11/20.
//

import UIKit
import SnapKit

class MenuButtonItem: UIView {

    // MARK: - Properties

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = AppFont.regular.size(12)
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

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.axis = .vertical

        return stackView
    }()

    // MARK: - Initializer

    init() {
        super.init(frame: CGRect.zero)
        addSubview(blurEffectView)
        blurEffectView.contentView.addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(descriptionLabel)

        blurEffectView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(4)
            $0.width.greaterThanOrEqualTo(100)
        }

        imageView.snp.makeConstraints {
            $0.width.height.equalTo(30)
        }

        descriptionLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.width.equalToSuperview().inset(8)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
