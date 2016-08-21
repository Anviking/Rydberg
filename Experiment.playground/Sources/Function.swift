import Foundation

public indirect enum Function<X: Variable>: CustomStringConvertible {
    case variable(X.Type)
    case constant(Double)
    case operation(InfixOperation, Function<X>, Function<X>)
    case function(StandardFunction, of: Function<X>)
    
    public subscript(_ x: X) -> Double {
        switch self {
        case .variable:
            return x.value
        case .constant(let constant):
            return constant
        case let .operation(operation, a, b):
            return operation.evaluate(a[x], b[x])
        case let .function(function, inner):
            return function.evaluate(inner[x])
        }
    }
    
    public var description: String {
        switch self {
        case .variable:
            return "\(X.self)"
        case .constant(let constant):
            return "\(constant)"
        case let .operation(operation, a, b):
            return "\(a.description) \(operation.description) \(b.description)"
        case let .function(function, inner):
            return "\(function)(\(inner))"
        }
    }
    
    public var derivative: Function {
        switch self {
        case .variable:
            return .constant(1)
        case .constant(_):
            return .constant(0)
        case let .operation(operation, a, b):
            return operation.derivate(lhs: a, rhs: b)
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
    
}

extension Function: ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = .constant(value)
    }
    
    public init(integerLiteral value: Int) {
        self = .constant(Double(value))
    }
}


public postfix func ′ <X: Variable>(f: Function<X>) -> Function<X> {
    return f.derivative
}

public func + <A: Variable>(lhs: A.Type, rhs: Double) -> Function<A> {
    return Function<A>.operation(.addition, .variable(lhs), .constant(rhs))
}

public func + <A: Variable>(lhs: A.Type, rhs: Int) -> Function<A> {
    return Function<A>.operation(.addition, .variable(lhs), .constant(Double(rhs)))
}

public func + <A: Variable>(lhs: Function<A>, rhs: Function<A>) -> Function<A> {
    return .operation(.addition, lhs, rhs)
}

public func - <A: Variable>(lhs: Function<A>, rhs: Function<A>) -> Function<A> {
    return .operation(.subtraction, lhs, rhs)
}

prefix func - <A: Variable>(a: Function<A>) -> Function<A> {
    return .operation(.subtraction, .constant(0), a)
}

public func * <A: Variable>(lhs: Function<A>, rhs: Function<A>) -> Function<A> {
    return .operation(.multiplication, lhs, rhs)
}

public func / <A: Variable>(lhs: Function<A>, rhs: Function<A>) -> Function<A> {
    return .operation(.division, lhs, rhs)
}

precedencegroup PowerPrecedence {
    higherThan: MultiplicationPrecedence, AdditionPrecedence
}

infix operator ** : PowerPrecedence

public func ** <A: Variable>(lhs: Function<A>, rhs: Function<A>) -> Function<A> {
    return .operation(.power, lhs, rhs)
}


