import Foundation

extension Expression {
    public func derive(withRespectTo variable: Variable) -> Expression {
        switch self {
        case .constant(_):
            return .constant(0)
        case .variable(let v) where v === variable:
            return 1
        case .variable(let v):
            return .variable(v)
        case let .addition(a, b), let .subtraction(a, b):
            return a.derive(withRespectTo: variable) + b.derive(withRespectTo: variable)
        case let .multiplication(a, b):
            return a.derive(withRespectTo: variable) * b + a * b.derive(withRespectTo: variable)
        case let .division(a, b):
            return (a.derive(withRespectTo: variable) * b - a * b.derive(withRespectTo: variable)) / b ** 2
        case let .power(base, exponent):
            switch exponent {
            case -1:
                return base.derive(withRespectTo: variable) * ln(base)
            default:
                return (exponent) * base ** (exponent - 1)
            }
        case .function(let inner, let d, _):
            switch d {
            case "sin":
                return cos(inner) * inner.derive(withRespectTo: variable)
            case "cos":
                return (-1) * sin(inner) * inner.derive(withRespectTo: variable)
            case "sqrt":
                return inner.derive(withRespectTo: variable) / (2 * sqrt(inner))
            default:
                fatalError("could not derrive \(self)")
            }
        }
    }
    
}
