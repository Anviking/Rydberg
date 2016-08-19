import Foundation

func ~= (lhs: Double, rhs: Expression) -> Bool {
    return rhs.value == lhs
}

func ~= (lhs: Int, rhs: Expression) -> Bool {
    return rhs.value == Double(lhs)
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
    return Expression.multiplication(a, b).optimized()
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

public func sqrt(_ a: Expression) -> Expression {
    return .function(a, "sqrt", sqrt)
}

public func sin(_ a: Expression) -> Expression {
    return .function(a, "sin", sin)
}

public func cos(_ a: Expression) -> Expression {
    return .function(a, "cos", cos)
}

public func ln(_ a: Expression) -> Expression {
    return .function(a, "ln", log)
}
