import Foundation

public class Variable {
    public var identifier: String
    public var description: String
    public var value: Double?
    
    public init(identifier: String, value: Double, description: String? = nil) {
        self.identifier = identifier
        self.value = value
        self.description = description ?? identifier
    }
}
