//
//  ContentView.swift
//  WordScramble
//
//  Created by Alonso Acosta Enriquez on 12/08/24.
//

import SwiftUI

struct ContentView: View {
    let people = ["Finn", "Leia", "Luke", "Rey"]
    
    var body: some View {
        List {
            Section("Section 1") {
                Text("Static row 1")
                Text("Static row 2")
            }
            
            Section("Section 2") {
                ForEach(0..<5) { number in
                    Text("Dynamic row \(number)")
                }
            }
            
            Section("Section 3") {
                Text("Static row 3")
                Text("Static row 4")
            }
        }
        .listStyle(.grouped)
        
        List(5..<10) {
            Text("Dynamic row \($0)")
        }
        
        List(people, id: \.self) { person in
            Text("\(person)")
        }
    }
}

#Preview {
    ContentView()
}
