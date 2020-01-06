import UIKit

class SaveList:UITableViewController{

    var save:Games!

    deinit {
        print("The class \(type(of: self)) was remove from memory")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.backgroundView = UIImageView(image: UIImage(named: "menuScreen"))
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return save == nil ? 0 : save.games.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "saverow", for: indexPath)
        let game = save.games[indexPath.row]
        cell.textLabel?.text = "Level: \(game.level.description) | Pairs opened: \(game.openPairs)"
        cell.backgroundColor = .clear
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loadgame"{
            guard let destination = segue.destination as? MainController else {return}
            let indexPath = sender as! IndexPath
            destination.modalPresentationStyle = .fullScreen
            destination.save = save
            destination.game = save.games[indexPath.row]
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "loadgame", sender: indexPath)
    }

    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            save.removeGame(position: indexPath.row)
            save.saveToLocal(games: save)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }

    private func showAlertToQuit(){
        let alert = UIAlertController(
                title: "Quit",
                message: "Quit to Menu",
                preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "OK", style: .default, handler:{action in
            self.dismiss(animated: true, completion: nil)
        })
        alert.addAction(actionOK)
        present(alert, animated: true, completion: nil)
    }

    @IBAction func onSwipeRight(_ sender: Any) {
        showAlertToQuit()
    }
    
}
