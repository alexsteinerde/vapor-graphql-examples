import Fluent
import Vapor

/// A single entry of a Tag list.
final class Tag: Model {
    static let schema = "tags"

    /// The unique identifier for this `Tag`.
    @ID(key: .id)
    var id: UUID?

    /// A title describing what this `Tag` entails.
    @Field(key: "title")
    var title: String
    
    // Example of a siblings relation.
    @Siblings(through: TodoTag.self, from: \.$tag, to: \.$todo)
    public var todos: [Todo]
    
    @Group(key: "tag_info")
    public var tagInfo: TagInfo
    
    @Enum(key: "priority")
    public var priority: TagPriority
    
    init() { }

    /// Creates a new `Todo`.
    init(id: UUID? = nil, title: String) {
        self.id = id
        self.title = title
        self.tagInfo = .init()
        self.priority = .medium
    }
}

enum TagPriority: String, Codable, CaseIterable {
    case low
    case medium
    case high
}

final class TagInfo: Fields {
    init() {
        self.color = "red"
        self.size = 0
    }
    
    internal init(color: String, size: Int) {
        self.color = color
        self.size = size
    }
    
    @Field(key: "color")
    var color: String
    
    @Field(key: "size")
    var size: Int
}
