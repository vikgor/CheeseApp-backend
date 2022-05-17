import Fluent

struct CreateCheese: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("cheeses")
            .id()
            .field("name", .string, .required)
            .field("country", .string, .required)
            .field("type", .string, .required)
            .field("animal", .string, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("cheeses").delete()
    }
}
