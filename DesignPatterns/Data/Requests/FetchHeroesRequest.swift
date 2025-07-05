import Foundation

struct FetchHeroesRequest: HTTPRequest {
    typealias Response = [HeroDTO]
    
    let method: HTTPMethod = .post
    let endpoint: String = "/api/heros/all"
    let payload: Encodable?
    let headers: [String: String]
    
    init(token: String, filterName: String? = nil) {
        headers = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"
        ]
        payload = HeroFilterPayload(name: filterName ?? "")
    }
}

private struct HeroFilterPayload: Codable {
    let name: String
} 
