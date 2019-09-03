import UIKit

class ViewController: UIViewController {
    
    private var inset:CGFloat = 10
    private var space:CGFloat = 5
    private var level:Level
    let width = screenSize().x
    let height = screenSize().y
    let center = CGPoint(x: screenSize().centerX, y: screenSize().centerY)
    var cellsView:UICollectionView!
    
    init(level:Level){
        self.level = level
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func cardLevel()->(columns:CGFloat, rows:CGFloat){
        switch level{
        case .Easy:
            return (3, 4)
        case .Normal:
            return (4, 6)
        case .Hard:
            return (6, 8)
        }
    }
    
    private func numOfCards()->Int{
        return Int(cardLevel().columns * cardLevel().rows)
    }
    
    private func cardSize()->CGSize{
        let cardWidth = (width - inset*2 - (cardLevel().columns + 1)*space)/cardLevel().columns
        let cardHeight = cardWidth*1.452
        if (cardHeight*cardLevel().rows + inset*2 + (cardLevel().rows + 1)*space) <= height{
            return CGSize(width: cardWidth, height: cardHeight)
        }else{
            let cardHeight = (height - inset*2 - (cardLevel().rows + 1)*space)/cardLevel().rows
            let cardWidth = cardHeight/1.452
            return CGSize(width: cardWidth, height: cardHeight)
        }
    }
    
    private func viewSize()->CGSize{
        let (columns, rows) = cardLevel()
        let viewWidth = cardSize().width*columns + inset*2 + (columns + 1)*space
        let viewHeight = cardSize().height*rows + inset*2 + (rows + 1)*space
        return CGSize(width: viewWidth, height: viewHeight)
    }
    
    private func layout()->UICollectionViewLayout{
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = cardSize()
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        layout.minimumLineSpacing = space
        layout.minimumInteritemSpacing = space
        return layout
    }
    
    private func createView(){
        view.backgroundColor = .green
        cellsView = UICollectionView(frame: CGRect(origin: .zero, size: viewSize()),
                                     collectionViewLayout: layout())
        cellsView.center = center
        cellsView.delegate = self
        cellsView.dataSource = self
        cellsView.backgroundColor = .lightGray
        cellsView.isScrollEnabled = true
        cellsView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.addSubview(cellsView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createView()
    }


}

extension ViewController:UICollectionViewDelegate{
    
}

extension ViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return numOfCards()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .orange
        return cell
    }
}
