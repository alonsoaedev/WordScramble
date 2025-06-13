//
//  ContentView.swift
//  WordScramble
//
//  Created by Alonso Acosta Enriquez on 12/08/24.
//

import SwiftUI

struct ContentView: View {
    func testStrings() {
        let input = """
        a
        b
        c
        """
        let letters = input.components(separatedBy: "\n")
        let letter = letters.randomElement()
        let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func misspelledWords() {
        let word = "swift"
        let checker = UITextChecker()
        
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(
            in: word,
            range: range,
            startingAt: 0,
            wrap: false,
            language: "en"
        )
        let allGood = misspelledRange.location == NSNotFound
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
