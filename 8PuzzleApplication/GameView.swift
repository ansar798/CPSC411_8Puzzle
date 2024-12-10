import SwiftUI

struct GameView: View {
    @ObservedObject private var model: GameModel
    @State private var showExitConfirmation = false
    @State private var showWinAlert = false
    @Environment(\.presentationMode) var presentationMode

    init(gridSize: Int) {
        _model = ObservedObject(initialValue: GameModel(gridSize: gridSize))
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer() // Pushes everything below to the middle

                // Grid Display centered
                VStack(spacing: 20) {
                    ForEach(0..<model.gridSize, id: \.self) { row in
                        HStack(spacing: 10) {
                            ForEach(0..<model.gridSize, id: \.self) { column in
                                let index = row * model.gridSize + column
                                if model.grid[index] != 0 {
                                    Text("\(model.grid[index])")
                                        .font(.system(size: 24, weight: .bold, design: .rounded))
                                        .frame(width: 70, height: 70)
                                        .background(
                                            LinearGradient(
                                                gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.8)]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .foregroundColor(.white)
                                        .cornerRadius(12)
                                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
                                        .onTapGesture {
                                            withAnimation {
                                                model.moveTile(at: index)
                                            }
                                        }
                                } else {
                                    Rectangle()
                                        .frame(width: 70, height: 70)
                                        .foregroundColor(Color.gray.opacity(0.1))
                                        .cornerRadius(12)
                                }
                            }
                        }
                    }
                }
                Spacer() // Pushes everything above to the middle

                // End Game Button remains at the bottom
                Button(action: {
                    self.showExitConfirmation = true
                }) {
                    Text("End Game")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .frame(width: 100, height: 40)
                        .background(Color.red.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(color: Color.red.opacity(0.4), radius: 5, x: 0, y: 5)
                }
                .alert(isPresented: $showExitConfirmation) {
                    Alert(
                        title: Text("Exit Game"),
                        message: Text("Are you sure you want to exit the game?"),
                        primaryButton: .destructive(Text("Yes")) {
                            presentationMode.wrappedValue.dismiss()
                        },
                        secondaryButton: .cancel()
                    )
                }

                // Alert for game won
                .alert(isPresented: $model.gameWon) {
                    Alert(
                        title: Text("Congratulations!"),
                        message: Text("You've successfully solved the puzzle!"),
                        dismissButton: .default(Text("OK")) {
                            model.resetGame()
                        }
                    )
                }
            }
            .frame(width: geometry.size.width) // Ensure it spans the full width
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
            )
            .navigationBarBackButtonHidden(true)
            .onAppear {
                model.resetGame()
            }
        }
    }
}