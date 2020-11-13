//
//  AboutViewController.swift
//  Pocketcube
//
//  Created by Miguel Pimentel on 12/11/20.
//

import UIKit
import Charts



class AboutViewController: UIViewController, ChartViewDelegate {


    var drawer = ChartDrawer()

    lazy var chartView: LineChartView = {
        let view = LineChartView()
        view.backgroundColor = .white
        return view
    }()


    override func viewDidLoad() {
       super.viewDidLoad()
        setup()
        drawer.createSimpleChart(lineChartView: chartView)

    }

    private func setup() {
        view.addSubview(chartView)

        chartView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
    }
}
