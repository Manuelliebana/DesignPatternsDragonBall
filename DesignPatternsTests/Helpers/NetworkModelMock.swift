import Foundation
@testable import DesignPatterns

class NetworkModelMock: NetworkModel {
    var resultToReturn: Any? = nil
    var sendCalled = false
    
    override func send<T>(_ request: T, completion: @escaping (Result<T.Response, Error>) -> Void) where T : HTTPRequest {
        sendCalled = true
        if let response = resultToReturn as? Result<T.Response, Error> {
            completion(response)
        } else {
            completion(.failure(NSError(domain: "MockError", code: -1)))
        }
    }
} 
