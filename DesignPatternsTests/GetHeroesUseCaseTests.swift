import XCTest
@testable import DesignPatterns

final class GetHeroesUseCaseTests: XCTestCase {
    func test_execute_returnsHeroesOnSuccess() {
        // Given
        let mockDataSource = HeroRemoteDataSourceMock(networkModel: NetworkModel(client: APIClient()))
        let expectedHero = Hero(id: "1", name: "TestHero", favorite: false, photo: "url", description: "desc")
        mockDataSource.resultToReturn = .success([expectedHero])
        let useCase = GetHeroesUseCase(dataSource: mockDataSource)
        let expectation = self.expectation(description: "Success")
        
        // When
        useCase.execute(token: "token") { result in
            if case .success(let heroes) = result {
                XCTAssertEqual(heroes, [expectedHero])
                expectation.fulfill()
            }
        }
        // Then
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(mockDataSource.fetchHeroesCalled)
    }
    
    func test_execute_returnsErrorOnFailure() {
        // Given
        let mockDataSource = HeroRemoteDataSourceMock(networkModel: NetworkModel(client: APIClient()))
        mockDataSource.resultToReturn = .failure(NSError(domain: "Test", code: 1))
        let useCase = GetHeroesUseCase(dataSource: mockDataSource)
        let expectation = self.expectation(description: "Failure")
        
        // When
        useCase.execute(token: "token") { result in
            if case .failure = result {
                expectation.fulfill()
            }
        }
        // Then
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(mockDataSource.fetchHeroesCalled)
    }
} 
