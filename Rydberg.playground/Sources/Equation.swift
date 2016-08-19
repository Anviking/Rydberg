import Foundation

public func == (lhs: Expression, rhs: Expression) -> Equation {
    return Equation(lhs: lhs, rhs: rhs)
}

public struct Equation: CustomStringConvertible {
    public var lhs: Expression
    public var rhs: Expression
    
    public init(lhs: Expression, rhs: Expression) {
        self.lhs = lhs
        self.rhs = rhs
    }
    
    public var description: String {
        return "\(lhs) = \(rhs)"
    }
    
    public func solving(for variable: Variable) -> Equation {
        var copy = self
        copy.solve(for: variable)
        return copy
    }
    
    public mutating func solve(for variable: Variable) {
        if rhs.contains(variable) {
            (lhs, rhs) = (rhs, lhs)
        }
        switch lhs {
        case .constant(_):
            fatalError()
        case .variable(_):
            return
        case .addition(let a, let b):
            if a.contains(variable) {
                lhs = a
                rhs = .subtraction(rhs, b)
            }
            if b.contains(variable) {
                lhs = b
                rhs = .subtraction(rhs, a)
            }
        case .subtraction(let a, let b):
            if a.contains(variable) {
                lhs = a
                rhs = .addition(rhs, b)
            }
            if b.contains(variable) {
                lhs = b
                rhs = 0 - rhs - a
            }
        case .multiplication(let a, let b):
            if a.contains(variable) {
                lhs = a
                rhs = rhs / b
            }
            if b.contains(variable) {
                lhs = b
                rhs = rhs / a
            }
        case .division(let a, let b):
            if a.contains(variable) {
                lhs = a
                rhs = rhs * b
            }
            if b.contains(variable) {
                lhs = b
                rhs = a / rhs
            }
        case let .power(base, exponent):
            if base.contains(variable) {
                lhs = base
                rhs = rhs ** (1/exponent)
            }
            if exponent.contains(variable) {
                fatalError("TODO: implement ln")
            }
        case .function( _, _):
            fatalError()
        }
        
        if lhs.contains(variable) {
            solve(for: variable)
        }
        //(lhs, rhs) = (rhs, lhs)
    }
    
}
