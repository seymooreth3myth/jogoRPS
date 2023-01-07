//
//  ContentView.swift
//  jogoRPS
//
//  Created by Fábio Carlos de Souza on 07/01/23.
//

import SwiftUI

struct ContentView: View {
    @State private var gameOptions = ["✊", "✋", "✌️"].shuffled()
    @State private var userOptions = ["✊", "✋", "✌️"].shuffled()
    @State private var botMachine = ""
    
    @State private var mostrarResultado = false
    @State private var tentativas = 0
    @State private var pontos = 0
    @State private var cadaUmJogou = ""
    
    var body: some View {
        
        ZStack() {
            RadialGradient(colors: [Color(.systemTeal), Color(.systemPurple)], center: .top, startRadius: 300, endRadius: 700)
                .ignoresSafeArea()
            if tentativas < 8 {
                VStack(spacing: 15) {
                    Spacer()
                    VStack {
                        Text("Escolha uma opção:")
                            .font(.largeTitle.weight(.bold))
                    }
                    
                    HStack {
                        ForEach(0..<3) { number in
                            Button {
                                tocouNaOpcao(userOptions[number])
                            } label: {
                                Text(userOptions[number])
                                    .shadow(radius: 5)
                                    .font(.largeTitle)
                            }
                            
                        }
                    }
                    Spacer()
                    Text("Placar: \(pontos)")
                        .foregroundColor(.white)
                        .font(.title)
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                Spacer()
            } else {
                VStack(spacing: 15) {
                    Spacer()
                    VStack {
                        Text("Resultado do jogo:")
                            .font(.largeTitle.weight(.bold))
                    }
                    Text(pontos == 0 ? "Empate" : pontos < 0 ? "Derrota" : "Vitória")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    Spacer()
                    Text("Placar: \(pontos)")
                        .foregroundColor(.white)
                        .font(.title)
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                Spacer()
            }
        }
        .alert(cadaUmJogou, isPresented: $mostrarResultado) {
            Button("Jogar novamente", action: perguntar)
        }
    }
    
    func tocouNaOpcao(_ number: String) {
        botMachine = gameOptions.randomElement()!
        if number == botMachine {
            cadaUmJogou = "Você \(number)x \(botMachine) Máquina - Empate"
        } else {
            if(number == "✊") {
                if(botMachine == "✋") {
                    pontos -= 1
                    cadaUmJogou = "Você \(number)x \(botMachine) Máquina - Derrota"
                }
                if (botMachine == "✌️") {
                    pontos += 1
                    cadaUmJogou = "Você \(number)x \(botMachine) Máquina - Vitória"
                }
            } else if (number == "✋") {
                if(botMachine == "✌️") {
                    pontos -= 1
                    cadaUmJogou = "Você \(number)x \(botMachine) Máquina - Derrota"
                }
                if (botMachine == "✊") {
                    pontos += 1
                    cadaUmJogou = "Você \(number)x \(botMachine) Máquina - Vitória"
                }
            } else {
                if(botMachine == "✊") {
                    pontos -= 1
                    cadaUmJogou = "Você \(number)x \(botMachine) Máquina - Derrota"
                }
                if (botMachine == "✋") {
                    pontos += 1
                    cadaUmJogou = "Você \(number)x \(botMachine) Máquina - Vitória"
                }
            }
            
        }
        tentativas = tentativas + 1;
        print(tentativas)
        mostrarResultado = true;
    }
    
    func perguntar() {
        gameOptions.shuffle()
        botMachine = gameOptions.randomElement()!
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
