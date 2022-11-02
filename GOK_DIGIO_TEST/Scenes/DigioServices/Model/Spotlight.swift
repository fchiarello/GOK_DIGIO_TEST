import Foundation

struct Spotlight: Codable {
    let name: String
    let bannerURL: String
    let description: String

    enum CodingKeys: String, CodingKey {
        case name, bannerURL, description
    }
}
