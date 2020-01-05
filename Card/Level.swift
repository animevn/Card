import Foundation

enum Level:Int, CustomStringConvertible, Codable {
    case Easy = 1, Normal, Hard
    
    var description: String{
        switch self {
        case .Easy:
            return "Easy"
        case .Normal:
            return "Normal"
        case .Hard:
            return "Hard"
        }
    }
}
