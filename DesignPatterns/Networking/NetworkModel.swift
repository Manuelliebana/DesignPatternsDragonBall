import Foundation

class NetworkModel {
    private let client: APIClient
    private let baseURL = "https://dragonball.keepcoding.education"
    
    init(client: APIClient) {
        self.client = client
    }
    
    func send<T: HTTPRequest>(_ request: T, completion: @escaping (Result<T.Response, Error>) -> Void) {
        // Construir el URLRequest
        let fullEndpoint: String
        if request.endpoint.hasPrefix("http") {
            fullEndpoint = request.endpoint
        } else {
            fullEndpoint = baseURL + request.endpoint
        }
        guard let url = URL(string: fullEndpoint) else {
            completion(.failure(NSError(domain: "MalformedURL", code: -1)))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        for (key, value) in request.headers {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        if let payload = request.payload {
            do {
                urlRequest.httpBody = try JSONEncoder().encode(AnyEncodable(payload))
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                completion(.failure(error))
                return
            }
        }
        client.request(urlRequest, using: T.Response.self) { result in
            switch result {
            case .success(let decoded):
                completion(.success(decoded))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchTransformations(heroId: String, token: String, completion: @escaping (Result<[TransformationDTO], Error>) -> Void) {
        let request = FetchTransformationsRequest(heroId: heroId, token: token)
        self.send(request) { result in
            switch result {
            case .success(let dtos):
                completion(.success(dtos))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
