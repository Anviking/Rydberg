import Foundation

postfix operator ′

public enum InfixOperation {
    case addition, subtraction, multiplication, division, power
    
    public func evaluate(_ lhs: Double, _ rhs: Double) -> Double {
        switch self {
        case .addition:
            return lhs + rhs
        case .subtraction:
            return lhs - rhs
        case .multiplication:
            return lhs * rhs
        case .division:
            return lhs / rhs
        case .power:
            return lhs * rhs
        }
    }
    
    public var description: String {
        switch self {
        case .addition:
            return "+"
        case .subtraction:
            return "-"
        case .multiplication:
            return "*"
        case .division:
            return "/"
        case .power:
            return "^"
        }
    }
    
    func derivate<X>(lhs f: Function<X>, rhs g: Function<X>) -> Function<X> {
        switch self {
        case .addition:
            return f′ + g′
        case .subtraction:
            return f′ - g′
        case .multiplication:
            return f′ * g + f * g′
        case .division:
            return (f′ * g - f * g′) / g ** 2
        case .power: // f^g
            fatalError("unimplemented")
        }
    }
}

