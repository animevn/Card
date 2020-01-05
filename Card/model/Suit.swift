import Foundation

enum Suit:Int, CustomStringConvertible, Codable{
    case Heart = 1, Diamond, Club, Spade
    var description: String{
        switch self {
        case .Heart:
            return "hearts"
        case .Diamond:
            return "diamonds"
        case .Club:
            return "clubs"
        case .Spade:
            return "spades"
        }
    }
    
    static var all = [Heart, Diamond, Club, Spade]
}
