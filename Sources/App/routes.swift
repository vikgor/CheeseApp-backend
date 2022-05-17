import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "Welcome to CheeseApp - the cheesiest database of cheese"
    }

    app.get("cheese") { req -> String in
        return "I love cheese!"
    }

    try app.register(collection: CheeseController())
}
