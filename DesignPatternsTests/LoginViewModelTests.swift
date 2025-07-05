import XCTest
@testable import DesignPatterns

final class LoginViewModelTests: XCTestCase {
    class LoginUseCaseMock: LoginUseCase {
        var resultToReturn: Result<String, Error> = .success("token")
        var executeCalled = false
        override func execute(username: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
            executeCalled = true
            completion(resultToReturn)
        }
    }
    
    func test_login_successCallsCompletionWithToken() {
        // Given
        let useCase = LoginUseCaseMock(networkModel: NetworkModel(client: APIClient()))
        useCase.resultToReturn = .success("token123")
        let viewModel = LoginViewModel(loginUseCase: useCase)
        let expectation = self.expectation(description: "Success")
        // When
        viewModel.login(username: "user", password: "pass") { success, token in
            XCTAssertTrue(success)
            XCTAssertEqual(token, "token123")
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(useCase.executeCalled)
    }
    
    func test_login_failureCallsCompletionWithNil() {
        // Given
        let useCase = LoginUseCaseMock(networkModel: NetworkModel(client: APIClient()))
        useCase.resultToReturn = .failure(NSError(domain: "Test", code: 1))
        let viewModel = LoginViewModel(loginUseCase: useCase)
        let expectation = self.expectation(description: "Failure")
        // When
        viewModel.login(username: "user", password: "pass") { success, token in
            XCTAssertFalse(success)
            XCTAssertNil(token)
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(useCase.executeCalled)
    }
} 
