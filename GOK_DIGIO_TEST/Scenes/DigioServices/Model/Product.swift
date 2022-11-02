import Foundation

struct Product: Codable {
    let name: String
    let imageURL: String
    let description: String

    enum CodingKeys: String, CodingKey {
        case name, imageURL, description
    }
}
