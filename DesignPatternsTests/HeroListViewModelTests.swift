import XCTest
@testable import DesignPatterns

final class HeroListViewModelTests: XCTestCase {
    class GetHeroesUseCaseMock: GetHeroesUseCase {
        var resultToReturn: Result<[Hero], Error> = .success([])
        var executeCalled = false
        override func execute(token: String, filterName: String? = nil, completion: @escaping (Result<[Hero], Error>) -> Void) {
            executeCalled = true
            completion(resultToReturn)
        }
    }
    
    func test_loadHeroes_successUpdatesHeroes() {
        // Given
        let useCase = GetHeroesUseCaseMock(dataSource: HeroRemoteDataSource(networkModel: NetworkModel(client: APIClient())))
        let expected = Hero(id: "1", name: "Test", favorite: false, photo: "url", description: "desc")
        useCase.resultToReturn = .success([expected])
        let viewModel = HeroListViewModel(token: "token", getHeroesUseCase: useCase)
        viewModel.onHeroesUpdated = {
            XCTAssertEqual(viewModel.heroes, [expected])
        }
        // When
        viewModel.loadHeroes()
        // Then
        XCTAssertTrue(useCase.executeCalled)
    }
    
    func test_loadHeroes_failureCallsOnError() {
        // Given
        let useCase = GetHeroesUseCaseMock(dataSource: HeroRemoteDataSource(networkModel: NetworkModel(client: APIClient())))
        useCase.resultToReturn = .failure(NSError(domain: "Test", code: 1))
        let viewModel = HeroListViewModel(token: "token", getHeroesUseCase: useCase)
        let expectation = self.expectation(description: "Error")
        viewModel.onError = { message in
            XCTAssertTrue(message.contains("Error"))
            expectation.fulfill()
        }
        // When
        viewModel.loadHeroes()
        // Then
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(useCase.executeCalled)
    }
} 
