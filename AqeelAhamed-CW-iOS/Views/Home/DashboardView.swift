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
                        
                    }.onAppear {
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
                }.navigationDestination(
                    isPresented: $navTransaction) {
                        AddTransactionView()
                    }.padding()
            }.onAppear {
                viewModelAuth.subscribe()
            }
        }.padding()
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
