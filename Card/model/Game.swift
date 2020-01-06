import Foundation

struct Game:Codable{
    let level:Level
    let deck:Deck
    let selectedCards:[IndexPath]
    let hideCards:[IndexPath]
    let guess:Int
    let openPairs:Int
}


