//
//  DashboardView.swift
//  AqeelAhamed-CW-iOS
//
//  Created by Aqeel Ahamed 2023-09-24.
//

import SwiftUI

struct DashboardView: View {
    
    @StateObject var viewModel: DashboardViewModel = DashboardViewModel()
    @EnvironmentObject var viewModelAuth: AuthenticationViewModel
    @State var navTransaction = false
    @State var navTransactionView = false
    @State private var showFilters = false
    @State var selectedTransactionItem:TransactionModel?
    
    var body: some View {
        NavigationStack{
            ZStack {
                ScrollView{
                    VStack{
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(maxWidth: .infinity, minHeight: 80)  .overlay(
                                VStack{
                                    Text("Total Budget")
                                        .font(.system(size: 14))
                                        .fontWeight(.medium)
                                        .foregroundColor(Color.black.opacity(0.5))
                                        .multilineTextAlignment(.center)
                                    
                                    Text("Rs. \(viewModel.totalBudget.budget)")
                                        .font(.system(size: 18))
                                        .fontWeight(.medium)
                                        .foregroundColor(Color.black)
                                        .multilineTextAlignment(.center).padding(.top,8)
                                    
                                }
                            ) .cornerRadius(10)
                        if(viewModel.isNoTransactions){
                            VStack {
                                Spacer()
                                VStack{
                                    Text("No Transaction Yet!")
                                        .foregroundColor(Color.black)
                                        .fontWeight(.semibold)
                                        .font(.system(size: 20))
                                    
                                    Text("Add a transaction and it will show up here")
                                        .foregroundColor(Color.black)
                                        .fontWeight(.regular)
                                        .font(.system(size: 16))
                                        .padding(.top, 2)
                                }.padding(.top,200)
                                Spacer()
                            }.padding(.horizontal)
                        }else{
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(maxWidth: .infinity, minHeight: 80)
                                .overlay(
                                    NavigationLink(destination:  ChartFilterView(viewModel:ChartFilterViewModel(transactions: viewModel.transactions, chartType: .income)), label: {
                                        VStack{
                                            Spacer()
                                            Text("Income")
                                                .font(.system(size: 14))
                                                .fontWeight(.medium)
                                                .foregroundColor(Color.black.opacity(0.5))
                                                .multilineTextAlignment(.center)
                                            
                                            Text("Rs. \(viewModel.income)")
                                                .font(.system(size: 18))
                                                .fontWeight(.medium)
                                                .foregroundColor(Color.black)
                                                .multilineTextAlignment(.center).padding(.top,8)
                                            Spacer()
                                            
                                        }
                                        
                                    })
                                ) .cornerRadius(10)
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(maxWidth: .infinity, minHeight: 80)
                                .overlay(
                                    NavigationLink(destination:  ChartFilterView(viewModel:ChartFilterViewModel(transactions: viewModel.transactions, chartType: .expense)), label: {
                                        
                                        
                                        VStack{
                                            Spacer()
                                            Text("Expenses")
                                                .font(.system(size: 14))
                                                .fontWeight(.medium)
                                                .foregroundColor(Color.black.opacity(0.5))
                                                .multilineTextAlignment(.center)
                                            
                                            Text("Rs. \(viewModel.expense)")
                                                .font(.system(size: 18))
                                                .fontWeight(.medium)
                                                .foregroundColor(Color.black)
                                                .multilineTextAlignment(.center).padding(.top,8)
                                            Spacer()
                                            
                                        }}
                                                  ))
                                .cornerRadius(10)
                            HStack{
                                Text("Transactions")
                                    .font(.system(size: 14))
                                    .fontWeight(.medium)
                                    .foregroundColor(Color.black)
                                    .multilineTextAlignment(.leading)
                                    .padding(.top, 10)
                                Spacer()
                            }
                            .actionSheet(isPresented: $showFilters) {
                                ActionSheet(title: Text("Select a filter"), buttons: [
                                    .default(Text("Overall")) {
                                        viewModel.filter = .all
                                        viewModel.subscribe()
                                    },
                                    .default(Text("Last 7 days")) {
                                        viewModel.filter = .week
                                        viewModel.subscribe()
                                    },
                                    .default(Text("Last 30 days")) {
                                        viewModel.filter = .month
                                        viewModel.subscribe()
                                    },
                                    .cancel()
                                ])
                            }
                            
                            ForEach(0..<viewModel.transactions.count, id: \.self) { index in
                                
                                NavigationLink(destination:  ViewTransactionView(viewModel: ViewTransactionViewModel(transaction:viewModel.transactions[index])), label: {
                                    TransactionListItem(transaction: $viewModel.transactions[index])
                                })
                                
                            }
                        }
                        
                        
                    }.padding(.top,20).onAppear {
                        viewModel.subscribe()
                        viewModel.getUserFromFirebase()
                    }.navigationDestination(
                        isPresented: $viewModel.navBudget) {
                            AddBudgetsView()
                        }
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            navTransaction = true
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 15))
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color.white)
                                .background(Color.blue)
                                .clipShape(Circle())
                        }
                    }
                }  .navigationViewStyle(StackNavigationViewStyle()) .navigationTitle("Dashboard").toolbar {
                    Button(action: {
                        self.showFilters.toggle()
                    }) {
                        
                        Image(systemName: "text.badge.checkmark").foregroundColor(Color.black)
                    }
                }
                
                .navigationDestination(
                    isPresented: $navTransaction) {
                        AddTransactionView()
                    }.padding()
            }.onAppear {
                viewModelAuth.subscribe()
            }
        }.padding()
    }
}

struct TransactionListItem: View {
    
    @Binding var transaction: TransactionModel
    
    func getDateFormatter(date: Date?, format: String = "yyyy-MM-dd") -> String {
        guard let date = date else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    
    var body: some View {
        HStack {
            
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(transaction.title)
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.center)
                    Spacer()
                    Text("\(transaction.transactionType == "Income" ? "+":"-") Rs. \(transaction.amount)")
                        .font(.system(size: 14))
                        .fontWeight(.regular)
                        .foregroundColor(transaction.transactionType == "Income" ? Color.green:Color.red)
                        .multilineTextAlignment(.center)
                }
                HStack {
                    
                    Text(transaction.category.name)
                        .font(.system(size: 12))
                        .fontWeight(.regular)
                        .foregroundColor(Color.black.opacity(0.8))
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    Text(getDateFormatter(date: transaction.createdAt, format: "MMM dd, yyyy"))
                        .font(.system(size: 12))
                        .fontWeight(.regular)
                        .foregroundColor(Color.black.opacity(0.5))
                        .multilineTextAlignment(.center)
                }
            }.padding(.leading, 4)
            
            Spacer()
            
        }.padding(8).background(Color.gray.opacity(0.1)).cornerRadius(4)
    }
}

