import NIOSSL
import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) async throws {

    
    let sslContext = try NIOSSLContext(configuration: .clientDefault)
    let connectionConfig = PostgresConnection.Configuration.TLS.prefer(sslContext)
    app.databases.use(.postgres(configuration: SQLPostgresConfiguration(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? 5435,//SQLPostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "apiarium_username",
        password: Environment.get("DATABASE_PASSWORD") ?? "apiarium_password",
        database: Environment.get("DATABASE_NAME") ?? "apiarium_database",
        tls: connectionConfig
    ), sqlLogLevel: .debug), as: .psql)
    
    // MARK: - Middlewares
    // serve files from /Public folder
     app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    //MARK: - register routes
    let modules: [ModuleInterface] = [
        WebModule(),
        BlogModule()
    ]
    
    for module in modules {
        try module.boot(app)
    }
    
    try await app.autoMigrate()
}
