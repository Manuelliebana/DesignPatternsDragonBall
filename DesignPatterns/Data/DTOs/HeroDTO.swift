import Foundation

struct HeroDTO: Decodable {
    let id: String
    let name: String
    let favorite: Bool
    let photo: String
    let description: String
}
