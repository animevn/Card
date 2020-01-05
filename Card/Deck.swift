import Foundation

struct Deck:Codable{
    var cards = [Card]()
    
    static func full()->Deck{
        var list = [Card]()
        for suit in Suit.all {
            for rank in Rank.all {
                list.append(Card(rank: rank, suit: suit))
            }
        }
        return Deck(cards: list)
    }
    
    //shuffle algrorithm Fisher - Yates
    func shuffle()->Deck{
        var list = cards
        for i in 0..<cards.count - 1{
            let j = Int(arc4random_uniform(UInt32(cards.count - i))) + i
            if j != i{
                list.swapAt(i, j)
            }
        }
        return Deck(cards: list)
    }
    
    //get first num of cards in deck
    func getDeckOfNum(num:Int)->Deck{
        return Deck(cards: Array(cards[0..<num]))
    }
    
}
