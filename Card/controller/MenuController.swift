import UIKit

class MenuController:UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newgame"{
            guard let destination = segue.destination as? MainController else{return}
            destination.modalPresentationStyle = .fullScreen
        }
    }
    
    private func openGame(level:Level){
        performSegue(withIdentifier: "newgame", sender: level)
    }
    
    @IBAction func bnEasy(_ sender: UIButton) {
        openGame(level: .Easy)
    }
    
    @IBAction func bnNormal(_ sender: UIButton) {
        openGame(level: .Normal)
    }
    
    @IBAction func bnHard(_ sender: UIButton) {
        openGame(level: .Hard)
    }
    
    @IBAction func bnSave(_ sender: UIButton) {
    }
    
    @IBAction func bnCenter(_ sender: UIButton) {
    }
    
}
