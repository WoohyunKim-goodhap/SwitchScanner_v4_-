//
//  ChartViewController.swift
//  switchPriceKana
//
//  Created by Woohyun Kim on 2020/10/14.
//  Copyright © 2020 Woohyun Kim. All rights reserved.
//

//[ ]currency 표시
//[ ]game title 표시
//[ ]검색한 url 값 끌고 오기

import UIKit
import Charts
import SCLAlertView

class ChartViewController: UIViewController, ChartViewDelegate {

    var lineChart = LineChartView()
    var entries = [ChartDataEntry]()
    var currencyDetail = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineChart.delegate = self
        if let key = currencyDic.somekey(from: "\(currencyForChart)"){
            currencyDetail = key
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        dateSeparator.removeAll()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        lineChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        
        lineChart.center = view.center
        view.addSubview(lineChart)
        
                
        for (x, y) in chartPrices.enumerated() {
            entries.append(ChartDataEntry(x: Double(x), y: y))
        }

        let xAxis = lineChart.xAxis
        let yAxis = lineChart.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 13)
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .white
        yAxis.axisLineColor = .white
        yAxis.labelPosition = .outsideChart
        
        
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .boldSystemFont(ofSize: 13)
        xAxis.setLabelCount(4, force: true)
        xAxis.labelTextColor = .white
        xAxis.axisLineColor = .systemBlue
        xAxis.granularity = 1
        xAxis.axisMinimum = 0
        xAxis.avoidFirstLastClippingEnabled = true
        
        xAxis.valueFormatter = ChartXAxisFormatter()
        
        lineChart.rightAxis.enabled = false
        lineChart.animate(xAxisDuration: 2.0)
        
        lineChart.chartDescription?.text = "\(gameTitelForChart)"
        
        setData()
    }
    
    func setData(){
        
        let set1 = LineChartDataSet(entries: entries, label: "\(currencyDetail)")
        
        set1.drawCirclesEnabled = false
        set1.drawHorizontalHighlightIndicatorEnabled = false
        set1.lineWidth = 3
        
        let data = LineChartData(dataSet: set1)
        lineChart.data = data
    }
    
}

class ChartXAxisFormatter: NSObject, IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        let datePosition = value / Double(chartPrices.count - 1)
        
        switch datePosition {
        case 0:
            return dateSeparator[0]
        case 0.1...0.34:
            return dateSeparator[1]
        case 0.35...0.67:
            return dateSeparator[2]
        case 0.68...1:
            return dateSeparator[3]
        default:
            return ""
        }

      }
}

