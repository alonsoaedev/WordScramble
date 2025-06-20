//
//  ContentView.swift
//  WordScramble
//
//  Created by Alonso Acosta Enriquez on 12/08/24.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showError = false
    
    @State private var score = 0
    
    func startGame() {
        if let startWordURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                usedWords.removeAll()
                score = 0
                return
            }
        }
        fatalError("Could not load start.txt from bundle.")
    }
    
    func addNewWord() {
        let answer = newWord
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !answer.isEmpty else { return }
        
        guard isOriginal(word: answer) else {
            wordError(
                title: "Word used already",
                message: "Be more original!!"
            )
            score -= 1
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(
                title: "Word not possible",
                message: "You can't spell that word from '\(rootWord)'!!"
            )
            score -= 1
            return
        }
        
        guard isReal(word: answer) else {
            wordError(
                title: "Word not recognized",
                message: "You can't just make them up, you know!!"
            )
            score -= 1
            return
        }
        
        guard isLarge(word: answer) else {
            wordError(
                title: "Word too short",
                message: "You can't use a word of one or two characters!!"
            )
            score -= 1
            return
        }
        
        guard isDiffStartedWord(word: answer) else {
            wordError(
                title: "Started word",
                message: "You can't use the started word, don't be silly!!"
            )
            score -= 1
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
        score += 1 + answer.count
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(
            in: word,
            range: range,
            startingAt: 0,
            wrap: false,
            language: "en"
        )
        return misspelledRange.location == NSNotFound
    }
    
    func isLarge(word: String) -> Bool {
        word.count >= 3
    }
    
    func isDiffStartedWord(word: String) -> Bool {
        word != rootWord
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showError = true
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word: ", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showError) {
                Button("OK") {  }
            } message: {
                Text(errorMessage)
            }
            .toolbar {
                Button("New Game", action: startGame)
            }
        }
        Text("Score: \(score)")
            .font(.largeTitle)
    }
}

#Preview {
    ContentView()
}
