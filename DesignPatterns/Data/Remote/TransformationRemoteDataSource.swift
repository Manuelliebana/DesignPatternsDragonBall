import Foundation

class TransformationRemoteDataSource {
    private let networkModel: NetworkModel
    
    init(networkModel: NetworkModel) {
        self.networkModel = networkModel
    }
    
    func fetchTransformations(heroId: String, token: String, completion: @escaping (Result<[Transformation], Error>) -> Void) {
        networkModel.fetchTransformations(heroId: heroId, token: token) { result in
            switch result {
            case .success(let transformationDTOs):
                let transformations = TransformationDTOToTransformationMapper.map(dtoList: transformationDTOs)
                completion(.success(transformations))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
} 
