import Foundation
import UIKit

class MainController:UIViewController{
    
    var level:Level!
    var deck:Deck!
    
    deinit {
        print("The class \(type(of: self)) was remove from memory")
    }
    
    
}
