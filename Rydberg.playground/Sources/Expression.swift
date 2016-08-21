import Foundation

public enum Expression: ExpressibleByIntegerLiteral, CustomStringConvertible {
    case constant(Double)
    case variable(Variable)
    
    indirect case addition(Expression, Expression)
    indirect case subtraction(Expression, Expression)
    indirect case multiplication(Expression, Expression)
    indirect case division(Expression, Expression)
    
    indirect case power(base: Expression, exponent: Expression)
    
    indirect case function(Function, of: Expression)
    
    public init(integerLiteral value: Int) {
        self = .constant(Double(value))
    }
    
    public var value: Double? {
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
        case let .power(base, exponent):
            guard let base = base.value, let exponent = exponent.value else { return nil }
            return pow(base, exponent)
        case let .function(f, of: inner):
            return inner.value.map(f.evaluate)
        }
    }
    public var description: String {
        switch self {
        case .constant(let d):
            return String(format: "%%.0g", arguments: [d])
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
        case let .function(f, of: inner):
            return "(\(f)(\(inner.description)))"
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
        case .function(_, let inner):
            return inner.contains(variable)
        }
    }
    
    var isConstant: Bool {
        switch self {
        case .constant(_):
            return true
        case .variable(_):
            return false
        case .addition(let a, let b):
            return a.isConstant && b.isConstant
        case .subtraction(let a, let b):
            return a.isConstant && b.isConstant
        case .multiplication(let a, let b):
            return a.isConstant && b.isConstant
        case .division(let a, let b):
            return a.isConstant && b.isConstant
        case let .power(base: a, exponent: b):
            return a.isConstant && b.isConstant
        case .function(_, let inner):
            return inner.isConstant
        }
    }
    
    /// Perform recursive simplifications from the bottom and up
    public func simplified() -> Expression {
        var result: Expression
        switch self {
        case let .addition(a, b):
            result = a.simplified() + b.simplified()
        case let .subtraction(a, b):
            result = a.simplified() - b.simplified()
        case let .multiplication(a, b):
            result = a.simplified() * b.simplified()
        case let .division(a, b):
            result = a.simplified() / b.simplified()
            
        case let .power(a, b):
            result = a.simplified() ** b.simplified()
            
        case let .function(f, inner):
            result = .function(f, of: inner.simplified())
            
        case let .variable(v):
            result = .variable(v)
        case let .constant(v):
            result = .constant(v)
        }
        
        return result.optimized()
    }
    
    /// Perform simplifications on this node only
    func optimized() -> Expression {
        switch self {
        case .addition(let a, 0):
            return a
        case .addition(0, let a):
            return a
            
        case .subtraction(let a, 0):
            return a.optimized()
            
        case .multiplication(0, _):
            return 0
        case .multiplication(_, 0):
            return 0
        case .multiplication(1, let a):
            return a
        case .multiplication(let a, 1):
            return a
            
        case .power(let base, 1):
            return base
            
        case .power(let base, -1):
            return 1 / base
        
        case .power(let base, 0.5):
            return sqrt(base)
            
        case .power(let base, .division(1, 2)):
            return sqrt(base)
        
        case .division(let a, 1):
            return a
        case .division(0, _):
            return 0
        default:
            return self
        }
    }
}

// MARK: Private operator overloads

private func + (lhs: Double?, rhs: Double?) -> Double? {
    guard let lhs = lhs, let rhs = rhs else { return nil }
    return lhs + rhs
}

private func - (lhs: Double?, rhs: Double?) -> Double? {
    guard let lhs = lhs, let rhs = rhs else { return nil }
    return lhs - rhs
}

private func * (lhs: Double?, rhs: Double?) -> Double? {
    guard let lhs = lhs, let rhs = rhs else { return nil }
    return lhs * rhs
}

private func / (lhs: Double?, rhs: Double?) -> Double? {
    guard let lhs = lhs, let rhs = rhs else { return nil }
    return lhs / rhs
}
