import Foundation

struct Cash: Codable {
    let title: String
    let bannerURL: String
    let description: String

    enum CodingKeys: String, CodingKey {
        case title, bannerURL, description
    }
}
