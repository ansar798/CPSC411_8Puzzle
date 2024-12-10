import Foundation

class GameModel: ObservableObject {
    @Published var grid: [Int]
    var gridSize: Int
    var emptyIndex: Int
    var moveHistory: [Item] = [] // To store the history of moves

    init(gridSize: Int) {
        self.gridSize = gridSize
        self.grid = Array(1..<(gridSize * gridSize))
        self.grid.shuffle()
        self.grid.append(0)
        // Ensure emptyIndex is initialized after grid is set up
        self.emptyIndex = self.grid.firstIndex(of: 0)!
    }

    func moveTile(at index: Int) {
        if isValidMove(index: index) {
            grid.swapAt(emptyIndex, index)
            emptyIndex = index
            logMove(index: index) // Log each move
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
}