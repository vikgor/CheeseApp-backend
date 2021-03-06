import Fluent
import FluentPostgresDriver
import Vapor

public func configure(_ app: Application) throws {

    if let databaseURL = Environment.get("DATABASE_URL"),
       var postgresConfig = PostgresConfiguration(url: databaseURL) {
        postgresConfig.tlsConfiguration = .makeClientConfiguration()
        postgresConfig.tlsConfiguration?.certificateVerification = .none
        app.databases.use(.postgres(configuration: postgresConfig), as: .psql)
    } else {
        let databaseName: String
        let databasePort: Int
        if (app.environment == .testing ) {
            databaseName = "vapor-test"
            databasePort = 5433
        } else {
            databaseName = "vapor_database"
            databasePort = 5432
        }
        app.databases.use(.postgres(
            hostname: Environment.get("DATABASE_HOST") ?? "localhost",
            port: databasePort,
            username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
            password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
            database: Environment.get("DATABASE_NAME") ?? databaseName
        ), as: .psql)
    }

    app.migrations.add(CreateCheese())

    app.logger.logLevel = .debug

    try app.autoMigrate().wait()

    try routes(app)
}
