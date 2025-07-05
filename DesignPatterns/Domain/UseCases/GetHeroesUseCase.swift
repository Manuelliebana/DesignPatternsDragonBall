import Foundation

class GetHeroesUseCase {
    private let dataSource: HeroRemoteDataSource
    
    init(dataSource: HeroRemoteDataSource) {
        self.dataSource = dataSource
    }
    
    func execute(token: String, filterName: String? = nil, completion: @escaping (Result<[Hero], Error>) -> Void) {
        dataSource.fetchHeroes(token: token, filterName: filterName, completion: completion)
    }
} 