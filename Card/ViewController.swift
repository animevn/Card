import UIKit

class ViewController: UIViewController {
    
    let width = screenSize().x
    let height = screenSize().y
    let center = CGPoint(x: screenSize().centerX, y: screenSize().centerY)
    
    private var inset:CGFloat = 10
    private var space:CGFloat = 5
    private var level:Level
    private var cellsView:UICollectionView!
    private var game:Game!
    private var selectedCells = [IndexPath]()
    private var hiddenCells = [IndexPath]()
    private var guess = 0
    private var openPairs = 0
    private var swipe = UISwipeGestureRecognizer()
    var saveGame:SaveGame!
    var save:Save?
    
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
        let cardWidth = (width - inset*2 - (cardLevel().columns - 1)*space)/cardLevel().columns
        let cardHeight = cardWidth*1.452
        if (cardHeight*cardLevel().rows + inset*2 + (cardLevel().rows - 1)*space) <= height{
            return CGSize(width: cardWidth, height: cardHeight)
        }else{
            let cardHeight = (height - inset*2 - (cardLevel().rows - 1)*space)/cardLevel().rows
            let cardWidth = cardHeight/1.452
            return CGSize(width: cardWidth, height: cardHeight)
        }
    }
    
    private func viewSize()->CGSize{
        let (columns, rows) = cardLevel()
        let viewWidth = cardSize().width*columns + inset*2 + (columns - 1)*space
        let viewHeight = cardSize().height*rows + inset*2 + (rows - 1)*space
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
        cellsView.backgroundColor = .clear
        cellsView.isScrollEnabled = true
        cellsView.register(CellView.self, forCellWithReuseIdentifier: "cell")
        view.addSubview(cellsView)
    }
    
    private func createNewGame(){
        let fullRandom = Game.getFull().shuffle()
        let half = fullRandom.getNumOfCards(num: numOfCards()/2)
        game = Game(cards: half.cards + half.cards).shuffle()
    }
    
    private func createGame(){
        if let save = save{
            game = save.game
            guess = save.guess
            selectedCells = save.selectedCells
            hiddenCells = save.hiddenCells
            openPairs = save.openPairs
            
        }else{
            createNewGame()
        }
    }
    
    private func createAlertExit(){
        let alert = UIAlertController(
            title: "Exit game",
            message: "Do you want to quit?",
            preferredStyle: .alert)
        let actionOK = UIAlertAction(
            title: "OK",
            style: .default,
            handler: {action in
                self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
        })
        let actionCancel = UIAlertAction(
            title: "Cancel",
            style: .default,
            handler: nil)
        let actionSave = UIAlertAction(
            title: "Save",
            style: .default,
            handler: { action in
                let save = Save(level: self.level,
                                game: self.game,
                                selectedCells: self.selectedCells,
                                hiddenCells: self.hiddenCells,
                                guess: self.guess,
                                openPairs: self.openPairs)
                
                self.saveGame.addToSaveGame(save: save)
                self.saveGame.saveToLocal(saveGame: self.saveGame)
        })
        alert.addAction(actionOK)
        alert.addAction(actionCancel)
        alert.addAction(actionSave)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func handleSwipe(){
        createAlertExit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createView()
        createGame()
        swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipe.direction = .left
        cellsView.addGestureRecognizer(swipe)
    }
}

//handle cell click
extension ViewController:UICollectionViewDelegate{
    
    private func openCell(indexPath:IndexPath){
        let cell = cellsView.cellForItem(at: indexPath) as! CellView
        cell.open()
        selectedCells.append(indexPath)
    }
    
    private func closeCells(indexPaths:[IndexPath]){
        indexPaths.forEach{
            let cell = cellsView.cellForItem(at: $0) as! CellView
            cell.close()
        }
    }
    
    private func hideCells(indexPaths:[IndexPath]){
        indexPaths.forEach{
            let cell = cellsView.cellForItem(at: $0) as! CellView
            cell.hide()
        }
    }
    
    private func createAlert(){
        let alert = UIAlertController(
            title: "Great",
            message: "You won the game with just \(guess) guess",
            preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "OK", style: .default, handler:{action in
            self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
        })
        alert.addAction(actionOK)
        present(alert, animated: true, completion: nil)
    }
    
    private func showAlertIfNumOfPairsReachLimit(){
        if openPairs == numOfCards()/2{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.createAlert()
            })
        }
    }

    private func actionIfOpenCardsNotEqual(){
        if game.cards[selectedCells[0].row] != game.cards[selectedCells[1].row]{
            guess += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.closeCells(indexPaths: self.selectedCells)
                self.selectedCells = []
            })
        }
    }
    
    private func actionIfOpenCardsEqual(){
        if game.cards[selectedCells[0].row] == game.cards[selectedCells[1].row]{
            openPairs += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.hideCells(indexPaths: self.selectedCells)
                self.selectedCells.forEach{
                    self.hiddenCells.append($0)
                }
                self.selectedCells = []
            })
            showAlertIfNumOfPairsReachLimit()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        if selectedCells.count >= 2 || selectedCells.contains(indexPath){
            return
        }
        openCell(indexPath: indexPath)
        if selectedCells.count < 2 {return}
        actionIfOpenCardsEqual()
        actionIfOpenCardsNotEqual()
    }
}

//provide data for collectionview
extension ViewController:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return numOfCards()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                      for: indexPath) as! CellView
        
        cell.createCell(front: game.cards[indexPath.row].description, back: "back")
        if selectedCells.contains(indexPath){
            cell.open()
        }
        if hiddenCells.contains(indexPath){
            cell.hide()
        }
        return cell
    }
}
