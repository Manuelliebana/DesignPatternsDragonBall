import Foundation

protocol HTTPRequest {
    associatedtype Response: Decodable
    var method: HTTPMethod { get }
    var endpoint: String { get }
    var headers: [String: String] { get }
    var payload: Encodable? { get }
}

extension HTTPRequest {
    var headers: [String: String] { [:] }
    var payload: Encodable? { nil }
} 