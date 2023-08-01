//
//  todoview.swift
//  quick todo
//
//  Created by Daim Armaghan on 14/06/2023.
//

import SwiftUI
import CoreData

struct todoview: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ToDo.text, ascending: true)],
        animation: .default)
    
    private var todo: FetchedResults<ToDo>

    
    var body: some View {
        @State var todotext=""
        NavigationView{
                VStack{
                    List{
                        ForEach(todo){
                            item in
                            NavigationLink(destination: Text(item.text!)
                                .font(.largeTitle)
                                .padding())
                            {
                                Text(item.text!).lineLimit(1)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                        .background(.clear)
                    .toolbar{
                        ToolbarItem {
                            NavigationLink(destination: todoadd()){
                                Label("Add Item", systemImage: "plus")
                            }
                        }
                    }
                }
                .navigationTitle("Task App")
                .font(.subheadline)
            //.foregroundColor(Color.white)
        }
        
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { todo[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}



struct todoview_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            todoview()
        }
    }
}
