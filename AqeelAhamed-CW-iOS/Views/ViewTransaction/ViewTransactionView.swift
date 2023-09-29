//
//  ViewTransactionView.swift
//  AqeelAhamed-CW-iOS
//
//  Created by Aqeel Ahamed on 2023-09-29.
//

import SwiftUI

struct ViewTransactionView: View {
    @StateObject var viewModel: ViewTransactionViewModel
    
    func getDateFormatter(date: Date?, format: String = "yyyy-MM-dd") -> String {
        guard let date = date else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    Text("Title")
                        .font(.system(size: 15))
                    Spacer()
                }
                
                TextField("", text: $viewModel.transaction.title)
                    .font(.system(size: 15))
                    .textFieldStyle(OutlinedTextFieldStyle())
                    .font(.headline)
                    .cornerRadius(10)
                    .shadow(radius: 1.0)
                    .frame(height: 40)
                    .textInputAutocapitalization(.never)
                    .disabled(true)
            }.padding(.top,20)
            
            VStack{
                HStack{
                    Text("Amount")
                        .font(.system(size: 15))
                    Spacer()
                }
                
                TextField("", text: $viewModel.transaction.amount)
                    .font(.system(size: 15))
                    .textFieldStyle(OutlinedTextFieldStyle())
                    .font(.headline)
                    .cornerRadius(10)
                    .shadow(radius: 1.0)
                    .frame(height: 40)
                    .textInputAutocapitalization(.never)
                    .disabled(true)
            } .padding(.top,10)
            
            VStack{
                HStack{
                    Text("Category")
                        .font(.system(size: 15))
                    Spacer()
                }
                
                
                TextField("", text: $viewModel.transaction.category.name)
                    .font(.system(size: 15))
                    .textFieldStyle(OutlinedTextFieldStyle())
                    .font(.headline)
                    .cornerRadius(10)
                    .shadow(radius: 1.0)
                    .frame(height: 40)
                    .textInputAutocapitalization(.never)
                
                    .disabled(true)
            } .padding(.top,10)
            
            VStack{
                HStack{
                    Text("Transaction Type")
                        .font(.system(size: 15))
                    Spacer()
                }
                
                TextField("", text: $viewModel.transaction.transactionType)
                    .font(.system(size: 15))
                    .textFieldStyle(OutlinedTextFieldStyle())
                    .font(.headline)
                    .cornerRadius(10)
                    .shadow(radius: 1.0)
                    .frame(height: 40)
                    .textInputAutocapitalization(.never)
                
                    .disabled(true)
            }.padding(.top,10)
            
            VStack{
                HStack{
                    Text("Created At")
                        .font(.system(size: 15))
                    Spacer()
                }
                
                HStack{
                    Text(getDateFormatter(date: viewModel.transaction.createdAt, format: "MMM dd, yyyy hh:mm"))
                        .font(.system(size: 15))
                        .textFieldStyle(OutlinedTextFieldStyle())
                        .font(.headline)
                        .cornerRadius(10)
                        .shadow(radius: 1.0)
                        .frame(height: 40)
                        .textInputAutocapitalization(.never)
                    Spacer()
                }

               
            }.padding(.top,10)
            
            VStack{
                HStack{
                    Text("Note")
                    .font(.system(size: 15))
                    Spacer()
                }
                
                TextField("", text: $viewModel.transaction.note, axis: .vertical)
                    .font(.system(size: 15))
                    .textFieldStyle(OutlinedTextFieldStyle())
                    .font(.headline)
                    .cornerRadius(10)
                    .shadow(radius: 1.0)
                    .textInputAutocapitalization(.never)
                    .disabled(true)
            } .padding(.top,10)
        }.navigationTitle("View Transaction")
        
    }
}
