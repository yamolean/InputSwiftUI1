//
//  ContentView.swift
//  SwiftUI WARIKAN App
//
//  Created by 矢守叡 on 2019/12/05.
//  Copyright © 2019 yamolean. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 0 //配列番号
    @State private var tipPercentage = 0
    let tipPercentages = [10,15,20,25,0]
    
    var totalPerPerson: Double {
        //人数,配列番号+2
        let peopleCount = Double(numberOfPeople + 2)
        //tax,配列tipPercentagesのpickerで選択された配列番号tipPercentage配列番号の値
        let tipSelection = Double(tipPercentages[tipPercentage])
        //金額,TextFieldに入力された値
        let orderAmount = Double(checkAmount) ?? 0
        
        //tax,金額かけるtax
        let tipValue = orderAmount * tipSelection / 100
        //総額
        let grandTotal = orderAmount + tipValue
        //総額割る人数
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    TextField("総額",text: $checkAmount)
                        .keyboardType(.decimalPad)
                    //selectionは選択された配列番号
                    Picker("人数",selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0)人")
                        }
                    }
                }

                Section(header: Text("何パーセントtax加算")) {
                    Picker("", selection: $tipPercentage){
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                .pickerStyle(SegmentedPickerStyle())//数字だけのパッド
                }

                Section (header: Text("一人当たり")) {
                    Text("\(totalPerPerson,specifier: "%.2f")円")
                }
            }
            .navigationBarTitle("割り勘クソアプリ")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
