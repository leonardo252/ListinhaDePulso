//
//  ContentView.swift
//  ListinhaDePulso
//
//  Created by Leonardo Gomes on 14/08/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State private var isAdding = false
    
    var body: some View {
        NavigationView {
            
            List {
                ForEach(items) { item in
                    HStack {
                        Text(item.name ?? "Nada")
                        Text(" \(item.quantitty)")
                        
                        
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Listinha de Pulso")
            .toolbar(content: {
                
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    
//                    NavigationLink(destination: AddingItemView(), isActive: $isAdding) {
                        
                        Button(action: {
                            isAdding = true
//                            addItem()
                        }) {
                            Image(systemName: "plus")
                                .imageScale(.large)
                                .foregroundColor(.green)
                        }
                        .sheet(isPresented: $isAdding) {
                            AddingItemView()
                        }
//                    }
                })
                
            })
            
            
        }
    }
    
    
    //    var body: some View {
    //        List {
    //            ForEach(items) { item in
    //                Text("Item at \(item.timestamp!, formatter: itemFormatter)")
    //            }
    //            .onDelete(perform: deleteItems)
    //        }
    //        .toolbar {
    //            #if os(iOS)
    //            EditButton()
    //            #endif
    //
    //            Button(action: addItem) {
    //                Label("Add Item", systemImage: "plus")
    //            }
    //        }
    //    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.name = "Produtinho"
            newItem.quantitty = Int64.random(in: 1...10)
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
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
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

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
