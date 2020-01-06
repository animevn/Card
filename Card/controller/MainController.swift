import Foundation
import UIKit

class MainController:UIViewController{
    
    var level:Level!
    var deck:Deck!
    
    private let inset:CGFloat = 10
    private let space:CGFloat = 5
    private let width = screenSize().x - 1
    private let height = screenSize().y - 1
    private let center = CGPoint(x: screenSize().centerX, y: screenSize().centerY)
    
    private var guess = 0
    private var openPairs = 0
    private var selectedCards = [IndexPath]()
    private var cellView:UICollectionView!
    
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
    
    private func numOfCards()->Int{
        return Int(cardsPerLevel().column * cardsPerLevel().row)
    }
    
    private func cardSize()->CGSize{
        let (column, row) = cardsPerLevel()
        let cardWidth = (screenSize().x  - inset*2 - (column - 1)*space)/column
        let cardHeight = cardWidth * 1.452
        if (cardHeight*row + inset*2 + (row - 1)*space) < screenSize().y{
            return CGSize(width: cardWidth, height: cardHeight)
        }else{
            let cardHeight = (screenSize().y  - inset*2 - (row - 1)*space)/row
            let cardWidth = cardHeight/1.452
            return CGSize(width: cardWidth, height: cardHeight)
        }
    }
    
    private func viewSize()->CGSize{
        let (column, row) = cardsPerLevel()
        let width = cardSize().width*column + inset*2 + (column - 1)*space
        let height = cardSize().height*row + inset*2 + (row - 1)*space
        return CGSize(width: width, height: height)
    }
    
    private func layout()->UICollectionViewLayout{
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = cardSize()
        layout.minimumLineSpacing = space
        layout.minimumInteritemSpacing = space
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        return layout
    }
    
    private func createCellView(){
        cellView = UICollectionView(
            frame: CGRect(origin: .zero, size: viewSize()),
            collectionViewLayout: layout())
        cellView.center = CGPoint(x: screenSize().centerX, y: screenSize().centerY)
        cellView.delegate = self
        cellView.dataSource = self
        cellView.register(Cell.self, forCellWithReuseIdentifier: "cell")
        cellView.isScrollEnabled = false
        cellView.backgroundColor = .clear
        view.addSubview(cellView)
    }
    
    private func createCard(){
        let randomFull = Deck.full().shuffle()
        let half = randomFull.getDeckOfNum(num: numOfCards()/2)
        deck = Deck(cards: half.cards + half.cards).shuffle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        createCard()
        createCellView()
    }
}

extension MainController:UICollectionViewDataSource{
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int)->Int{
        return numOfCards()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                      for: indexPath) as! Cell
        let card = deck.cards[indexPath.row]
        cell.createCell(front: card.description, back: "back")
        return cell
    }
}

extension MainController:UICollectionViewDelegate{

    private func openCell(indexPath:IndexPath){
        let cell = cellView.cellForItem(at: indexPath) as! Cell
        cell.open()
    }

    private func closeCells(indexPaths:[IndexPath]){
        for indexPath in indexPaths{
            let cell = cellView.cellForItem(at: indexPath) as! Cell
            cell.close()
        }
    }

    private func hideCells(indexPaths:[IndexPath]){
        for indexPath in indexPaths{
            let cell = cellView.cellForItem(at: indexPath) as! Cell
            cell.hide()
        }
    }

    private func createAlertWhenAllCellOpened(){
        let alert = UIAlertController(
                title: "Great", 
                message: "You won the game in \(guess) guess", 
                preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "OK", style: .default, handler: {action in 
            self.dismiss(animated: true, completion: nil)
        })
        alert.addAction(actionOK)
        present(alert, animated: true, completion: nil)
    }

    private func showAlertWhenAllCellOpened(){
        if openPairs == numOfCards()/2{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.createAlertWhenAllCellOpened()
            })
        }
    }

    private func actionIfTwoCardsDifferent(){
        if deck.cards[selectedCards[0].row] != deck.cards[selectedCards[1].row]{
            guess += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.closeCells(indexPaths: self.selectedCards)
                self.selectedCards = []
            })
        }
    }

    private func actionIfTwoCardsSame(){
        if deck.cards[selectedCards[0].row] == deck.cards[selectedCards[1].row]{
            openPairs += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.hideCells(indexPaths: self.selectedCards)
                self.selectedCards = []
            })
        }
        showAlertWhenAllCellOpened()
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedCards.count > 1 || selectedCards.contains(indexPath){
            return
        }
        openCell(indexPath: indexPath)
        if selectedCards.count < 2{
            return
        }
        actionIfTwoCardsDifferent()
        actionIfTwoCardsSame()
    }
}















