import Foundation

class GetTransformationsUseCase {
    private let dataSource: TransformationRemoteDataSource
    
    init(dataSource: TransformationRemoteDataSource) {
        self.dataSource = dataSource
    }
    
    func execute(heroId: String, token: String, completion: @escaping (Result<[Transformation], Error>) -> Void) {
        dataSource.fetchTransformations(heroId: heroId, token: token, completion: completion)
    }
} 