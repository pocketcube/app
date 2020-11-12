//
//  SensorDetailViewController.swift
//  Pocketcube
//
//  Created by Miguel Pimentel on 12/11/20.
//

import UIKit
import SnapKit

class SensorDetailViewController: UIViewController {

    lazy var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white

        return view
    }()

    lazy var blurEffectView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: effect)
        blurEffectView.frame = view.frame
        blurEffectView.clipsToBounds = true
        blurEffectView.layer.cornerRadius = 5
        blurEffectView.backgroundColor = .clear

        return blurEffectView
    }()

    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.3

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        setupView()
        setupConstraints()
    }

    private func setupView() {
        view.backgroundColor = .clear

        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve

        view.addSubview(backgroundView)
        view.addSubview(cardView)
    }

    private func setupConstraints() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        cardView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.6)
            $0.height.equalToSuperview().multipliedBy(0.7)
        }
    }
}
