import Foundation
import UIKit

class HeroListViewModel {
    private(set) var heroes: [Hero] = []
    let token: String
    private let getHeroesUseCase: GetHeroesUseCase
    
    var onHeroesUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    
    init(token: String, getHeroesUseCase: GetHeroesUseCase? = nil) {
        self.token = token
        if let injected = getHeroesUseCase {
            self.getHeroesUseCase = injected
        } else {
            let networkModel = NetworkModel(client: APIClient())
            let dataSource = HeroRemoteDataSource(networkModel: networkModel)
            self.getHeroesUseCase = GetHeroesUseCase(dataSource: dataSource)
        }
    }
    
    func loadHeroes() {
        getHeroesUseCase.execute(token: token) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let heroes):
                    self?.heroes = heroes
                    self?.onHeroesUpdated?()
                case .failure(let error):
                    self?.onError?("Error al cargar héroes: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func numberOfHeroes() -> Int {
        return heroes.count
    }
    
    func hero(at index: Int) -> Hero {
        return heroes[index]
    }
} 
