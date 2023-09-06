import Foundation

struct NewsModel: Identifiable {
        var id: String = UUID().uuidString
        var imgName: String
        var description: String
        var number: String
}

class NewsViewModel: ObservableObject {

    @Published var services: [NewsModel]
    init() {
        let services = NewsDataService.servicesDB
        self.services = services
    }
}
class NewsDataService {
    static let shared = NewsDataService()

    static let servicesDB: [NewsModel] = [
        NewsModel(imgName: "logo2", description: "With the application permanent discount 5%", number: "1"),
        NewsModel(imgName: "logo2", description: "Every 10 cups of coffee for free", number: "2")]
}
