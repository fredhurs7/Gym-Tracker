//
//  ContentView.swift
//  Shared
//
//  Created by Freddie Hurson on 7/30/23.
//

import SwiftUI

struct Excersise{
    
    private var name: String
    private var type: String
    init(nameOfE: String, typeString: String){
        name = nameOfE
        type = typeString
    }
   
}
struct GridCell: Identifiable {
    let id = UUID()
    var name: String
}


struct ContentView: View {
    @State var selectedTab = "One"
    @State private var isPopupOpen = false
    @State private var buttonFrame: CGRect = .zero
    @State private var gridCells: [GridCell] = [
        GridCell(name: "Squats"),
        GridCell(name: "Deadlift"),
        GridCell(name: "Pull-Ups")
    ]
    @State private var newCellName = ""
    var body: some View {
        
        TabView(){
         
            ZStack{
                VStack {
                           HStack {
                               TextField("New Cell Name", text: $newCellName)
                                   .padding()
                               Button("Add Cell") {
                                   gridCells.append(GridCell(name: newCellName))
                                   newCellName = ""
                               }
                               .padding()
                           }

                           ScrollView {
                               LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 2), spacing: 30) {
                                   ForEach(gridCells) { cell in
                                       GridItemView(cell: cell)
                                   }
                                   Button(action: {isPopupOpen = true}){
                                       Image(systemName: "plus.circle").resizable().frame(width: 75, height: 75)
                                   }.foregroundStyle(.gray)
                               }.overlay(
                                Group{
                                   if isPopupOpen{
                                       
                                       PopupView(isOpen: $isPopupOpen, eName:$newCellName).overlay(RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black, lineWidth: 1)
                                       )
                            
                                   }
                                } )
                               }
                               .padding()
                           }
                    
                }
                .tabItem{
                    Label("excersises", systemImage: "atom")
                }
        
            Text("LiftPlans")
                .tabItem{
                    Label("lift plans", systemImage: "book")
                }
            Text("Calendar")
                .tabItem{
                    Label("calendar", systemImage: "calendar")
                }
        }
    }
}
struct GridItemView: View {
    let cell: GridCell
    
    var body: some View {
        VStack {
            Text(cell.name).font(.headline).foregroundStyle(Color(red: 0.2, green: 0.2, blue: 0.2)).padding()
            
            Image(systemName: "atom").resizable().frame(width: 45, height: 45).foregroundStyle(Color(red: 0.6, green: 0.8, blue: 0.6))
                               
        }.frame(width: 150, height: 150).overlay(
            RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 1)
        )
    }
}
struct ButtonFramePreferenceKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
struct PopupView: View {
    @Binding var isOpen: Bool
    @Binding var eName: String

    
    var body: some View {
        VStack {
            Text("Add an Excersise")
                .font(.title)
                .padding()
            TextField("New Cell Name", text: $eName)
                .padding()
            
            Button("Close") {
                isOpen = false
            }
            .padding()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
