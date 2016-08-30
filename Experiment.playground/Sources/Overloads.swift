// Score: 60 overloads

public func + <A: Variable>(lhs: Double, rhs: A.Type) -> Function<A> {
    return .addition(.constant(lhs), .variable(rhs))
}

public func + <A: Variable>(lhs: A.Type, rhs: Double) -> Function<A> {
    return .addition(.variable(lhs), .constant(rhs))
}

public func + <A: Variable>(lhs: Double, rhs: Function<A>) -> Function<A> {
    return .addition(.constant(lhs), rhs)
}

public func + <A: Variable>(lhs: Function<A>, rhs: Double) -> Function<A> {
    return .addition(lhs, .constant(rhs))
}

public func + <A: Variable>(lhs: Int, rhs: A.Type) -> Function<A> {
    return .addition(.constant(Double(lhs)), .variable(rhs))
}

public func + <A: Variable>(lhs: A.Type, rhs: Int) -> Function<A> {
    return .addition(.variable(lhs), .constant(Double(rhs)))
}

public func + <A: Variable>(lhs: Int, rhs: Function<A>) -> Function<A> {
    return .addition(.constant(Double(lhs)), rhs)
}

public func + <A: Variable>(lhs: Function<A>, rhs: Int) -> Function<A> {
    return .addition(lhs, .constant(Double(rhs)))
}

public func + <A: Variable>(lhs: A.Type, rhs: A.Type) -> Function<A> {
    return .addition(.variable(lhs), .variable(rhs))
}

public func + <A: Variable>(lhs: A.Type, rhs: Function<A>) -> Function<A> {
    return .addition(.variable(lhs), rhs)
}

public func + <A: Variable>(lhs: Function<A>, rhs: A.Type) -> Function<A> {
    return .addition(lhs, .variable(rhs))
}

public func + <A: Variable>(lhs: Function<A>, rhs: Function<A>) -> Function<A> {
    return .addition(lhs, rhs)
}

public func - <A: Variable>(lhs: Double, rhs: A.Type) -> Function<A> {
    return .subtraction(.constant(lhs), .variable(rhs))
}

public func - <A: Variable>(lhs: A.Type, rhs: Double) -> Function<A> {
    return .subtraction(.variable(lhs), .constant(rhs))
}

public func - <A: Variable>(lhs: Double, rhs: Function<A>) -> Function<A> {
    return .subtraction(.constant(lhs), rhs)
}

public func - <A: Variable>(lhs: Function<A>, rhs: Double) -> Function<A> {
    return .subtraction(lhs, .constant(rhs))
}

public func - <A: Variable>(lhs: Int, rhs: A.Type) -> Function<A> {
    return .subtraction(.constant(Double(lhs)), .variable(rhs))
}

public func - <A: Variable>(lhs: A.Type, rhs: Int) -> Function<A> {
    return .subtraction(.variable(lhs), .constant(Double(rhs)))
}

public func - <A: Variable>(lhs: Int, rhs: Function<A>) -> Function<A> {
    return .subtraction(.constant(Double(lhs)), rhs)
}

public func - <A: Variable>(lhs: Function<A>, rhs: Int) -> Function<A> {
    return .subtraction(lhs, .constant(Double(rhs)))
}

public func - <A: Variable>(lhs: A.Type, rhs: A.Type) -> Function<A> {
    return .subtraction(.variable(lhs), .variable(rhs))
}

public func - <A: Variable>(lhs: A.Type, rhs: Function<A>) -> Function<A> {
    return .subtraction(.variable(lhs), rhs)
}

public func - <A: Variable>(lhs: Function<A>, rhs: A.Type) -> Function<A> {
    return .subtraction(lhs, .variable(rhs))
}

public func - <A: Variable>(lhs: Function<A>, rhs: Function<A>) -> Function<A> {
    return .subtraction(lhs, rhs)
}

public func * <A: Variable>(lhs: Double, rhs: A.Type) -> Function<A> {
    return .multiplication(.constant(lhs), .variable(rhs))
}

public func * <A: Variable>(lhs: A.Type, rhs: Double) -> Function<A> {
    return .multiplication(.variable(lhs), .constant(rhs))
}

public func * <A: Variable>(lhs: Double, rhs: Function<A>) -> Function<A> {
    return .multiplication(.constant(lhs), rhs)
}

public func * <A: Variable>(lhs: Function<A>, rhs: Double) -> Function<A> {
    return .multiplication(lhs, .constant(rhs))
}

public func * <A: Variable>(lhs: Int, rhs: A.Type) -> Function<A> {
    return .multiplication(.constant(Double(lhs)), .variable(rhs))
}

public func * <A: Variable>(lhs: A.Type, rhs: Int) -> Function<A> {
    return .multiplication(.variable(lhs), .constant(Double(rhs)))
}

public func * <A: Variable>(lhs: Int, rhs: Function<A>) -> Function<A> {
    return .multiplication(.constant(Double(lhs)), rhs)
}

public func * <A: Variable>(lhs: Function<A>, rhs: Int) -> Function<A> {
    return .multiplication(lhs, .constant(Double(rhs)))
}

public func * <A: Variable>(lhs: A.Type, rhs: A.Type) -> Function<A> {
    return .multiplication(.variable(lhs), .variable(rhs))
}

public func * <A: Variable>(lhs: A.Type, rhs: Function<A>) -> Function<A> {
    return .multiplication(.variable(lhs), rhs)
}

public func * <A: Variable>(lhs: Function<A>, rhs: A.Type) -> Function<A> {
    return .multiplication(lhs, .variable(rhs))
}

public func * <A: Variable>(lhs: Function<A>, rhs: Function<A>) -> Function<A> {
    return .multiplication(lhs, rhs)
}

public func / <A: Variable>(lhs: Double, rhs: A.Type) -> Function<A> {
    return .division(.constant(lhs), .variable(rhs))
}

public func / <A: Variable>(lhs: A.Type, rhs: Double) -> Function<A> {
    return .division(.variable(lhs), .constant(rhs))
}

public func / <A: Variable>(lhs: Double, rhs: Function<A>) -> Function<A> {
    return .division(.constant(lhs), rhs)
}

public func / <A: Variable>(lhs: Function<A>, rhs: Double) -> Function<A> {
    return .division(lhs, .constant(rhs))
}

public func / <A: Variable>(lhs: Int, rhs: A.Type) -> Function<A> {
    return .division(.constant(Double(lhs)), .variable(rhs))
}

public func / <A: Variable>(lhs: A.Type, rhs: Int) -> Function<A> {
    return .division(.variable(lhs), .constant(Double(rhs)))
}

public func / <A: Variable>(lhs: Int, rhs: Function<A>) -> Function<A> {
    return .division(.constant(Double(lhs)), rhs)
}

public func / <A: Variable>(lhs: Function<A>, rhs: Int) -> Function<A> {
    return .division(lhs, .constant(Double(rhs)))
}

public func / <A: Variable>(lhs: A.Type, rhs: A.Type) -> Function<A> {
    return .division(.variable(lhs), .variable(rhs))
}

public func / <A: Variable>(lhs: A.Type, rhs: Function<A>) -> Function<A> {
    return .division(.variable(lhs), rhs)
}

public func / <A: Variable>(lhs: Function<A>, rhs: A.Type) -> Function<A> {
    return .division(lhs, .variable(rhs))
}

public func / <A: Variable>(lhs: Function<A>, rhs: Function<A>) -> Function<A> {
    return .division(lhs, rhs)
}

public func ** <A: Variable>(lhs: Double, rhs: A.Type) -> Function<A> {
    return .power(base: .constant(lhs), exponent: .variable(rhs))
}

public func ** <A: Variable>(lhs: A.Type, rhs: Double) -> Function<A> {
    return .power(base: .variable(lhs), exponent: .constant(rhs))
}

public func ** <A: Variable>(lhs: Double, rhs: Function<A>) -> Function<A> {
    return .power(base: .constant(lhs), exponent: rhs)
}

public func ** <A: Variable>(lhs: Function<A>, rhs: Double) -> Function<A> {
    return .power(base: lhs, exponent: .constant(rhs))
}

public func ** <A: Variable>(lhs: Int, rhs: A.Type) -> Function<A> {
    return .power(base: .constant(Double(lhs)), exponent: .variable(rhs))
}

public func ** <A: Variable>(lhs: A.Type, rhs: Int) -> Function<A> {
    return .power(base: .variable(lhs), exponent: .constant(Double(rhs)))
}

public func ** <A: Variable>(lhs: Int, rhs: Function<A>) -> Function<A> {
    return .power(base: .constant(Double(lhs)), exponent: rhs)
}

public func ** <A: Variable>(lhs: Function<A>, rhs: Int) -> Function<A> {
    return .power(base: lhs, exponent: .constant(Double(rhs)))
}

public func ** <A: Variable>(lhs: A.Type, rhs: A.Type) -> Function<A> {
    return .power(base: .variable(lhs), exponent: .variable(rhs))
}

public func ** <A: Variable>(lhs: A.Type, rhs: Function<A>) -> Function<A> {
    return .power(base: .variable(lhs), exponent: rhs)
}

public func ** <A: Variable>(lhs: Function<A>, rhs: A.Type) -> Function<A> {
    return .power(base: lhs, exponent: .variable(rhs))
}

public func ** <A: Variable>(lhs: Function<A>, rhs: Function<A>) -> Function<A> {
    return .power(base: lhs, exponent: rhs)
}
