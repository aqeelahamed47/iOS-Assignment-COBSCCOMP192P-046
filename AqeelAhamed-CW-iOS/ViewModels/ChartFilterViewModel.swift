//
//  ChartFilterViewModel.swift
//  AqeelAhamed-CW-iOS
//
//  Created by Aqeel Ahamed on 2023-09-29.
//

import Foundation
import DGCharts

enum ChartType: String {
    case all
    case income
    case expense
}

class ChartFilterViewModel:ObservableObject{
    
    @Published var transactions :[TransactionModel]
    @Published var chartType :ChartType
    @Published var pieChartData: [PieChartDataEntry] = []
    
    init(transactions: [TransactionModel], chartType:ChartType) {
        self.transactions = transactions
        self.chartType = chartType
        
        switch chartType {
        case .all:
            for item in transactions {
          
                    pieChartData.append(PieChartDataEntry(value: Double(item.amount)!, label: item.transactionType))
                
            }

            break;
        case .income:
            
            for item in transactions {
                if(item.transactionType == "Income"){
                    pieChartData.append(PieChartDataEntry(value: Double(item.amount)!, label: item.category.name))
                }
            }
            
            break;
        case .expense:
            for item in transactions {
                if(item.transactionType == "Expense"){
                    pieChartData.append(PieChartDataEntry(value: Double(item.amount)!, label: item.category.name))
                }
            }
            break;
        default:
            break;
        }
    }
}
