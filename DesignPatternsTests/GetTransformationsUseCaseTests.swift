import XCTest
@testable import DesignPatterns

final class GetTransformationsUseCaseTests: XCTestCase {
    func test_execute_returnsTransformationsOnSuccess() {
        // Given
        let mockDataSource = TransformationRemoteDataSourceMock(networkModel: NetworkModel(client: APIClient()))
        let expected = Transformation(id: "1", name: "Super Saiyan", photo: "url", description: "desc")
        mockDataSource.resultToReturn = .success([expected])
        let useCase = GetTransformationsUseCase(dataSource: mockDataSource)
        let expectation = self.expectation(description: "Success")
        // When
        useCase.execute(heroId: "1", token: "token") { result in
            if case .success(let transformations) = result {
                XCTAssertEqual(transformations, [expected])
                expectation.fulfill()
            }
        }
        // Then
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(mockDataSource.fetchTransformationsCalled)
    }
    
    func test_execute_returnsErrorOnFailure() {
        // Given
        let mockDataSource = TransformationRemoteDataSourceMock(networkModel: NetworkModel(client: APIClient()))
        mockDataSource.resultToReturn = .failure(NSError(domain: "Test", code: 1))
        let useCase = GetTransformationsUseCase(dataSource: mockDataSource)
        let expectation = self.expectation(description: "Failure")
        // When
        useCase.execute(heroId: "1", token: "token") { result in
            if case .failure = result {
                expectation.fulfill()
            }
        }
        // Then
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(mockDataSource.fetchTransformationsCalled)
    }
} 
