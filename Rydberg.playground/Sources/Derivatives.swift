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
            
        case let .function(f, of: inner):
            
            // Chain rule
            let innerDerivative = inner.derive(withRespectTo: variable)
            
            switch f {
            case .sin:
                return cos(inner) * innerDerivative
            case .cos:
                return (-1) * sin(inner) * innerDerivative
            case .sqrt:
                return innerDerivative / (2 * sqrt(inner))
            default:
                fatalError("could not derrive \(self)")
            }
        }
    }
    
}
