import Foundation

public struct Equation: CustomStringConvertible {
    public var lhs: Expression
    public var rhs: Expression
    
    public init(lhs: Expression, rhs: Expression) {
        self.lhs = lhs
        self.rhs = rhs
    }
    
    public var description: String {
        return "\(lhs) == \(rhs)"
    }
    
    public mutating func solve(for variable: Variable) {
        if lhs.contains(variable) {
            let (l, r) = (lhs, rhs)
            (lhs, rhs) = (r, l)
        }
        switch rhs {
        case .constant(_):
            fatalError()
        case .variable(_):
            return
        case .addition(let a, let b):
            if a.contains(variable) {
                rhs = a
                lhs = .subtraction(lhs, b)
            }
            if b.contains(variable) {
                rhs = b
                lhs = .subtraction(lhs, a)
            }
        case .subtraction(let a, let b):
            if a.contains(variable) {
                rhs = a
                lhs = .addition(lhs, b)
            }
            if b.contains(variable) {
                rhs = b
                lhs = 0 - lhs - a
            }
        case .multiplication(let a, let b):
            if a.contains(variable) {
                rhs = a
                lhs = lhs / b
            }
            if b.contains(variable) {
                rhs = b
                lhs = lhs / a
            }
        case .division(let a, let b):
            if a.contains(variable) {
                rhs = a
                lhs = lhs * b
            }
            if b.contains(variable) {
                rhs = b
                lhs = a / lhs
            }
        case .power(_, _):
            fatalError()
        case .function( _, _, _):
            fatalError()
        }
        
        if rhs.contains(variable) {
            solve(for: variable)
        }
    }
    
}
