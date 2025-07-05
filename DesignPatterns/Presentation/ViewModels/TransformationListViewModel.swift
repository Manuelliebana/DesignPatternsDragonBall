import Foundation


class TransformationListViewModel {
    private let hero: Hero
    private(set) var transformations: [Transformation] = []
    private let getTransformationsUseCase: GetTransformationsUseCase
    private let token: String
    
    var onTransformationsUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    
    init(hero: Hero, token: String, getTransformationsUseCase: GetTransformationsUseCase? = nil) {
        self.hero = hero
        self.token = token
        if let injected = getTransformationsUseCase {
            self.getTransformationsUseCase = injected
        } else {
            let networkModel = NetworkModel(client: APIClient())
            let dataSource = TransformationRemoteDataSource(networkModel: networkModel)
            self.getTransformationsUseCase = GetTransformationsUseCase(dataSource: dataSource)
        }
    }
    
    func loadTransformations() {
        getTransformationsUseCase.execute(heroId: hero.id, token: token) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let transformations):
                    self?.transformations = transformations
                    self?.onTransformationsUpdated?()
                case .failure(let error):
                    self?.onError?("Error al cargar transformaciones: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func numberOfTransformations() -> Int {
        return transformations.count
    }
    
    func transformation(at index: Int) -> Transformation {
        return transformations[index]
    }
} 
