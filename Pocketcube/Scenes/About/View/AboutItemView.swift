//
//  AboutItemView.swift
//  Pocketcube
//
//  Created by Miguel Pimentel on 14/11/20.
//

import SnapKit

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
        stackView.alignment = .trailing
        stackView.spacing = 20
        

        return stackView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = AppFont.bold.size(51)
        label.text = "PocketQube"
        label.textColor = .white

        return label
    }()

    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = AppFont.bold.size(51)
        label.text = "PocketQube"
        label.textColor = .white

        return label
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = AppFont.regular.size(30)
        label.numberOfLines = 3
        label.textColor = .white
        label.text = "O projeto PocketQube é um projeto aberto.\n Contribua com nosso desenvolvimento!"

        return label
    }()


    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray

        return view
    }()

    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 6
        button.setImage(UIImage(named: "ic_close"), for: .normal)
        button.addTarget(self, action: #selector(closePressed), for: .touchUpInside)

        return button
    }()


    // MARK: - Actions

    @objc func closePressed(sender: UIButton?) {
        delegate?.didPressCancel()
    }
}

extension AboutItemView {

    func setupView() {
        addSubview(stackView)

        setupShadow()
    }

    func setupSubviews() {
        stackView.addArrangedSubview(closeButton)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
    }

    func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        closeButton.snp.makeConstraints {
            $0.height.width.equalTo(40)
        }

        titleLabel.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalToSuperview()
        }

        descriptionLabel.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(50)
            $0.width.equalToSuperview()
        }
    }

    private func setupShadow() {
        backgroundColor = UIColor(red: 0.18, green: 0.20, blue: 0.40, alpha: 1.00)
        layer.cornerRadius = 6.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.05, height: 0.05)
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.15
    }
}
