//
//  SensorDetailView.swift
//  Pocketcube
//
//  Created by Miguel Pimentel on 14/11/20.
//

import UIKit
import SnapKit
import Charts

struct ChartColors {
    static var lineColor = UIColor(red: 0.52, green: 0.36, blue: 0.97, alpha: 1.00)
    static var background = UIColor(red: 0.09, green: 0.10, blue: 0.20, alpha: 1.00)
    static var fillColor = UIColor(red: 0.89, green: 0.54, blue: 0.95, alpha: 1.00)
}

class SensorDetailView: UIView {

    // MARK: - Properties

    weak var delegate: AboutItemViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
        setupSubviews()
        setupConstraints()

        buildChart()
        setDataCount()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.spacing = 10

        return stackView
    }()

    lazy var chartView: LineChartView = {
        let view = LineChartView()
        view.backgroundColor = .white

        return view
    }()

    lazy var chartCardView: UIView = {
        let view = UIView()
        view.backgroundColor = ChartColors.background
        view.layer.cornerRadius = 10

        return view
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = AppFont.bold.size(30)
        label.text = "Temperature (Cº)"
        label.textColor = .white

        return label
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = AppFont.regular.size(18)
        label.numberOfLines = 3
        label.textColor = .white
        label.text = ""

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
        chartView.backgroundColor = ChartColors.background

        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = true
        chartView.marker = ChartMarker()
        chartView.maxHighlightDistance = 300

        chartView.xAxis.enabled = false

        let yAxis = chartView.leftAxis
        yAxis.labelFont = AppFont.bold.size(14) 
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .white
        yAxis.labelPosition = .insideChart
        yAxis.drawGridLinesEnabled = false


        chartView.rightAxis.enabled = false
        chartView.legend.enabled = false
    }

    func setDataCount() {
        var dataSet: [ChartDataEntry] = []

        for (index, element) in DataManager.atmosphericItems.enumerated() {
            if let item = element.temperature {
                let entry = ChartDataEntry(x: Double(index), y: item)
                dataSet.append(entry)
            }
        }

        let set1 = LineChartDataSet(entries: dataSet, label: "DataSet 1")
        set1.mode = .cubicBezier
        set1.drawCirclesEnabled = true
        set1.drawFilledEnabled = true
        set1.lineWidth = 1.8
        set1.circleRadius = 4
        set1.setCircleColor(.white)
        set1.setColor(darkBlue)
        set1.circleHoleColor = .white
        set1.circleHoleRadius = 5
        set1.highlightColor = .white
        set1.fillColor = ChartColors.fillColor
        set1.fillAlpha = 1
        set1.drawHorizontalHighlightIndicatorEnabled = true

        let gradient = CGGradient(colorsSpace: nil, colors: [ChartColors.fillColor.cgColor, ChartColors.background.cgColor] as CFArray, locations: [1.0, 0.0])

        set1.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0)
        let data = LineChartData(dataSet: set1)
        data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 9)!)
        data.setDrawValues(false)

        chartView.data = data
    }

}

class ChartMarker: MarkerView {

    // MARK: - Propeties

    var text = ""

    override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        super.refreshContent(entry: entry, highlight: highlight)
        text = String(entry.y)
    }

    override func draw(context: CGContext, point: CGPoint) {
        super.draw(context: context, point: point)

        var drawAttributes = [NSAttributedString.Key : Any]()
        drawAttributes[.font] = AppFont.bold.size(14)
        drawAttributes[.foregroundColor] = ChartColors.background
        drawAttributes[.backgroundColor] = UIColor.white

        self.bounds.size = (" \(text) " as NSString).size(withAttributes: drawAttributes)
        self.offset = CGPoint(x: 0, y: -self.bounds.size.height - 2)

        let offset = self.offsetForDrawing(atPoint: point)

        drawText(
            text: "\(text)  TETSTETS\n 43343 " as NSString,
            rect: CGRect(origin: CGPoint(x: point.x + offset.x, y: point.y + offset.y),
            size: self.bounds.size),
            withAttributes: drawAttributes
        )
    }

    func drawText(text: NSString, rect: CGRect, withAttributes attributes: [NSAttributedString.Key : Any]? = nil) {
        let size = text.size(withAttributes: attributes)
        let centeredRect = CGRect(
            x: rect.origin.x + (rect.size.width - size.width) / 2.0,
            y: rect.origin.y + (rect.size.height - size.height) / 2.0,
            width: size.width,
            height: size.height
        )

        text.draw(in: centeredRect, withAttributes: attributes)
    }
}

extension SensorDetailView: ChartViewDelegate { }

extension SensorDetailView {

    func setupView() {
        addSubview(stackView)
        chartCardView.addSubview(chartView)

        setupShadow()
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
