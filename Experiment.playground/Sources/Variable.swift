import Foundation

public protocol Variable: ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral {
    var value: Double { get set}
}


public struct x: Variable {
    public var value: Double
    public init(floatLiteral value: Double) { self.value = value }
    public init(integerLiteral value: Int) { self.value = Double(value) }
}
