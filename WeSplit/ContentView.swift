//
//  ContentView.swift
//  WeSplit
//
//  Created by Muhammad Fahmi on 17/08/23.
//

import SwiftUI

struct ContentView: View {
    @State private var bills = 0.0
    @State private var people = 2
    @State private var tipPercentage = 10
//    let tipPercentages = [0, 10, 15, 20, 25]
    @FocusState private var amountIsFocus: Bool // for hide the keyboard
    
    var grandTotal: Double{
        let tipSelection = Double(tipPercentage)
        let tipValue = bills * tipSelection / 100
        let grandTotal = bills + tipValue
        return grandTotal
    }
    
    var totalAmountPerPerson: Double{
        let peopleCount = Double(people + 2)
        let amountPerPerson = grandTotal/peopleCount
        return amountPerPerson
    }
    
    var formatIDR: FloatingPointFormatStyle<Double>.Currency{
        return .currency(code: Locale.current.currency?.identifier ?? "IDR")
    } // format a double in IDR currency to be able to call computed properties
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Amout of tip", value: $bills, format: formatIDR)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocus)
                    Picker("Number of People", selection: $people){
                        ForEach (2..<100) {
                            Text("\($0) People")
                        }
                    }
                }
                
                Section{
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(0..<101){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                } header: {
                    Text("How much do you want to leave?")
                }
                
                Section{
                    Text(totalAmountPerPerson, format: formatIDR)
                } header: {
                    Text("Amount per person")
                }
                Section{
                    Text(grandTotal, format: formatIDR) // call computed properties formatIDR
                } header: {
                    Text("Total amount")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done"){
                        amountIsFocus = false //hide keyboard if false/ done pressed
                    }
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
