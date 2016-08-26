import Foundation

public indirect enum Function<X: Variable>: CustomStringConvertible {
    case variable(X.Type)
    case constant(Double)
    
    case addition(Function, Function)
    case subtraction(Function, Function)
    case multiplication(Function, Function)
    case division(Function, Function)
    case power(base: Function, exponent: Function)
    
    case function(StandardFunction, of: Function<X>)
    
    public subscript(_ x: X) -> Double {
        switch self {
        case .variable:                     return x.value
        case .constant(let constant):       return constant
        case let .addition(lhs, rhs):       return lhs[x] + rhs[x]
        case let .subtraction(lhs, rhs):    return lhs[x] - rhs[x]
        case let .multiplication(lhs, rhs): return lhs[x] * rhs[x]
        case let .division(lhs, rhs):       return lhs[x] / rhs[x]
        case let .power(base, exponent):    return pow(base[x], exponent[x])
        case let .function(function, inner):return function.evaluate(inner[x])
        }
    }
    
    public var description: String {
        switch self {
        case .constant(let d):
            return String(format: "%g", arguments: [d])
        case .variable(let v):
            return "\(v)"
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
    
    public var derivative: Function {
        switch self {
        case .variable:
            return .constant(1)
        case .constant(_):
            return .constant(0)
            
        case let .addition(a, b):
            return a.derivative + b.derivative
        case let .subtraction(a, b):
            return a.derivative - b.derivative
        case let .multiplication(a, b):
            return a.derivative * b + a * b.derivative
        case let .division(a, b):
            return (a.derivative * b - a * b.derivative) / b ** 2
        case let .power(base, exponent):
            switch (base.containsVariable, exponent.containsVariable) {
            case (true, false):
                return exponent * base ** (exponent - 1)
            case (false, false):
                return .constant(0)
            default:
                fatalError("derivative of \(self) is unimplemented")
            }
        
        case let .function(f, inner):
            switch f {
            case .sin:
                return cos(inner) * inner.derivative
            case .cos:
                return -sin(inner) * inner.derivative
            case .sqrt:
                return inner.derivative / (2 * sqrt(inner))
            case .arctan:
                return inner.derivative / (1 + inner ** 2)
            case .arcsin:
                return inner.derivative / sqrt(1 - inner ** 2)
            case .arccos:
                return -inner.derivative / sqrt(1 - inner ** 2)
            default:
                fatalError("could not derrive \(self)")
            }
        }
    }
    
    public func derivative(ofDegree degree: UInt) -> Function {
        return (0 ..< degree).reduce(self) {
            $0.0.derivative
        }
    }
    
    public var containsVariable: Bool {
        switch self {
        case .constant(_):
            return false
        case .variable(_):
            return true
        case .addition(let a, let b):
            return a.containsVariable || b.containsVariable
        case .subtraction(let a, let b):
            return a.containsVariable || b.containsVariable
        case .multiplication(let a, let b):
            return a.containsVariable || b.containsVariable
        case .division(let a, let b):
            return a.containsVariable || b.containsVariable
        case let .power(base: a, exponent: b):
            return a.containsVariable || b.containsVariable
        case .function(_, let inner):
            return inner.containsVariable
        }
    }
    
}

extension Function: ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = .constant(value)
    }
    
    public init(integerLiteral value: Int) {
        self = .constant(Double(value))
    }
}


postfix operator ′
public postfix func ′ <X: Variable>(f: Function<X>) -> Function<X> {
    return f.derivative
}

public func + <A: Variable>(lhs: A.Type, rhs: Double) -> Function<A> {
    return Function<A>.addition(.variable(lhs), .constant(rhs))
}

public func + <A: Variable>(lhs: A.Type, rhs: Int) -> Function<A> {
    return Function<A>.addition(.variable(lhs), .constant(Double(rhs)))
}

public func + <A: Variable>(lhs: Function<A>, rhs: Function<A>) -> Function<A> {
    return .addition(lhs, rhs)
}

public func + <A: Variable>(lhs: Function<A>, rhs: A.Type) -> Function<A> {
    return .addition(lhs, .variable(rhs))
}

public func - <A: Variable>(lhs: Function<A>, rhs: Function<A>) -> Function<A> {
    return .subtraction(lhs, rhs)
}

public func - <A: Variable>(lhs: Function<A>, rhs: A.Type) -> Function<A> {
    return .subtraction(lhs, .variable(rhs))
}

prefix func - <A: Variable>(a: Function<A>) -> Function<A> {
    return .subtraction(.constant(0), a)
}

prefix func - <A: Variable>(a: A.Type) -> Function<A> {
    return .subtraction(.constant(0), .variable(a))
}

public func * <A: Variable>(lhs: Function<A>, rhs: Function<A>) -> Function<A> {
    return .multiplication(lhs, rhs)
}

public func * <A: Variable>(lhs: Function<A>, rhs: A.Type) -> Function<A> {
    return .multiplication(lhs, .variable(rhs))
}

public func / <A: Variable>(lhs: Function<A>, rhs: Function<A>) -> Function<A> {
    return .division(lhs, rhs)
}

public func / <A: Variable>(lhs: Function<A>, rhs: A.Type) -> Function<A> {
    return .division(lhs, .variable(rhs))
}

precedencegroup PowerPrecedence {
    higherThan: MultiplicationPrecedence, AdditionPrecedence
}

infix operator ** : PowerPrecedence

public func ** <A: Variable>(lhs: Function<A>, rhs: Function<A>) -> Function<A> {
    return .power(base: lhs, exponent: rhs)
}

public func ** <A: Variable>(lhs: Function<A>, rhs: A.Type) -> Function<A> {
    return .power(base: lhs, exponent: .variable(rhs))
}

// MARK: Pattern matching

func ~= <X: Variable>(lhs: Double, rhs: Function<X>) -> Bool {
    switch rhs {
    case .constant(let c):
        return c == Double(lhs)
    default:
        return false
    }
}

func ~= <X>(lhs: Int, rhs: Function<X>) -> Bool {
    switch rhs {
    case .constant(let c):
        return c == Double(lhs)
    default:
        return false
    }
}


