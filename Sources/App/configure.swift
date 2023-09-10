import NIOSSL
import Fluent
import FluentPostgresDriver
import Vapor
import Liquid
import LiquidLocalDriver


// configures your application
public func configure(_ app: Application) async throws {
    app.fileStorages.use(
        .local(
            publicUrl: "http://localhost:8080",
            publicPath: app.directory.publicDirectory,
            workDirectory: "assets"
        ),
        as: .local
    )
    app.routes.defaultMaxBodySize = "10mb"
    
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
    
    
    // MARK: - Sessions
    app.sessions.use(.fluent)
    app.migrations.add(SessionRecord.migration)
    
    
    // MARK: - Middlewares
    // serve files from /Public folder
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.middleware.use(app.sessions.middleware)

    //MARK: - register routes
    let modules: [ModuleInterface] = [
        WebModule(),
        UserModule(),
        BlogModule()
    ]
    
    for module in modules {
        try module.boot(app)
    }
    
    try await app.autoMigrate()
}
