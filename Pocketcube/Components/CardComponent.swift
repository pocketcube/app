//
//  CardComponent.swift
//  Pocketcube
//
//  Created by Miguel Pimentel on 10/10/20.
//

import UIKit

class CardView: UIView {

    // MARK: - Initializer

    init() {
        super.init(frame: CGRect.zero)
        addShadows()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Setup

    private func addShadows() {
        backgroundColor = .white
        layer.cornerRadius = 10.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2.0, height: 1.0)
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.3
    }
}
