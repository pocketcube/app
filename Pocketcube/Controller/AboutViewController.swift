//
//  AboutViewController.swift
//  Pocketcube
//
//  Created by Miguel Pimentel on 12/11/20.
//

import UIKit
import Charts


class AboutViewController: UIViewController, AboutItemViewDelegate {

    // MARK: - Properties

    lazy var aboutItemView: AboutItemView = {
        let view = AboutItemView(frame: .zero)
        view.delegate = self

        return view
    }()

    lazy var cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10.0
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowOffset = CGSize(width: 2.0, height: 1.0)
        view.layer.shadowRadius = 5.0
        view.layer.shadowOpacity = 0.15

        return view
    }()

    lazy var blurEffectView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .extraLight)
        let blurEffectView = UIVisualEffectView(effect: effect)
        blurEffectView.frame = view.frame
        blurEffectView.clipsToBounds = true
        blurEffectView.layer.cornerRadius = 5

        return blurEffectView
    }()


    // MARK: - Actions

    func didPressCancel() {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Setup

    private func setup() {
        setupView()
        setupConstraints()
    }

    private func setupView() {
//        view.addSubview(backgroundView)
        view.addSubview(blurEffectView)
        view.addSubview(cardView)

        cardView.addSubview(aboutItemView)
    }

    private func setupConstraints() {
        blurEffectView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        cardView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.6)
            $0.height.equalTo(600)
        }

        aboutItemView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
