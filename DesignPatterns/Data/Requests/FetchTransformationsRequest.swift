import Foundation

struct FetchTransformationsRequest: HTTPRequest {
    typealias Response = [TransformationDTO]
    
    let method: HTTPMethod = .post
    let endpoint: String = "/api/heros/tranformations"
    let payload: Encodable?
    let headers: [String: String]
    
    init(heroId: String, token: String) {
        headers = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"
        ]
        payload = HeroIdPayload(id: heroId)
    }
}

private struct HeroIdPayload: Codable {
    let id: String
} 
