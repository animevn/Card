import UIKit

class CellView:UICollectionViewCell{
    
    private var image:UIImageView
    private var front:String!
    private var back:String!
    
    override init(frame: CGRect) {
        image = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        super.init(frame: frame)
        contentView.addSubview(image)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createCell(front:String, back:String){
        self.front = front
        self.back = back
        image.image = UIImage(named: back)
    }
    
    func open(){
        UIImageView.transition(
            with: image,
            duration: 0.5,
            options: .transitionFlipFromRight,
            animations: {self.image.image = UIImage(named: self.front)},
            completion: nil)
    }
    
    func close(){
        UIImageView.transition(
            with: image,
            duration: 0.5,
            options: .transitionFlipFromLeft,
            animations: {self.image.image = UIImage(named: self.back)},
            completion: nil)
    }
    
    func hide(){
        UICollectionViewCell.animate(
            withDuration: 0.5,
            animations: {self.image.alpha = 0},
            completion: {self.isHidden = $0})
    }
}
