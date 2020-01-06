import UIKit

class MenuController:UIViewController{

    private var save = Games()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        save = save.loadSave()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newgame"{
            guard let destination = segue.destination as? MainController else{return}
            destination.modalPresentationStyle = .fullScreen
            destination.level = sender as? Level
            destination.save = save
            destination.game = nil
        }

        if segue.identifier == "savegame"{
            guard let destination = segue.destination as? SaveList else {return}
            destination.modalPresentationStyle = .fullScreen
            destination.save = save
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
        performSegue(withIdentifier: "savegame", sender: sender)
    }
    
    @IBAction func bnCenter(_ sender: UIButton) {
    }
    
}
