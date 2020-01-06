import Foundation

struct Game:Equatable, Codable{
    let level:Level
    let deck:Deck
    let selectedCards:[IndexPath]
    let hideCards:[IndexPath]
    let guess:Int
    let openPairs:Int

    static func == (lhs: Game, rhs: Game) -> Bool {
        return lhs.level == rhs.level &&
                lhs.deck == rhs.deck &&
                lhs.selectedCards == rhs.selectedCards &&
                lhs.hideCards == rhs.hideCards &&
                lhs.guess == rhs.guess &&
                lhs.openPairs == rhs.openPairs
    }
}


