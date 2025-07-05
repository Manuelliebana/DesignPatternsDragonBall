import Foundation

struct TransformationDTOToTransformationMapper {
    static func map(dto: TransformationDTO) -> Transformation {
        return Transformation(
            id: dto.id,
            name: dto.name,
            photo: dto.photo,
            description: dto.description
        )
    }
    
    static func map(dtoList: [TransformationDTO]) -> [Transformation] {
        return dtoList.map { map(dto: $0) }
    }
}
