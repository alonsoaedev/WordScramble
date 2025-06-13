//
//  ContentView.swift
//  WordScramble
//
//  Created by Alonso Acosta Enriquez on 12/08/24.
//

import SwiftUI

struct ContentView: View {
    func testBundles() {
        if let fileURL = Bundle.main.url(forResource: "somefile", withExtension: "txt") {
            if let fileContent = try? String(contentsOf: fileURL) {
                print(fileContent)
            }
        }
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
