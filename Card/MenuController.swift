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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green

        createButton(
            title: "EASY",
            color: .blue,
            center: CGPoint(x: screenSize().x/2, y: screenSize().y * 1/4),
            action: #selector(onEasy))
        
        createButton(
            title: "NORMAL",
            color: .purple,
            center: CGPoint(x: screenSize().x/2, y: screenSize().y * 2/4),
            action: #selector(onNormal))
        
        createButton(
            title: "HARD",
            color: .black,
            center: CGPoint(x: screenSize().x/2, y: screenSize().y * 3/4),
            action: #selector(onHard))
    }
    
}
