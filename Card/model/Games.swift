import Foundation

class Games:Codable{
    var games = [Game]()

    deinit {
        print("The class \(type(of: self)) was remove from memory")
    }

    func addGame(game:Game?){
        guard let game = game else {return}
        games = games + [game]
    }

    func removeGame(position:Int){
        games.remove(at: position)
    }

    private func saveToData(games:Games)->Data{
        var data = Data()
        do{
            data = try JSONEncoder.encode(games)
        }catch let error{
            print(error)
        }
        return data
    }

    func saveToLocal(games:Games){
        let string = String(data: saveToData(games: games), encoding: .utf8)
        do{
            try string?.write(to: savefile, atomically: true, encoding: .utf8)
        }catch let error{
            print(error)
        }
    }

    private func loadDataFromLocal()->Data{
        var string:String = ""
        do{
            string = try String(contentsOf: savefile, encoding: .utf8)
        }catch let error{
            print(error)
        }
        return Data(string.utf8)
    }

    func loadSave()->Games{
        let data = loadDataFromLocal()
        var save = Games()
        do{
            save = try JSONDecoder().decode(Games.self, from: data)
        }catch let error{
            print(error)
        }
        return save
    }
}
