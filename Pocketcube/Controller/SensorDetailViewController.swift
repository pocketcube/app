//
//  SensorDetailViewController.swift
//  Pocketcube
//
//  Created by Miguel Pimentel on 12/11/20.
//

import UIKit
import SnapKit

class SensorDetailViewController: UIViewController, AboutItemViewDelegate {

    // MARK: - Properties

    lazy var aboutItemView: AboutItemView = {
        let view = AboutItemView(frame: .zero)
        view.delegate = self

        return view
    }()

    lazy var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10.0
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowOffset = CGSize(width: 2.0, height: 1.0)
        view.layer.shadowRadius = 5.0
        view.layer.shadowOpacity = 0.15

        return view
    }()

    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.5

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

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

protocol AboutItemViewDelegate: class {
    func didPressCancel()
}

class AboutItemView: UIView {

    // MARK: - Properties

    weak var delegate: AboutItemViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
        setupSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20

        return stackView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.text = "Titulo"

        return label
    }()

    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray

        return view
    }()

    lazy var buyButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 6
        button.setTitle("Clique Aqui", for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(checkoutPressed), for: .touchUpInside)

        return button
    }()

    @objc func checkoutPressed(sender: UIButton?) {
        delegate?.didPressCancel()
    }
}

extension AboutItemView {

    func setupView() {
        backgroundColor = .white
        addSubview(stackView)

        setupShadow()
    }

    func setupSubviews() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(buyButton)
    }

    func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.bottom.leading.trailing.equalToSuperview().inset(24)
        }

        buyButton.snp.makeConstraints {
            $0.height.equalTo(56)
            $0.width.equalToSuperview()
        }
    }

    private func setupShadow() {
        backgroundColor = .white
        layer.cornerRadius = 6.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.05, height: 0.05)
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.15
    }
}
