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
    
    
    
    
}
