import Foundation
import MapKit

struct Location: Identifiable, Equatable {
    
    let name: String
    let address: String
    let cityName: String
    let coodinates: CLLocationCoordinate2D
    let description: [String]
    let imagesNames: [String]
    
    var id: String {
        name + cityName + address
    }
    // Equatable
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}

class LocationsDataService {
    static let locations: [Location] = [
    Location(name: "Blaze Cafe 1",address: "Kashtanova street 4", cityName: "Kyiv",
             coodinates: CLLocationCoordinate2DMake(50.50135, 30.58760),
             description: ["Very cozy. Elegance in simplicity. Quality service. Apple pie is a special kind of art. Cocoa is what cocoa should be.",
                          ],
             imagesNames: ["BlissCaffee_1_1",
                           "BlissCaffee_1_2"]),
    Location(name: "Bleze Cafe 2",address: "Onore de Balzaka street 85", cityName: "Kyiv",
             coodinates: CLLocationCoordinate2D(latitude: 50.53016, longitude: 30.60751),
             description: ["I used to go here all the time, really tasty coffee, but the prices go up and up, but the quality remains the same. Looking for alternatives nearby."
                          ],
             imagesNames: ["BlissCaffee_2_1",
                           "BlissCaffee_2_2"]),
    Location(name: "Bleze Cafe 3",address: "Vasilkivska street 100/6", cityName: "Kyiv",
             coodinates: CLLocationCoordinate2D(latitude: 50.38349, longitude: 30.47877),
             description: ["Cozy, beautiful place. Always smiling and wishing you a good day. The coffee is top notch. I love this place!"],
             imagesNames: ["BlissCaffee_3_1",
                           "BlissCaffee_3_2"])
    ]
}
