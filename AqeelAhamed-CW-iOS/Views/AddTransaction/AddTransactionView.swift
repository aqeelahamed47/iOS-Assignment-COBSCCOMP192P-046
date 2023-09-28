//
//  AddTransactionView.swift
//  AqeelAhamed-CW-iOS
//
//  Created by Aqeel Ahamed on 2023-09-28.
//

import SwiftUI

struct AddTransactionView: View {
    @StateObject var viewModel: AddTransactionViewModel = AddTransactionViewModel()
    
    let typeOptions = [
        DropdownOption(key: "Income", val: "Income"),
        DropdownOption(key: "Expense", val: "Expense")
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView{
                TextField("Title", text: $viewModel.transaction.title)
                    .font(.system(size: 15))
                    .textFieldStyle(OutlinedTextFieldStyle())
                    .font(.headline)
                    .cornerRadius(10)
                    .shadow(radius: 1.0)
                    .frame(height: 40)
                    .textInputAutocapitalization(.never)
                    .padding(.top,20)
                
                TextField("Amount", text: $viewModel.transaction.title)
                    .font(.system(size: 15))
                    .textFieldStyle(OutlinedTextFieldStyle())
                    .font(.headline)
                    .cornerRadius(10)
                    .shadow(radius: 1.0)
                    .frame(height: 40)
                    .textInputAutocapitalization(.never)
                    .padding(.top,10)
                
                DropdownButton(shouldShowDropdown:  $viewModel.showTypeDrop, displayText: $viewModel.transaction.transactionType,
                               options: typeOptions, mainColor: Color.black,
                               backgroundColor: Color.gray.opacity(0.1), cornerRadius: 4, buttonHeight: 50) { key in
                    let selectedObj = typeOptions.filter({ $0.key == key }).first
                    if let object = selectedObj {
                        viewModel.transaction.transactionType = object.val
                        viewModel.selectedTransactionType = key
                    }
                    viewModel.showTypeDrop = false
                }.padding(.top,10)
                
                HStack {
                    DatePicker("PickerView", selection: $viewModel.transaction.createdAt,
                               displayedComponents: [.date, .hourAndMinute]).labelsHidden()
                    Spacer()
                }
                .frame(height: 40)
                .frame(maxWidth: .infinity)
                .accentColor(Color.blue)
                .cornerRadius(4)
                .padding(.top,10)
                
                TextField("Note", text: $viewModel.transaction.note, axis: .vertical)
                    .font(.system(size: 15))
                    .textFieldStyle(OutlinedTextFieldStyle())
                    .font(.headline)
                    .cornerRadius(10)
                    .shadow(radius: 1.0)
                    .frame(height: 70)
                    .textInputAutocapitalization(.never)
                    .padding(.top,10)
                
                Button(action: {
                  
                }) {
                    Text("Add Transaction")
                        .font(.system(size: 14))
                }
                .frame(width: geometry.size.width/1.1)
                .frame(height: geometry.size.height/14)
                .background(Color.blue)
                .cornerRadius(40)
                .shadow(radius: 6)
                .foregroundColor(Color.white)
            }.navigationTitle("Add Transaction")
        }
    }
}

struct AddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        AddTransactionView()
    }
}
