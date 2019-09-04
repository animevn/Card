import Foundation

class SaveGame:Codable{
    
    var level:Level
    var game:Game
    var selectedCells:[IndexPath]
    var hiddenCells:[IndexPath]
    var guess:Int
    var openPairs:Int
    
    init(level:Level, game:Game, selectedCells:[IndexPath], hiddenCells:[IndexPath],
         guess:Int, openPairs:Int){
        self.level = level
        self.game = game
        self.selectedCells = selectedCells
        self.hiddenCells = hiddenCells
        self.guess = guess
        self.openPairs = openPairs
    }
    
    private func saveToData(saveGame:SaveGame)->Data{
        var data = Data()
        do{
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            data = try encoder.encode(saveGame)
        }catch let error{
            print(error)
        }
        return data
    }
    
    func saveToLocal(saveGame:SaveGame){
        let string = String(data: saveToData(saveGame: saveGame), encoding: .utf8)
        do{
            try string?.write(to: saveFile, atomically: true, encoding: .utf8)
        }catch let error{
            print(error)
        }
    }
    
    private func loadData()->Data{
        var string = ""
        do{
            string = try String(contentsOf: saveFile, encoding: .utf8)
        }catch let error{
            print(error)
        }
        return Data(string.utf8)
    }
    
    func loadSaveFromLocal()->SaveGame{
        let data = loadData()
        var saveGame = SaveGame(
            level: .Easy,
            game: Game(),
            selectedCells: [],
            hiddenCells: [],
            guess: 0,
            openPairs: 0)
        do{
            saveGame = try JSONDecoder().decode(SaveGame.self, from: data)
        }catch let error{
            print(error)
        }
        return saveGame
    }
}


private let appSupportDirectory:URL = {
    let url = FileManager().urls(
        for: FileManager.SearchPathDirectory.applicationSupportDirectory,
        in: FileManager.SearchPathDomainMask.userDomainMask).first!
    
    if !FileManager().fileExists(atPath: url.path){
        do{
            try FileManager().createDirectory(at: url, withIntermediateDirectories: false)
        }catch let error{
            print(error)
        }
    }
    return url
}()


private let saveFile = appSupportDirectory.appendingPathComponent("saves")
