import Foundation
import UIKit

class Cell: UICollectionViewCell {
    
    var imageView:UIImageView
    var back:String!
    var front:String!
    
    override init(frame: CGRect) {
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("The class \(type(of: self)) was remove from memory")
    }
    
    func createCell(front:String, back:String){
        self.front = front
        self.back = back
        imageView.image = UIImage(named: back)
    }
    
    func open(){
        UICollectionViewCell.transition(
            with: imageView,
            duration: 1,
            options: .transitionFlipFromRight,
            animations: {self.imageView.image = UIImage(named: self.front)},
            completion: nil)
    }
    
    func close(){
        UICollectionViewCell.transition(
        with: imageView,
        duration: 1,
        options: .transitionFlipFromLeft,
        animations: {self.imageView.image = UIImage(named: self.back)},
        completion: nil)
    }
    
    func hide(){
        UICollectionViewCell.animate(
            withDuration: 1,
            animations: {self.imageView.alpha = 0},
            completion: {self.isHidden = $0})
    }
}
