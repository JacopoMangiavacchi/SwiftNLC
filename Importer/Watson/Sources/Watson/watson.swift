// To parse the JSON, add this file to your project and do:
//
//   let watsonConversationWorkspace = try WatsonConversationWorkspace(json)

import Foundation

struct WatsonConversationWorkspace: Codable {
    let name: String
    let intents: [Intent]
    let entities: [Entity]
    let language: String
    let metadata: WatsonConversationWorkspaceMetadata
    let description: String
    let dialogNodes: [DialogNode]
    let workspaceID: String
    let counterexamples: [Example]
    let learningOptOut: Bool

    enum CodingKeys: String, CodingKey {
        case name, intents, entities, language, metadata, description
        case dialogNodes = "dialog_nodes"
        case workspaceID = "workspace_id"
        case counterexamples
        case learningOptOut = "learning_opt_out"
    }
}

struct Example: Codable {
    let text: String
}

struct DialogNode: Codable {
    let type: DialogNodeType
    let title: String?
    let output: Output
    let parent: String?
    let context: Context?
    let metadata: DialogNodeMetadata
    let nextStep: NextStep?
    let conditions: String?
    let description: JSONNull?
    let dialogNode: String
    let previousSibling: String?

    enum CodingKeys: String, CodingKey {
        case type, title, output, parent, context, metadata
        case nextStep = "next_step"
        case conditions, description
        case dialogNode = "dialog_node"
        case previousSibling = "previous_sibling"
    }
}

struct Context: Codable {
    let reprompt: Bool?
    let defaultCounter: DefaultCounter?
    let applAction, heateronoff, wipersonoff, aConoff: String?
    let volumeonoff, lightonoff, musiconoff: String?

    enum CodingKeys: String, CodingKey {
        case reprompt
        case defaultCounter = "default_counter"
        case applAction = "appl_action"
        case heateronoff, wipersonoff
        case aConoff = "AConoff"
        case volumeonoff, lightonoff, musiconoff
    }
}

enum DefaultCounter: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(DefaultCounter.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for DefaultCounter"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

struct DialogNodeMetadata: Codable {
}

struct NextStep: Codable {
    let behavior: Behavior
    let selector: Selector
    let dialogNode: String

    enum CodingKeys: String, CodingKey {
        case behavior, selector
        case dialogNode = "dialog_node"
    }
}

enum Behavior: String, Codable {
    case jumpTo = "jump_to"
}

enum Selector: String, Codable {
    case body = "body"
    case condition = "condition"
    case userInput = "user_input"
}

struct Output: Codable {
    let text: TextUnion?
    let action: [String: String]?
}

enum TextUnion: Codable {
    case string(String)
    case textClass(TextClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(TextClass.self) {
            self = .textClass(x)
            return
        }
        throw DecodingError.typeMismatch(TextUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for TextUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let x):
            try container.encode(x)
        case .textClass(let x):
            try container.encode(x)
        }
    }
}

struct TextClass: Codable {
    let values: [String]
    let selectionPolicy: SelectionPolicy?

    enum CodingKeys: String, CodingKey {
        case values
        case selectionPolicy = "selection_policy"
    }
}

enum SelectionPolicy: String, Codable {
    case sequential = "sequential"
}

enum DialogNodeType: String, Codable {
    case responseCondition = "response_condition"
    case standard = "standard"
}

struct Entity: Codable {
    let entity: String
    let values: [Value]
    let metadata, description: JSONNull?
}

struct Value: Codable {
    let type: ValueType
    let value: String
    let metadata: JSONNull?
    let synonyms: [String]
}

enum ValueType: String, Codable {
    case synonyms = "synonyms"
}

struct Intent: Codable {
    let intent: String
    let examples: [Example]
    let description: JSONNull?
}

struct WatsonConversationWorkspaceMetadata: Codable {
    let apiVersion: APIVersion
    let fromSample: Bool

    enum CodingKeys: String, CodingKey {
        case apiVersion = "api_version"
        case fromSample = "from-sample"
    }
}

struct APIVersion: Codable {
    let majorVersion, minorVersion: String

    enum CodingKeys: String, CodingKey {
        case majorVersion = "major_version"
        case minorVersion = "minor_version"
    }
}

// MARK: Convenience initializers

extension WatsonConversationWorkspace {
    init(data: Data) throws {
        self = try JSONDecoder().decode(WatsonConversationWorkspace.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Example {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Example.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension DialogNode {
    init(data: Data) throws {
        self = try JSONDecoder().decode(DialogNode.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Context {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Context.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension DialogNodeMetadata {
    init(data: Data) throws {
        self = try JSONDecoder().decode(DialogNodeMetadata.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension NextStep {
    init(data: Data) throws {
        self = try JSONDecoder().decode(NextStep.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Output {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Output.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension TextClass {
    init(data: Data) throws {
        self = try JSONDecoder().decode(TextClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Entity {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Entity.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Value {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Value.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Intent {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Intent.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension WatsonConversationWorkspaceMetadata {
    init(data: Data) throws {
        self = try JSONDecoder().decode(WatsonConversationWorkspaceMetadata.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension APIVersion {
    init(data: Data) throws {
        self = try JSONDecoder().decode(APIVersion.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: Encode/decode helpers

class JSONNull: Codable {
    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
