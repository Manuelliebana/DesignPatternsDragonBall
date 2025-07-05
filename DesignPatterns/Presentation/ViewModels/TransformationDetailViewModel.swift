import Foundation

class TransformationDetailViewModel {
    let transformation: Transformation
    
    var name: String { transformation.name }
    var description: String { transformation.description }
    var photo: String { transformation.photo }
    var id: String { transformation.id }
    
    init(transformation: Transformation) {
        self.transformation = transformation
    }
} 
