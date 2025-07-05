import Foundation
@testable import DesignPatterns

class TransformationRemoteDataSourceMock: TransformationRemoteDataSource {
    var resultToReturn: Result<[Transformation], Error> = .success([])
    var fetchTransformationsCalled = false
    
    override func fetchTransformations(heroId: String, token: String, completion: @escaping (Result<[Transformation], Error>) -> Void) {
        fetchTransformationsCalled = true
        completion(resultToReturn)
    }
} 
