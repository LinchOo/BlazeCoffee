import Foundation

struct UserModel: Identifiable {
        var id: String = UUID().uuidString
        var name: String
        var bonuses: String
}
