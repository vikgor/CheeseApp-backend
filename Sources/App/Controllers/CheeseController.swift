import Fluent
import Vapor

struct CheeseController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let cheesesRoutes = routes.grouped("api","cheeses")
        cheesesRoutes.get(use: getAllHandler)
        cheesesRoutes.get(":cheeseID", use: getHandler)
        cheesesRoutes.get("random", use: getRandomHandler)
        cheesesRoutes.post(use: createHandler)
        cheesesRoutes.put(":cheeseID", use: updateHandler)
        cheesesRoutes.group(":cheeseID") { cheese in
            cheese.delete(use: deleteHandler)
        }
    }

    func getAllHandler(req: Request) async throws -> [Cheese] {
        try await Cheese.query(on: req.db).all()
    }

    func getHandler(req: Request) async throws -> Cheese {
        guard let cheese = try await Cheese.find(req.parameters.get("cheeseID"), on: req.db) else {
            throw Abort(.notFound)
        }
        return cheese
    }

    func getRandomHandler(req: Request) async throws -> Cheese  {
        guard let cheese = try await Cheese.query(on: req.db).all().randomElement() else {
            throw Abort(.notFound)
        }
        return cheese
    }

    func createHandler(req: Request) async throws -> Cheese {
        let cheese = try req.content.decode(Cheese.self)
        try await cheese.save(on: req.db)
        return cheese
    }

    // TODO: - Update handler to async/await
    func updateHandler(_ req: Request) throws -> EventLoopFuture<Cheese> {
        let updatedCheese = try req.content.decode(CreateCheeseData.self)
        return Cheese.find(req.parameters.get("cheeseID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { cheese in
                cheese.name = updatedCheese.name
                cheese.country = updatedCheese.country
                cheese.type = updatedCheese.type
                cheese.animal = updatedCheese.animal
                return cheese.save(on: req.db).map { cheese }
            }
    }


    func deleteHandler(req: Request) async throws -> HTTPStatus {
        guard let cheese = try await Cheese.find(req.parameters.get("cheeseID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await cheese.delete(on: req.db)
        return .ok
    }
}

struct CreateCheeseData: Content {
    let name: String
    let country: String
    let type: String
    let animal: String
}
