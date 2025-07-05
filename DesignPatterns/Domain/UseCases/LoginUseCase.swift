import Foundation

class LoginUseCase {
    private let networkModel: NetworkModel
    
    init(networkModel: NetworkModel) {
        self.networkModel = networkModel
    }
    
    func execute(username: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        let request = UserLoginRequest(user: username, pass: password)
        networkModel.send(request) { result in
            switch result {
            case .success(let token):
                completion(.success(token))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
} 
