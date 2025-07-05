import Foundation

class LoginViewModel {
    private let loginUseCase: LoginUseCase
    
    init(loginUseCase: LoginUseCase? = nil) {
        if let injected = loginUseCase {
            self.loginUseCase = injected
        } else {
            let networkModel = NetworkModel(client: APIClient())
            self.loginUseCase = LoginUseCase(networkModel: networkModel)
        }
    }
    
    func login(username: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        loginUseCase.execute(username: username, password: password) { result in
            switch result {
            case .success(let token):
                completion(true, token)
            case .failure:
                completion(false, nil)
            }
        }
    }
} 
