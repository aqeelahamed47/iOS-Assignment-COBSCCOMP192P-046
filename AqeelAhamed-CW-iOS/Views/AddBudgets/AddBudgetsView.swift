//
//  AddBudgetsView.swift
//  AqeelAhamed-CW-iOS
//
//  Created by Aqeel Ahamed on 2023-09-28.
//

import SwiftUI

struct AddBudgetsView: View {
    
    @StateObject var viewModel: AddBudgetViewModel = AddBudgetViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView{
                VStack(alignment: .center){
                    ForEach(0..<viewModel.categories.categories.count, id: \.self){ index in
                        CatergoryItemView(index: index, item: $viewModel.categories.categories[index])
                    }
                    Spacer()
                    
                    Button(action: {
                        viewModel.addData { status in
                            if(status){
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }) {
                       
                        Text("Update Data")
                            .font(.system(size: 14))
                    }
                    .frame(width: geometry.size.width/1.1)
                    .frame(height: geometry.size.height/14)
                    .background(Color.blue)
                    .cornerRadius(40)
                    .shadow(radius: 6)
                    .foregroundColor(Color.white)
                    
                    Spacer()
                }.onAppear {
                    viewModel.subscribe()
                }
            }
        }.navigationTitle("Add budget for categories").navigationBarBackButtonHidden(true)
    }
}

struct CatergoryItemView:View {
    @State var index:Int
    @Binding var item:CategoryItem
    
    var body: some View{
        VStack(alignment: .leading){
            Text(item.name)
                .font(.footnote)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color.gray)
                .multilineTextAlignment(.leading)
            HStack{
                TextField("", text: $item.budget)
                   .font(.system(size: 15))
                   .textFieldStyle(OutlinedTextFieldStyle())
                   .font(.headline)
                   .cornerRadius(10)
                   .shadow(radius: 1.0)
                   .frame(height: 40)
                   .textInputAutocapitalization(.never)
                
                Text("Rs")
                    .font(.system(size: 15))
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.leading)
            }
        
        }.padding()
 
    }
}

struct AddBudgetsView_Previews: PreviewProvider {
    static var previews: some View {
        AddBudgetsView()
    }
}
