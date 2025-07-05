import Foundation

class HeroDetailViewModel {
    let hero: Hero
    let token: String
    
    var name: String { hero.name }
    var photo: String { hero.photo }
    var description: String { hero.description }
    var isFavorite: Bool { hero.favorite }
    var id: String { hero.id }
    // Puedes añadir más propiedades si el modelo Hero crece
    
    init(hero: Hero, token: String) {
        self.hero = hero
        self.token = token
    }
} 
