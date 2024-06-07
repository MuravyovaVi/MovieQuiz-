import Foundation

struct GameResult: Codable, Comparable {
    let correct: Int
    let total: Int
    let date: Date
    
    func isBetterThan(_ another: GameResult) -> Bool {
        correct > another.correct
    }
    
    static func < (lhs: GameResult, rhs: GameResult) -> Bool {
        return lhs.correct < rhs.correct
    }
}
