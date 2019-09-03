import Foundation

class SaveGame:Codable{
    
    private var level:Level
    private var game:Game
    private var selectedCells:[IndexPath]
    private var guess:Int
    private var openPairs:Int
    
    init(level:Level, game:Game, selectedCells:[IndexPath], guess:Int, openPairs:Int){
        self.level = level
        self.game = game
        self.selectedCells = selectedCells
        self.guess = guess
        self.openPairs = openPairs
    }
}
