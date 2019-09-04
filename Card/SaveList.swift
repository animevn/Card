import UIKit

class SaveList:UITableViewController{
    
    var saveGame:SaveGame!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return saveGame.saves.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let level = saveGame.saves[indexPath.row].level.description
        let guess = saveGame.saves[indexPath.row].guess
        let openPairs = saveGame.saves[indexPath.row].openPairs
        cell.textLabel?.text = "Level: \(level) - Guess: \(guess) - Open: \(openPairs*2)"
        cell.textLabel?.font = .systemFont(ofSize: 15)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = ViewController(level:saveGame.saves[indexPath.row].level)
        viewController.modalTransitionStyle = .flipHorizontal
        viewController.saveGame = saveGame
        viewController.save = saveGame.saves[indexPath.row]
        present(viewController, animated: true, completion: nil)
    }
}
