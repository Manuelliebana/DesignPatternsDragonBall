import Foundation

class HeroRemoteDataSource {
    private let networkModel: NetworkModel
    
    init(networkModel: NetworkModel) {
        self.networkModel = networkModel
    }
    
    func fetchHeroes(token: String, filterName: String? = nil, completion: @escaping (Result<[Hero], Error>) -> Void) {
        let request = FetchHeroesRequest(token: token, filterName: filterName)
        networkModel.send(request) { result in
            switch result {
            case .success(let heroDTOs):
                let heroes = HeroDTOToHeroMapper.map(dtoList: heroDTOs)
                completion(.success(heroes))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
} 
