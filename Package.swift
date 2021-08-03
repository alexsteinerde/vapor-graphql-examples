// swift-tools-version:5.4
import PackageDescription

let package = Package(
    name: "GraphQL-Todo",
    platforms: [.macOS(.v10_15)],
    products: [
        .library(name: "GraphQL-Todo", targets: ["App"]),
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),

        // 🔵 Swift ORM (queries, models, relations, etc) built on SQLite 3.
        .package(url: "https://github.com/vapor/fluent.git", from: "4.0.0"),
        .package(url: "https://github.com/vapor/fluent-sqlite-driver.git", from: "4.0.0"),

        // 🌐 GraphQL
        .package(name: "GraphQLKit", url: "https://github.com/alexsteinerde/graphql-kit.git", from: "2.3.0"), // Vapor Utilities
        .package(name: "GraphiQLVapor",  url: "https://github.com/alexsteinerde/graphiql-vapor.git", from: "2.0.0"), // Web Query Page
    ],
    targets: [
        .target(name: "App", dependencies: [
            .product(name: "Fluent", package: "fluent"),
            .product(name: "FluentSQLiteDriver", package: "fluent-sqlite-driver"),
            .product(name: "Vapor", package: "vapor"),
            .product(name: "GraphQLKit", package: "GraphQLKit"),
            .product(name: "GraphiQLVapor", package: "GraphiQLVapor"),
        ]),
        .executableTarget(name: "Run", dependencies: [.target(name: "App")]),
        .testTarget(name: "AppTests", dependencies: [.target(name: "App")])
    ]
)
