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

struct Card:Equatable, CustomStringConvertible{
    
    let rank:Rank
    let suit:Suit
    
    var description: String{
        return "\(rank)_of_\(suit)"
    }
}

struct Game{
    
    var cards = [Card]()
    
    static func getFull()->Game{
        var list = [Card]()
        for rank in Rank.all{
            for suit in Suit.all{
                list.append(Card(rank: rank, suit: suit))
            }
        }
        return Game(cards: list)
    }
    
    func shuffle()->Game{
        var list = cards
        for i in 0..<cards.count - 1{
            let j = Int(arc4random_uniform(UInt32(cards.count - i))) + i
            if j != i{
                list.swapAt(i, j)
            }
        }
        return Game(cards: list)
    }
    
    func getNumOfCards(num: Int)->Game{
        return Game(cards: Array(cards[0..<num]))
    }
    
}

