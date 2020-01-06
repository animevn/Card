import Foundation
import UIKit

class MainController:UIViewController{
    
    var level:Level!
    var deck:Deck!
    
    private let inset:CGFloat = 10
    private let space:CGFloat = 5
    private var guess = 0
    private var openPairs = 0
    private var cellView:Cell!
    
    deinit {
        print("The class \(type(of: self)) was remove from memory")
    }
    
    private func cardsPerLevel()->(column:CGFloat, row:CGFloat){
        switch level! {
        case .Easy:
            return (3, 4)
        case .Normal:
            return (4, 6)
        case .Hard:
            return (6, 8)
        }
    }
    
    private func numbOfCards()->Int{
        return Int(cardsPerLevel().column * cardsPerLevel().row)
    }
    
    private func cardSize()->CGSize{
        let (column, row) = cardsPerLevel()
        var cardWidth = (screenSize().x  - inset*2 - (column - 1)*space)/column
        var cardHeight = cardWidth * 1.452
        if (cardHeight*row + inset*2 + (row - 1)*space) < screenSize().y{
            return CGSize(width: cardWidth, height: cardHeight)
        }else{
            var cardHeight = (screenSize().y  - inset*2 - (row - 1)*space)/row
            var cardWidth = cardHeight/1.452
            return CGSize(width: cardWidth, height: cardHeight)
        }
    }
    
    private func viewSize()->CGSize{
        let (column, row) = cardsPerLevel()
        let width = cardSize().width*column + inset*2 + (column - 1)*space
        let height = cardSize().height*row + inset*2 + (row - 1)*space
        return CGSize(width: width, height: height)
    }
    
    
    
}
