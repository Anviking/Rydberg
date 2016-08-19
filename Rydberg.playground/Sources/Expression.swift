import Foundation

public class Variable {
    public var identifier: String
    public var description: String
    public var value: Double
    
    public init(identifier: String, value: Double, description: String? = nil) {
        self.identifier = identifier
        self.value = value
        self.description = description ?? identifier
    }
}

public enum Expression: ExpressibleByIntegerLiteral, CustomStringConvertible {
    case constant(Double)
    case variable(Variable)
    
    indirect case addition(Expression, Expression)
    indirect case subtraction(Expression, Expression)
    indirect case multiplication(Expression, Expression)
    indirect case division(Expression, Expression)
    
    indirect case power(base: Expression, exponent: Expression)
    
    indirect case function(Expression, String, (Double) -> Double)
    
    public init(integerLiteral value: Int) {
        self = .constant(Double(value))
    }
    
    public var value: Double {
        switch self {
        case .constant(let d):
            return d
        case .variable(let v):
            return v.value
        case .addition(let a, let b):
            return a.value + b.value
        case .subtraction(let a, let b):
            return a.value - b.value
        case .multiplication(let a, let b):
            return a.value * b.value
        case .division(let a, let b):
            return a.value / b.value
        case let .power(base: a, exponent: b):
            return pow(a.value, b.value)
        case .function(let a, _, let f):
            return f(a.value)
        }
    }
    public var description: String {
        switch self {
        case .constant(let d):
            return "\(d)"
        case .variable(let v):
            return v.identifier
        case .addition(let a, let b):
            return "(\(a.description) + \(b.description))"
        case .subtraction(let a, let b):
            return "(\(a.description) - \(b.description))"
        case .multiplication(let a, let b):
            return "(\(a.description) * \(b.description))"
        case .division(let a, let b):
            return "(\(a.description) / \(b.description))"
        case let .power(base: a, exponent: b):
            return "(\(a.description) ^ \(b.description))"
        case .function(let a, let d, _):
            return "(\(d)(\(a.description)))"
        }
    }
    
    public func contains(_ variable: Variable) -> Bool {
        switch self {
        case .constant(_):
            return false
        case .variable(let v):
            return v === variable
        case .addition(let a, let b):
            return a.contains(variable) || b.contains(variable)
        case .subtraction(let a, let b):
            return a.contains(variable) || b.contains(variable)
        case .multiplication(let a, let b):
            return a.contains(variable) || b.contains(variable)
        case .division(let a, let b):
            return a.contains(variable) || b.contains(variable)
        case let .power(base: a, exponent: b):
            return a.contains(variable) || b.contains(variable)
        case .function(let a, _, _):
            return a.contains(variable)
        }
    }
    
    func optimized() -> Expression {
        switch self {
        case .addition(let a, 0):
            return a
        case .addition(0, let a):
            return a
        case .multiplication(0, _):
            return 0
        case .multiplication(_, 0):
            return 0
        case .multiplication(1, let a):
            return a
        case .multiplication(let a, 1):
            return a
        
        case .division(let a, 1):
            return a
        default:
            return self
        }
    }
}
