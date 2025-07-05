import Foundation

struct HeroDTOToHeroMapper {
    static func map(dto: HeroDTO) -> Hero {
        return Hero(
            id: dto.id,
            name: dto.name,
            favorite: dto.favorite,
            photo: dto.photo,
            description: dto.description
        )
    }
    
    static func map(dtoList: [HeroDTO]) -> [Hero] {
        return dtoList.map { map(dto: $0) }
    }
}
