import Foundation

struct Save:Codable{
    let level:Level
    let game:Game
    let selectedCells:[IndexPath]
    let hiddenCells:[IndexPath]
    let guess:Int
    let openPairs:Int
}

class SaveGame:Codable{
    
    var saves = [Save]()
    
    func addToSaveGame(save:Save){
        saves = saves + [save]
    }

    func removeFromSaveGame(position:Int){
        saves.remove(at: position)
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
        var saveGame = SaveGame()
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
