//
//  ChartFilterView.swift
//  AqeelAhamed-CW-iOS
//
//  Created by Aqeel Ahamed on 2023-09-29.
//

import SwiftUI

struct ChartFilterView: View {
    @StateObject var viewModel: ChartFilterViewModel
    
    var body: some View {
        ChartView(label: "", entries: viewModel.pieChartData)
        
    }
}
