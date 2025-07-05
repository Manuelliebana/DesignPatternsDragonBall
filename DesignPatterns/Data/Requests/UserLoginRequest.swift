import Foundation

struct UserLoginRequest: HTTPRequest {
    typealias Response = String
    
    let method: HTTPMethod = .post
    let endpoint: String = "/api/auth/login"
    let headers: [String: String]
    let payload: Encodable? = nil
    
    init(user: String, pass: String) {
        let credentials = "\(user):\(pass)"
        if let data = credentials.data(using: .utf8) {
            let base64 = data.base64EncodedString()
            headers = ["Authorization": "Basic \(base64)"]
        } else {
            headers = [:]
        }
    }
} 
