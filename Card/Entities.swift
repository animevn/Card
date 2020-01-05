import UIKit

enum Level:Int, CustomStringConvertible, Codable{
    
    case Easy = 0, Normal, Hard
    
    var description: String{
        switch self{
        case .Easy:
            return "Easy"
        case .Normal:
            return "Normal"
        case .Hard:
            return "Hard"
        }
    }
}

enum Rank:Int, CustomStringConvertible, Codable{
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

enum Suit:Int, CustomStringConvertible, Codable{
    case Heart = 0, Diamond, Club, Spade
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

struct Card:Equatable, CustomStringConvertible, Codable{
    
    let rank:Rank
    let suit:Suit
    
    var description: String{
        return "\(rank)_of_\(suit)"
    }
}

struct Game:Codable{
    
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

func screenSize()->(x:CGFloat, y:CGFloat, centerX:CGFloat, centerY:CGFloat){
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    let center = CGPoint(x: width/2, y: height/2)
    
    switch (width, height) {
        
    //11 ProMax 3x, XSMax 3x, 11 2x, XR 2x,  - portrait : status bar = 44, bottom bar = 34
    case (414, 896):
        //        print("11 ProMax, 11, XSMax, XR")
        return (414, 896 - 44 - 34, center.x, center.y + 22 - 17)
        
    //X, XS, 11 Pro all 3x portrait : status bar = 44, bottom bar = 34
    case (375, 812):
        //        print("11Pro, X, XS")
        return (375, 812 - 44, center.x, center.y + 22 - 17)
        
    //6 Plus, 6S Plus, 7 Plus, 8 Plus all 3x portrait : status bar = 18
    case (414, 736):
        //        print("6 Plus, 6s Plus, 7 Plus, 8 Plus")
        return (414, 736 - 18, center.x, center.y + 9)
        
    //6, 6S, 7, 8 all 2x portrait : status bar = 20
    case (375, 667):
        //        print("6, 6s, 7, 8")
        return (375, 667 - 20, center.x, center.y + 10)
        
    //SE 2x portrait : status bar = 20
    case (320, 568):
        //      print("SE")
        return (320, 568 - 20, center.x, center.y + 10)
        
    //default value which never used
    default:
        //      print("default")
        return (width, height - 50, center.x, center.y + 25)
    }
}
