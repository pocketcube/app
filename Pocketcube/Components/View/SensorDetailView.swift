//
//  SensorDetailView.swift
//  Pocketcube
//
//  Created by Miguel Pimentel on 14/11/20.
//

import UIKit
import SnapKit
import Charts

class SensorDetailView: UIView {

    // MARK: - Properties

    weak var delegate: AboutItemViewDelegate?

//    private var drawer = ChartDrawer()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
        setupSubviews()
        setupConstraints()


        buildChart()
        setDataCount(45, range: 100)
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

    lazy var chartView: LineChartView = {
        let view = LineChartView()
        view.backgroundColor = .white

        return view
    }()

    lazy var chartCardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10

        return view
    }()

    lazy var titleLabel: UILabel = {
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
        button.setImage(UIImage(named: "close_ic"), for: .normal)
        button.addTarget(self, action: #selector(closePressed), for: .touchUpInside)

        return button
    }()


    // MARK: - Actions

    @objc func closePressed(sender: UIButton?) {
        delegate?.didPressCancel()
    }

    private func buildChart() {
        chartView.delegate = self

        chartView.setViewPortOffsets(left: 0, top: 20, right: 0, bottom: 0)
        chartView.backgroundColor = .white //UIColor(red: 104/255, green: 241/255, blue: 175/255, alpha: 1)

        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = true
        chartView.maxHighlightDistance = 300




        chartView.xAxis.enabled = false

        let yAxis = chartView.leftAxis
        yAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size:12)!
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .white
        yAxis.labelPosition = .insideChart
        yAxis.axisLineColor = .white

        chartView.rightAxis.enabled = false
        chartView.legend.enabled = false


        chartView.animate(xAxisDuration: 2, yAxisDuration: 2)
    }

    func setDataCount(_ count: Int, range: UInt32) {
        let yVals1 = (0..<count).map { (i) -> ChartDataEntry in
            let mult = range + 1
            let val = Double(arc4random_uniform(mult) + 20)
            return ChartDataEntry(x: Double(i), y: val)
        }

        let set1 = LineChartDataSet(entries: yVals1, label: "DataSet 1")
        set1.mode = .cubicBezier
        set1.drawCirclesEnabled = false
        set1.lineWidth = 1.8
        set1.circleRadius = 4
        set1.setCircleColor(.white)
        set1.setColor(darkBlue)
        set1.highlightColor = .black//UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        set1.fillColor = darkBlue
        set1.fillAlpha = 1
        set1.drawHorizontalHighlightIndicatorEnabled = true

//        let gradient = CGGradient(colorsSpace: nil, colors: [darkBlue.cgColor, UIColor.white.cgColor] as CFArray, locations: [0.0, 1.0])
        set1.fillColor = darkBlue
//        set1.fill = Fill.fillWithLinearGradient(gradient!, angle: 0.0)

//        set1.fillFormatter = CubicLineSampleFillFormatter()

        let data = LineChartData(dataSet: set1)
        data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 9)!)
        data.setDrawValues(false)

        chartView.data = data
    }

}

extension SensorDetailView: ChartViewDelegate {

}

extension SensorDetailView {

    func setupView() {
        addSubview(stackView)

        chartCardView.addSubview(chartView)

        setupShadow()
//        drawer.createSimpleChart(lineChartView: chartView)
    }

    func setupSubviews() {
        stackView.addArrangedSubview(closeButton)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(chartCardView)
        stackView.addArrangedSubview(descriptionLabel)
    }

    func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.bottom.leading.trailing.equalToSuperview().inset(24)
        }

        closeButton.snp.makeConstraints {
            $0.height.width.equalTo(60)
        }

        titleLabel.snp.makeConstraints {
            $0.height.equalTo(70)
            $0.width.equalToSuperview()
        }

        descriptionLabel.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(50)
            $0.width.equalToSuperview()
        }

        chartCardView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(300)
        }

        chartView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(4)
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
