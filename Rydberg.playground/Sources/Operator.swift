import Foundation

/*
/// An infix operator
public enum Operator: CustomStringConvertible {
    case addition, subtraction, multiplication, power
    
    public var description: String {
        switch self {
        case .addition:
            return "+"
        case .subtraction:
            return "-"
        case .multiplication:
            return "*"
        case .power:
            return "^"
        }
    }
    
    public func evaluate(lhs: Double, rhs: Double) -> Double {
        switch self {
        case .addition:
            return lhs + rhs
        case .subtraction:
            return lhs - rhs
        case .multiplication:
            return lhs * rhs
        case .power:
            return lhs * rhs
        }
    }
}
 */

func ~= (lhs: Double, rhs: Expression) -> Bool {
    switch rhs {
    case .constant(let c):
        return c == Double(lhs)
    default:
        return false
    }
}

func ~= (lhs: Int, rhs: Expression) -> Bool {
    switch rhs {
    case .constant(let c):
        return c == Double(lhs)
    default:
        return false
    }
}

// MARK: Addition

public func + (a: Expression, b: Expression) -> Expression {
    return Expression.addition(a, b).optimized()
}

public func + (a: Variable, b: Expression) -> Expression {
    return .addition(.variable(a), b)
}

public func + (a: Expression, b: Variable) -> Expression {
    return .addition(a, .variable(b))
}

// MARK: Subtraction

public func - (a: Expression, b: Expression) -> Expression {
    return Expression.subtraction(a, b).optimized()
}

public func - (a: Variable, b: Expression) -> Expression {
    return .subtraction(.variable(a), b)
}

public func - (a: Expression, b: Variable) -> Expression {
    return .subtraction(a, .variable(b))
}

// MARK: Multiplication

public func * (a: Expression, b: Expression) -> Expression {
    return Expression.multiplication(a, b)
}

public func * (a: Variable, b: Expression) -> Expression {
    return .multiplication(.variable(a), b)
}

public func * (a: Expression, b: Variable) -> Expression {
    return .multiplication(a, .variable(b))
}

// MARK: Division

public func / (a: Expression, b: Expression) -> Expression {
    return Expression.division(a, b).optimized()
}

public func / (a: Variable, b: Expression) -> Expression {
    return .division(.variable(a), b)
}

public func / (a: Expression, b: Variable) -> Expression {
    return .division(a, .variable(b))
}

// MARK:

precedencegroup PowerPrecedence {
    higherThan: MultiplicationPrecedence, AdditionPrecedence
}

infix operator ** : PowerPrecedence

public func ** (a: Expression, b: Expression) -> Expression {
    return Expression.power(base: a, exponent: b)
}

public func ** (a: Variable, b: Expression) -> Expression {
    return .power(base: .variable(a), exponent: b)
}

public func ** (a: Expression, b: Variable) -> Expression {
    return Expression.power(base: a, exponent: .variable(b))
}

public func sqrt(_ x: Expression) -> Expression {
    return .function(.sqrt, of: x)
}

public func sin(_ x: Expression) -> Expression {
    return .function(.sin, of: x)
}

public func cos(_ x: Expression) -> Expression {
    return .function(.cos, of: x)
}

public func ln(_ x: Expression) -> Expression {
    return .function(.ln, of: x)
}
