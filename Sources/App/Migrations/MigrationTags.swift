import Fluent

struct MigrateTags: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Tag.schema)
            .id()
            .field("title", .string, .required)
            .field("tag_info_color", .string, .required)
            .field("tag_info_size", .int, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Tag.schema).delete()
    }
}
