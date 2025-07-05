import Foundation
@testable import DesignPatterns

class HeroRemoteDataSourceMock: HeroRemoteDataSource {
    var resultToReturn: Result<[Hero], Error> = .success([])
    var fetchHeroesCalled = false
    
    override func fetchHeroes(token: String, filterName: String?, completion: @escaping (Result<[Hero], Error>) -> Void) {
        fetchHeroesCalled = true
        completion(resultToReturn)
    }
} 
