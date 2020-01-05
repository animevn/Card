struct Card:Equatable, CustomStringConvertible, Codable{
    let rank:Rank
    let suit:Suit
    
    var description: String{
        return "\(rank.description)_of_\(suit.description)"
    }
}
