//
//  AddingItemView.swift
//  ListinhaDePulso
//
//  Created by Leonardo Gomes on 14/08/21.
//

import SwiftUI

struct AddingItemView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    
    @State private var productName: String = ""
    @State private var productQuant: Int = 1
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                }
                
                Spacer()
                
                Button(action: {
                    addItem()
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Salvar")
                }
            }
            
            VStack(alignment: .leading) {
                Text("Nome do Produto")
                    .font(.title2)
                TextField("Nome", text: $productName)
            }
                        
            HStack() {
                Text("Quantidade")
                    .font(.title2)
                Spacer()
                Picker("", selection: $productQuant) {
                    ForEach(1 ..< 50, id: \.self) {
                        Text("\($0)")
                    }
                }
                .frame(width: 200, height: 30, alignment: .trailing)
            }
            Spacer()
            
            //            VStack {
            //                Text("Nome do Produto")
            //                    .padding(.leading, 0)
            //                TextField("Nome", text: $productName)
            //            }
            //            .padding(.trailing, 10)
            //            .padding(.leading, 10)
            //            VStack {
            //                Text("Quantidade")
            //                TextField("Quantidade", text: $productQuant)
            //                    .keyboardType(.numberPad)
            //            }
            //            .padding(.trailing, 10)
            //            .padding(.leading, 10)
            //
            //            Button(action: {
            //                addItem()
            //                self.presentationMode.wrappedValue.dismiss()
            //            }) {
            //                Text("Salvar")
            //            }
            //            .accentColor(.green)
            //            .foregroundColor(.green)
            //
            //        }
            //        .padding(.trailing, 10)
            //        .padding(.leading, 10)
        }
        .padding(.all)
        .padding(.top, 24)
        
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.name = productName
            newItem.quantitty = Int64(productQuant)
            newItem.timestamp = Date()
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}



struct AddingItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddingItemView()
    }
}
