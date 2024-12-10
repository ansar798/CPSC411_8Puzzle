import Foundation

class GameModel: ObservableObject {
    @Published var grid: [Int]
    var gridSize: Int
    var emptyIndex: Int
    var moveHistory: [Item] = [] // To store the history of moves
    var gameWon: Bool = false // To track if the game is won

    init(gridSize: Int) {
        self.gridSize = gridSize
        
        // Create the grid
        var initialGrid = Array(1..<(gridSize * gridSize))
        initialGrid.shuffle()
        initialGrid.append(0)
        
        // Assign to the grid property
        self.grid = initialGrid
        
        // Calculate the emptyIndex
        self.emptyIndex = initialGrid.firstIndex(of: 0)!
    }

    func moveTile(at index: Int) {
        print("Attempting to move tile at index \(index)")
        if isValidMove(index: index) {
            print("Move is valid")
            grid.swapAt(emptyIndex, index)
            emptyIndex = index
            logMove(index: index) // Log each move
            checkGameWon() // Check if the game is won after the move
        } else {
            print("Move is invalid")
        }
    }

    private func isValidMove(index: Int) -> Bool {
        let emptyRow = emptyIndex / gridSize
        let emptyCol = emptyIndex % gridSize
        let tileRow = index / gridSize
        let tileCol = index % gridSize
        return (abs(emptyRow - tileRow) == 1 && emptyCol == tileCol) ||
               (abs(emptyCol - tileCol) == 1 && emptyRow == tileRow)
    }

    func isGameWon() -> Bool {
        for i in 0..<grid.count - 1 {
            if grid[i] != i + 1 {
                return false
            }
        }
        return grid.last == 0
    }

    private func logMove(index: Int) {
        let move = Item(timestamp: Date())
        moveHistory.append(move)
    }

    func resetGame() {
        var newGrid = Array(1..<(gridSize * gridSize))
        newGrid.shuffle()
        newGrid.append(0)
        grid = newGrid
        emptyIndex = newGrid.firstIndex(of: 0)!
        moveHistory.removeAll() // Clear the move history
    }

    func checkGameWon() {
        if isGameWon() {
            DispatchQueue.main.async {
                self.gameWon = true // Notify the view model that the game is won
            }
        }
    }
}
