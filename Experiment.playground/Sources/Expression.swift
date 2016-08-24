import Foundation

public enum Expression: ExpressibleByIntegerLiteral, CustomStringConvertible {
    case constant(Double)
    
    indirect case addition(Expression, Expression)
    indirect case subtraction(Expression, Expression)
    indirect case multiplication(Expression, Expression)
    indirect case division(Expression, Expression)
    
    indirect case power(base: Expression, exponent: Expression)
    
    indirect case function(StandardFunction, of: Expression)
    
    public init(integerLiteral value: Int) {
        self = .constant(Double(value))
    }
    
    public var value: Double {
        switch self {
        case .constant(let d):
            return d
        case .addition(let a, let b):
            return a.value + b.value
        case .subtraction(let a, let b):
            return a.value - b.value
        case .multiplication(let a, let b):
            return a.value * b.value
        case .division(let a, let b):
            return a.value / b.value
        case let .power(base, exponent):
            return pow(base.value, exponent.value)
        case let .function(f, of: inner):
            return f.evaluate(inner.value)
        }
    }
    public var description: String {
        switch self {
        case .constant(let d):
            return String(format: "%g", arguments: [d])
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
            
            
        case let .addition(.constant(a), .constant(b)):
            return .constant(a + b)
        case let .subtraction(.constant(a), .constant(b)):
            return .constant(a - b)
            
        case let .power(.division(1, base), exponent):
            return 1 / base ** exponent
            
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
            
        case let .division(.constant(a), .constant(b)):
            if a.truncatingRemainder(dividingBy: b) == 0 {
                return .constant(a / b)
            } else {
                return .constant(a) / .constant(b)
            }
            
        case let .division(.multiplication(a, .constant(b)), .constant(c)):
            return ((.constant(b) / .constant(c)) * a).optimized()
            
        case let .division(.division(a, b), .division(c, d)):
            return (a * d).optimized() / (b * c).optimized()
        case let .division(.division(a, b), c):
            return (a).optimized() / (b * c).optimized()
            
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

// MARK: Public operator overloads 

// MARK: Addition

public func + (a: Expression, b: Expression) -> Expression {
    return Expression.addition(a, b)
}

public func - (a: Expression, b: Expression) -> Expression {
    return Expression.subtraction(a, b)
}

public prefix func - (a: Expression) -> Expression {
    return Expression.subtraction(0, a)
}

public func * (a: Expression, b: Expression) -> Expression {
    return Expression.multiplication(a, b)
}

public func / (a: Expression, b: Expression) -> Expression {
    return Expression.division(a, b)
}

public func ** (a: Expression, b: Expression) -> Expression {
    return Expression.power(base: a, exponent: b)
}

// Functions

public func sqrt(_ a: Expression) -> Expression {
    return Expression.function(.sqrt, of: a)
}

// Pattern matching

func ~= (lhs: Double, rhs: Expression) -> Bool {
    return rhs.value == Double(lhs)
}

func ~= (lhs: Int, rhs: Expression) -> Bool {
    return Double(lhs) == rhs.value
}


