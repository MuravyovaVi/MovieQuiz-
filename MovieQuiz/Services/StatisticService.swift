import Foundation

final class StatisticService: StatisticServiceProtocol {
    private let storage: UserDefaults = .standard
    private enum Keys: String {
        case correctAnswers, totalQuestions, bestGame, gamesCount
    }
    
    private var correctAnswers: Int {
        get {
            storage.integer(forKey: Keys.correctAnswers.rawValue)
        }
        set {
            storage.set(newValue, forKey: Keys.correctAnswers.rawValue)
        }
    }
    
    private var totalQuestions: Int {
        get {
            storage.integer(forKey: Keys.totalQuestions.rawValue)
        }
        set {
            storage.set(newValue, forKey: Keys.totalQuestions.rawValue)
        }
    }
    
    var gamesCount: Int {
        get {
            storage.integer(forKey: Keys.gamesCount.rawValue)
        }
        set {
            storage.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }
    
    var bestGame: GameResult {
        get {
            guard let data = storage.data(forKey: Keys.bestGame.rawValue),
                  let recordBestGame = try? JSONDecoder().decode(GameResult.self, from: data) else {
                return GameResult(correct: 0, total: 0, date: Date())
            }
            return recordBestGame
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                return
            }
            storage.set(data, forKey: Keys.bestGame.rawValue)
        }
    }
    
    var totalAccuracy: Double?{
        guard totalQuestions != 0 else {
            return nil
        }
        return (Double(correctAnswers) / Double(totalQuestions)) * 100
    }
    
    func store(correct count: Int, total amount: Int) {
        correctAnswers += count
        totalQuestions += amount
        gamesCount += 1
        
        let newRecord = GameResult(correct: count, total: amount, date: Date())
        if newRecord.isBetterThan(bestGame) {
            bestGame = newRecord
        }
    }
}



