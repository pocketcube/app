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
        view.backgroundColor = .cyan
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
        view.backgroundColor = .red

        return view
    }()

    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
//        view.alpha = 0.7
//        view.

        return view
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
        view.addSubview(backgroundView)
        view.addSubview(cardView)

        cardView.addSubview(aboutItemView)
    }

    private func setupConstraints() {
        backgroundView.snp.makeConstraints {
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
