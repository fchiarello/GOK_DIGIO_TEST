import Foundation

struct MainModel: Codable {
    let spotlight: [Spotlight]
    let products: [Product]
    let cash: Cash
}
