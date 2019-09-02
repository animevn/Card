import Foundation

enum Rank:Int, CustomStringConvertible{
    case Ace = 1, Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten, Jack, Queen, King
    
    var description: String{
        switch self{
        case .Ace:
            return "ace"
        case .Jack:
            return "jack"
        case .Queen:
            return "queen"
        case .King:
            return "king"
        default:
            return String(self.rawValue)
            
        }
    }
    
    static var all = [Ace, Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten, Jack, Queen, King]
}

enum Suit:CustomStringConvertible {
    case Heart, Diamond, Club, Spade
    var description: String{
        switch self{
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

