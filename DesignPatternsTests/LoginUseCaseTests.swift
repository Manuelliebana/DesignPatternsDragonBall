import XCTest
@testable import DesignPatterns

final class LoginUseCaseTests: XCTestCase {
    func test_execute_returnsTokenOnSuccess() {
        // Given
        let mockNetwork = NetworkModelMock(client: APIClient())
        let expectedToken = "token123"
        mockNetwork.resultToReturn = Result<String, Error>.success(expectedToken)
        let useCase = LoginUseCase(networkModel: mockNetwork)
        let expectation = self.expectation(description: "Success")
        // When
        useCase.execute(username: "user", password: "pass") { result in
            if case .success(let token) = result {
                XCTAssertEqual(token, expectedToken)
                expectation.fulfill()
            }
        }
        // Then
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(mockNetwork.sendCalled)
    }
    
    func test_execute_returnsErrorOnFailure() {
        // Given
        let mockNetwork = NetworkModelMock(client: APIClient())
        mockNetwork.resultToReturn = Result<String, Error>.failure(NSError(domain: "Test", code: 1))
        let useCase = LoginUseCase(networkModel: mockNetwork)
        let expectation = self.expectation(description: "Failure")
        // When
        useCase.execute(username: "user", password: "pass") { result in
            if case .failure = result {
                expectation.fulfill()
            }
        }
        // Then
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(mockNetwork.sendCalled)
    }
} 
