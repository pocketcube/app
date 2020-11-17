//
//  ChartDrawer.swift
//  Pocketcube
//
//  Created by Miguel Pimentel on 13/11/20.
//

import UIKit
import Charts

class ChartDrawer {

    // MARK: - Initialize

    init() {}

    func createSimpleChart(lineChartView: LineChartView) {
        lineChartView.delegate = self
        setChart(lineChartView: lineChartView)
    }

    // Create chart
    func setChart(lineChartView: LineChartView) {

        let d1 = self.loadData(values: [5, 10, 20, 23])

        let matchesDataSet = self.setChartDataSet(dataEntries: d1, color: .blue)
        matchesDataSet.mode = .cubicBezier

        let chartDataSets = [matchesDataSet]
        let chartData = self.setChartData(chartDataSets: chartDataSets)

        self.setLineChartView(lineChartView: lineChartView, chartData: chartData)
    }

    // Create content based in entry values
    func loadData(values: [Double]) -> [ChartDataEntry] {

        var dataEntries = [ChartDataEntry]()

        for i in 0..<values.count {
            let data = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(data)
        }

        return dataEntries
    }

    // Set chart Preferences
    func setChartDataSet(dataEntries: [ChartDataEntry], color: UIColor) -> LineChartDataSet {
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "Chart")

        chartDataSet.colors = [color]
        chartDataSet.drawCirclesEnabled = true
        chartDataSet.drawCircleHoleEnabled = true
        chartDataSet.circleColors = [UIColor.gray]
        chartDataSet.circleHoleColor = .white
        chartDataSet.circleRadius = 10.0
        chartDataSet.lineWidth = 4.0
        chartDataSet.mode = .cubicBezier
        chartDataSet.cubicIntensity = 0.2
        chartDataSet.drawValuesEnabled = false

        return chartDataSet
    }

    // Load chart lines
    func setChartData(chartDataSets: [LineChartDataSet]) -> LineChartData {

        let chartData = LineChartData()
        chartData.setDrawValues(true)

        for data in chartDataSets { chartData.addDataSet(data) }
        return chartData
    }

    func setLineChartView(lineChartView: LineChartView, chartData: LineChartData) {

        // General
        lineChartView.data = chartData
        lineChartView.noDataText = "No data available"
        lineChartView.chartDescription = nil
        lineChartView.legend.enabled = false

        lineChartView.xAxis.drawGridLinesEnabled = true
        lineChartView.leftAxis.drawGridLinesEnabled = true

        lineChartView.minOffset = 1  // padding around the chart

        // Disable scale
        lineChartView.scaleXEnabled = true
        lineChartView.scaleYEnabled = true

        // Configure grid Lines
        lineChartView.rightAxis.gridLineWidth = 1.0
        lineChartView.rightAxis.axisLineWidth = 3.0

        // Axis X
        let axisX = lineChartView.xAxis
        axisX.labelPosition = .bottomInside
        axisX.labelFont =  NSUIFont.init(name: "HelveticaNeue-Light", size: 14)!
        axisX.labelTextColor = UIColor.gray
        axisX.gridLineWidth = 1.0
        axisX.axisLineWidth = 0

        // Axis Y
        let rightAxisY = lineChartView.rightAxis
        rightAxisY.enabled = false

        let leftAxisY = lineChartView.leftAxis
        leftAxisY.labelFont = NSUIFont.init(name: "HelveticaNeue-Light", size: 14)!
        leftAxisY.labelTextColor = UIColor.gray
        leftAxisY.gridLineWidth = 1.0
        leftAxisY.axisLineWidth = 0

        lineChartView.animate(yAxisDuration: 1.5)
    }

    func assignGradient(firstColor: UIColor, secondColor: UIColor) -> CAGradientLayer {

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [firstColor, secondColor]
        gradientLayer.locations = [ 0.0, 1.0]

        return gradientLayer
    }


    func createChartWithOneContentLine(lineChartView: LineChartView, data: [Double]) {

        let d1 = self.loadData(values: data)
        let matchesDataSet = self.setChartDataSet(dataEntries: d1, color: UIColor(named: "blue")!)
        let chartDataSets = [matchesDataSet]
        let chartData = self.setChartData(chartDataSets: chartDataSets)

        self.setLineChartView(lineChartView: lineChartView, chartData: chartData)

    }
}

extension ChartDrawer: ChartViewDelegate {

    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) { }

    func chartScaled(_ chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat) { }

    func chartTranslated(_ chartView: ChartViewBase, dX: CGFloat, dY: CGFloat) { }

    func chartValueNothingSelected(_ chartView: ChartViewBase) { }
}
