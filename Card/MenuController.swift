import UIKit

class MenuController:UIViewController{
    
    private func createButton(title:String, color:UIColor, center:CGPoint, action:Selector){
        
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: screenSize().x/2.5, height: screenSize().y/10)
        button.center = center
        button.setTitle(title, for: .normal)
        button.setBackgroundImage(UIImage(named: "bnNormal"), for: .normal)
        button.setBackgroundImage(UIImage(named: "bnHighlight"), for: .highlighted)
        button.setTitleColor(color, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.addTarget(self, action: action, for: .touchUpInside)
        view.addSubview(button)
    }
   
    private func playGame(level:Level){
        let viewController = ViewController(level: level)
        viewController.modalTransitionStyle = .flipHorizontal
        present(viewController, animated: true, completion: nil)
    }
    
    @objc private func onEasy(){
        playGame(level: .Easy)
    }
    
    @objc private func onNormal(){
        playGame(level: .Normal)
    }
    
    @objc private func onHard(){
        playGame(level: .Hard)
    }
    
    @objc private func onSave(){
        var saveGame = SaveGame(
            level: .Easy,
            game: Game(),
            selectedCells: [],
            hiddenCells:[],
            guess: 0,
            openPairs: 0)
        saveGame = saveGame.loadSaveFromLocal()
        let viewController = ViewController(level:saveGame.level)
        viewController.modalTransitionStyle = .flipHorizontal
        viewController.saveGame = saveGame
        present(viewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green

        createButton(
            title: "EASY",
            color: .blue,
            center: CGPoint(x: screenSize().x/2, y: screenSize().y * 1/5),
            action: #selector(onEasy))
        
        createButton(
            title: "NORMAL",
            color: .purple,
            center: CGPoint(x: screenSize().x/2, y: screenSize().y * 2/5),
            action: #selector(onNormal))
        
        createButton(
            title: "HARD",
            color: .black,
            center: CGPoint(x: screenSize().x/2, y: screenSize().y * 3/5),
            action: #selector(onHard))
        
        createButton(
            title: "Save Games",
            color: .black,
            center: CGPoint(x: screenSize().x/2, y: screenSize().y * 4/5),
            action: #selector(onSave))
        
    }
    
}
