import Fluent
import Vapor

final class Cheese: Model, Content {
    static let schema = "cheeses"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String?

    @Field(key: "country")
    var country: String?

    @Field(key: "type")
    var type: String?

    @Field(key: "animal")
    var animal: String?

    init() { }

    init(
        id: UUID? = nil,
        name: String? = nil,
        country: String? = nil,
        type: String? = nil,
        animal: String? = nil
    ) {
        self.id = id
        self.name = name
        self.country = country
        self.type = type
        self.animal = animal
    }
}
