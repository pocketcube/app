//
//  ViewController.swift
//  Pocketcube
//
//  Created by Miguel Pimentel on 09/10/20.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black


        // Teste Purpose

        let cardView = CircularProgressView(frame: CGRect(x: view.center.x, y: view.center.y, width: 400, height: 400))
        cardView.progressColor = .green
        cardView.trackColor = .gray

        view.addSubview(cardView)

        cardView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        cardView.setProgressWithAnimation(duration: 2.0, value: 0.8)
    }
}
