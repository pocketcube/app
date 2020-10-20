//
//  ViewController.swift
//  Pocketcube
//
//  Created by Miguel Pimentel on 09/10/20.
//

import UIKit
import SnapKit
import SocketIO

enum AppFont: String {
    case light = "Light"
    case regular = "Regular"
    case bold = "Bold"

    func size(_ size: CGFloat) -> UIFont {
        if let font = UIFont(name: "Lato-Bold", size: size + 1.0) {
            return font
        }
        fatalError("Font 'Lato-Bold.ttf' does not exist.")
    }
}

class ViewController: UIViewController {

    // MARK: - Properties

    var counter = 0

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "POCKETCUBE"
        label.textAlignment = .center
        label.textColor = .white
        label.font = AppFont.regular.size(20)

        return label
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        view.backgroundColor = .black
        view.setGradientBackground()
//
//        let progressComponent = RadialProgressComponent(frame: CGRect(x: view.center.x, y: view.center.y, width: 100, height: 100))
//        progressComponent.progressView.progressColor = UIColor(red: 0.16, green: 0.55, blue: 1.00, alpha: 1.00)
//        progressComponent.progressView.trackColor = .white

        view.addSubview(progressComponent)
        view.addSubview(titleLabel)

        progressComponent.progressView.setProgressWithAnimation(duration: 2.0, value: 0.8)
        progressComponent.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.greaterThanOrEqualTo(100)
        }

        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(50)
            $0.width.equalTo(200)
            $0.height.equalTo(70)
        }
    }

    private func setup() {
        NetworkManager.shared.observe(delegate: self)
    }
}


extension ViewController: NetworkManagerDelegate {

    func didReceive(_ data: Any, emitter: SocketAckEmitter) {
        if let content = data as? [String: String] {
            let sensorData = SensorFactory(key: content["topic"] ?? "").getValue(content["topic"] ?? "", payload: content["payload"] ?? "")

            if let value = sensorData as? Temperature {
                DispatchQueue.main.async {
                    self.progressComponent.valueLabel.text = "\(value.temp)"
                }
            }

        } else {
            debugPrint("deu ruim")
        }
    }
}
