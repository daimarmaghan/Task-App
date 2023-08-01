//
//  todoadd.swift
//  quick todo
//
//  Created by Daim Armaghan on 14/06/2023.
//

import SwiftUI

struct todoadd: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationView
    @State var todotext=""
    @FocusState var focus: Bool
    var body: some View {
            VStack{
                TextField("Enter todo text..", text:$todotext)
                    .submitLabel(.go)
                    .onSubmit {
                        addItem()
                    }
                    .multilineTextAlignment(.center)
                    .focused($focus)
                    .font(.largeTitle)
                    .padding()
                    .toolbar{
                        ToolbarItem {
                            Button(action:addItem) {
                                Text("Add to list")
                            }
                        }
                    }
                Spacer()
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5)
                {
                    focus=true
                }
            }
    }
    private func addItem() {
            let newtodo = ToDo(context: viewContext)
            newtodo.text = todotext
            do {
                try viewContext.save()
                presentationView.wrappedValue.dismiss()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
    }
}

struct todoadd_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            todoadd()
        }
    }
}
