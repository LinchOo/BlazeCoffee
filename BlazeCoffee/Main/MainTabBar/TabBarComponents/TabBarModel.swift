import Foundation

enum TabBarModel: String, CaseIterable {
case home = "Home"
case profile = "Account"
case cafe = "Cafe"
    
    var Images: String {
        switch self {
        case .home:
            return "home"
        case .profile:
            return "barcode"
        case .cafe:
            return "cafe"
        }
    }
    var index: Int {
        return TabBarModel.allCases.firstIndex(of: self) ?? 0
    }
}
