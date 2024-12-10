//
//  ContentView.swift
//  8PuzzleApplication
//
//  Created by Ansar Shaikh on 12/9/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                Text("Welcome to 8-Puzzle Game")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .shadow(color: .black.opacity(0.2), radius: 5)

                Spacer()

                VStack(spacing: 25) {
                    DifficultyButton(text: "Easy", iconName: "tortoise.fill", color: .green, gridSize: 3)
                    DifficultyButton(text: "Medium", iconName: "hare.fill", color: .yellow, gridSize: 4)
                    DifficultyButton(text: "Hard", iconName: "ant.fill", color: .red, gridSize: 5)
                }
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.purple.opacity(0.3)]),
                            startPoint: .top,
                            endPoint: .bottom
                        ))
                        .shadow(color: .black.opacity(0.3), radius: 10)
                )

                Spacer()

                Text("Select your difficulty level and start solving!")
                    .font(.footnote)
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.bottom, 20)
            }
            .padding()
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue, Color.purple]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
            )
            .navigationBarHidden(true)
        }
    }

    private func DifficultyButton(text: String, iconName: String, color: Color, gridSize: Int) -> some View {
        NavigationLink(destination: GameView(gridSize: gridSize)) {
            HStack {
                Image(systemName: iconName)
                    .font(.title2)
                    .foregroundColor(.white)
                Text(text)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(color.opacity(0.9))
            .cornerRadius(12)
            .shadow(color: color.opacity(0.5), radius: 5)
        }
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}