//
//  ViewController.swift
//  Pocketcube
//
//  Created by Miguel Pimentel on 09/10/20.
//

import UIKit
import SnapKit
import SocketIO

class ViewController: UIViewController {

    // MARK: - Properties

    var counter = 0

    private lazy var doubleTap: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.buttonClicked))
        gesture.numberOfTapsRequired = 2

        return gesture
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "POCKETCUBE"
        label.textAlignment = .center
        label.textColor = .white
        label.font = AppFont.regular.size(46)

        return label
    }()

    lazy var menuItem: UIButton = {
        let view = UIButton()
        view.backgroundColor = .red
        return view
    }()

    lazy var menuStackView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .red

        return view
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 180, height: 180)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.identifier)
        collectionView.backgroundColor = .clear

        return collectionView
    }()

    lazy var progressComponent: RadialProgressComponent = {
        let component = RadialProgressComponent(frame: CGRect(x: view.center.x, y: view.center.y, width: 100, height: 100))
        component.progressView.progressColor = UIColor(red: 0.16, green: 0.55, blue: 1.00, alpha: 1.00)
        component.progressView.trackColor = .white

        return component
    }()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @objc func buttonClicked() {
        Downloader.download(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        view.setGradientBackground()
        view.addSubview(collectionView)
        view.addSubview(titleLabel)
        view.addSubview(menuStackView)
        view.addGestureRecognizer(doubleTap)

        menuStackView.addArrangedSubview(menuItem)
        menuStackView.addArrangedSubview(menuItem)

        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(50)
            $0.width.equalTo(400)
            $0.height.equalTo(70)
        }

        collectionView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(800)
            $0.height.greaterThanOrEqualTo(500)
        }

        menuStackView.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(70)
            $0.width.lessThanOrEqualTo(50)
        }

        menuItem.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.width.equalTo(30)
        }

        menuItem.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.width.equalTo(30)
        }
    }

    private func setup() {
        NetworkManager.shared.observe(delegate: self)
    }
}

class ItemCell: UICollectionViewCell {

    static let identifier = "ItemCell"

    lazy var cardView: CardView = {
        let component = CardView()
        return component
    }()

    func setup() {
        addSubview(cardView)
        cardView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }
}

extension ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.identifier, for: indexPath) as! ItemCell
        cell.setup()

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300.0, height: 300.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 25, left: 5, bottom: 25, right: 5)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
}

extension ViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = SensorDetailViewController()

        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve

        self.navigationController?.present(vc, animated: true, completion: nil)
    }
}

extension ViewController: NetworkManagerDelegate {

    func didReceive(_ data: Any, emitter: SocketAckEmitter) {
        if let content = data as? [String: String] {
            let sensorData = SensorFactory(key: content["topic"] ?? "").getValue(content["topic"] ?? "", payload: content["payload"] ?? "")

            if let temperature = sensorData as? Temperature {
                DataManager.temperature.append(temperature)
                DispatchQueue.main.async {
                    let indexPath = IndexPath(item: 0, section: 0)
                    if let cell = self.collectionView.cellForItem(at: indexPath) as? ItemCell {
                        cell.cardView.valueLabel.text = "\(temperature.temp)"
                    }
                }
            } else if let oxygen = sensorData as? Oxygen {
                DataManager.oxygen.append(oxygen)
                DispatchQueue.main.async {
                    let indexPath = IndexPath(item: 1, section: 0)
                    if let cell = self.collectionView.cellForItem(at: indexPath) as? ItemCell {
                        cell.cardView.valueLabel.text = "\(oxygen.oxygen)"
                    }
                }
            }
        } else {
            debugPrint("deu ruim")
        }
    }
}
