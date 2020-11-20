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

//    private lazy var doubleTap: UITapGestureRecognizer = {
//        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.buttonClicked))
//        gesture.numberOfTapsRequired = 2
//
//        return gesture
//    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "POCKETCUBE"
        label.textAlignment = .center
        label.textColor = .white
        label.font = AppFont.regular.size(46)

        return label
    }()

//    private let tapAbout = UITapGestureRecognizer(target: self, action: #selector(self.aboutClicked(_:)))

    lazy var aboutButton: MenuButtonItem = {
        let view = MenuButtonItem()

        view.imageView.image = UIImage(named: "ic_info")
        view.descriptionLabel.text = "Sobre"

        return view
    }()

//    private let tapDownload = UITapGestureRecognizer(target: self, action: #selector(self.downloadClicked(_:)))

    lazy var downloadButton: MenuButtonItem = {
        let view = MenuButtonItem()

        view.imageView.image = UIImage(named: "ic_download")
        view.descriptionLabel.text = "Baixar dados"

        return view
    }()

    lazy var locationItemView: LocationItemView = {
        let view = LocationItemView()
        return view
    }()


    lazy var menuStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.spacing = 10

        return stackview
    }()

    lazy var collectionView: UICollectionView = {
        let size = CGSize(width: 180, height: 180)
        let layout = CollectionViewFlowLayout(itemSize: size)

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
//
//    @objc func buttonClicked() {
//        Downloader.download(self)
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        let tapAbout = UITapGestureRecognizer(target: self, action: #selector(self.aboutClicked(_:)))
        let tapDownload = UITapGestureRecognizer(target: self, action: #selector(self.downloadClicked(_:)))

        aboutButton.addGestureRecognizer(tapAbout)
        downloadButton.addGestureRecognizer(tapDownload)

        view.setGradientBackground()
        view.addSubview(collectionView)
        view.addSubview(titleLabel)
        view.addSubview(menuStackView)
//        view.addGestureRecognizer(doubleTap)
        view.addSubview(locationItemView)

        menuStackView.addArrangedSubview(downloadButton)
        menuStackView.addArrangedSubview(aboutButton)

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
        }

        locationItemView.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(100)
            $0.width.equalTo(400)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(50)
        }
    }

    private func setup() {
        NetworkManager.shared.observe(delegate: self)
    }

    // MARK: - Actions

    @objc func aboutClicked(_ sender: UITapGestureRecognizer? = nil) {
        let vc = SensorDetailViewController()

        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve

        debugPrint("About Click")
        self.navigationController?.present(vc, animated: true, completion: nil)
    }

    @objc func downloadClicked(_ sender: UITapGestureRecognizer? = nil) {
        debugPrint("Donwload click")
        Downloader.download(self)
    }
}



class ItemCell: UICollectionViewCell {

    static let identifier = "ItemCell"

    lazy var cardView: CardView = {
        let component = CardView()
        return component
    }()

    func setup(with indexPath: IndexPath) {
        contentView.addSubview(cardView)
        cardView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }

        setupView(section: indexPath.section, item: indexPath.item)
    }

    private func setupView(section: Int, item: Int) {
        if section == 0  {
            if item == 0 {
                cardView.titleLabel.text = "TEMPERATURA"
                cardView.metricsLabel.text = "ºC"
            } else if item == 1 {
                cardView.titleLabel.text = "UMIDADE"
                cardView.metricsLabel.text = "UR"
            } else {
                cardView.titleLabel.text = "PRESSÃO"
                cardView.metricsLabel.text = "HPA"
            }
        } else {
            if item == 0 {
                cardView.titleLabel.text = "NO2"
                cardView.metricsLabel.text = "ppm"
            } else if item == 1 {
                cardView.titleLabel.text = "NH3"
                cardView.metricsLabel.text = "ppm"
            } else {
                cardView.titleLabel.text = "CO2"
                cardView.metricsLabel.text = "ppm"
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.identifier, for: indexPath) as! ItemCell
        cell.setup(with: indexPath)

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
        return 3
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

            if let data = sensorData as? AtmosphericData {
                DispatchQueue.main.async {
                    DataManager.atmosphericItems.append(data)
                    if let temperature = data.temperature {
                        self.updateItem(item: 0, section: 0, value: temperature)
                    } else if let pressure = data.pressure {
                        self.updateItem(item: 1, section: 0, value: pressure)
                    } else if let humidity = data.humidity {
                        self.updateItem(item: 2, section: 0, value: humidity)
                    }
                }
            } else if let data = sensorData as? GasesData {
                DispatchQueue.main.async {
                    if let temperature = data.co2 {
                        self.updateItem(item: 0, section: 1, value: temperature)
                    } else if let pressure = data.nh3 {
                        self.updateItem(item: 1, section: 1, value: pressure)
                    } else if let humidity = data.no2 {
                        self.updateItem(item: 2, section: 1, value: humidity)
                    }
                }
            } else if let data = sensorData as? PositionData {
                DispatchQueue.main.async {
                    if let altitude = data.altitude {
                        self.locationItemView.altitudeLabel.text = "ALTIDUDE: \(altitude) m"
                    } else if let lat = data.lat, let long = data.lon {
                        self.locationItemView.positionLabel.text = "LATITUDE: \(lat)   LONGITUDE: \(long)"
                    } else if let velocity = data.speed {
                        self.locationItemView.velocityLabel.text = "VELOCIDADE: \(velocity) m/s"
                    }
                }
            }
        }
    }

    private func updateItem(item: Int, section: Int, value: Double) {
        let indexPath = IndexPath(item: item, section: section)
        if let cell = self.collectionView.cellForItem(at: indexPath) as? ItemCell {
            cell.cardView.valueLabel.text = "\(value)"
        }
    }
}
