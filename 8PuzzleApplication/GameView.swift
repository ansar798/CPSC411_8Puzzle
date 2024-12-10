import SwiftUI

struct GameView: View {
    @State private var model: GameModel
    @State private var showExitConfirmation = false
    @Environment(\.presentationMode) var presentationMode

    init(gridSize: Int) {
        _model = State(initialValue: GameModel(gridSize: gridSize))
    }

    var body: some View {
        VStack(spacing: 20) {
            // Grid Display
            ForEach(0..<model.gridSize, id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(0..<model.gridSize, id: \.self) { column in
                        let index = row * model.gridSize + column
                        if model.grid[index] != 0 {
                            Button(action: {
                                withAnimation {
                                    model.moveTile(at: index)
                                }
                            }) {
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

            Spacer()

            // Back Button
            Button(action: {
                showExitConfirmation = true
            }) {
                Text("Back")
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
                    primaryButton: .destructive(Text("Exit")) {
                        presentationMode.wrappedValue.dismiss()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
        .padding()
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
        .navigationBarBackButtonHidden(true)
    }
}
