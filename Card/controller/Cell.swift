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
    
    
    
}
