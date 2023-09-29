//
//  ChartView.swift
//  AqeelAhamed-CW-iOS
//
//  Created by Aqeel Ahamed on 2023-09-29.
//

import SwiftUI
import DGCharts

struct ChartView: UIViewRepresentable {
    
    var label: String, entries: [PieChartDataEntry]
    
    func makeUIView(context: Context) -> PieChartView {
        let pieChartView = PieChartView()
        pieChartView.holeColor = UIColor.gray.withAlphaComponent(0.2)
        return pieChartView
    }
    
    func updateUIView(_ uiView: PieChartView, context: Context) {
        let dataSet = PieChartDataSet(entries: entries, label: label)
        dataSet.valueFont = UIFont.init(name: "Inter-Bold", size: 18) ?? .systemFont(ofSize: 18, weight: .bold)
        dataSet.entryLabelFont = UIFont.init(name: "Inter-Light", size: 14)
        dataSet.colors = [UIColor.red] + [UIColor.blue] + [UIColor.green] + [UIColor.cyan]
        uiView.data = PieChartData(dataSet: dataSet)
    }
}

struct ChartModel {
    var transType: String, transAmount: Double
    static func getTransaction(transactions: [ChartModel]) -> [PieChartDataEntry] {
        return transactions.map { PieChartDataEntry(value: $0.transAmount, label: $0.transType) }
    }
}
