import Foundation


extension Expression {
    public func derivative(ofDegree degree: UInt, withRespectTo variable: Variable) -> Expression {
        var result = self
        for _ in 0 ..< degree {
            result = result.derivative(withRespectTo: variable)
        }
        return result
    }
    
    public func derivative(withRespectTo variable: Variable) -> Expression {
        return unsimplifiedDerivative(withRespectTo: variable).simplified()
    }
    
    private func unsimplifiedDerivative(withRespectTo variable: Variable) -> Expression {
        switch self {
        case .constant(_):
            return .constant(0)
            
            
        case .variable(let v) where v === variable:
            return 1
        case .variable(let v):
            return .variable(v)
            
            
        case let .addition(a, b), let .subtraction(a, b):
            return a.derivative(withRespectTo: variable) + b.derivative(withRespectTo: variable)
            
            
        case let .multiplication(a, b):
            return a.derivative(withRespectTo: variable) * b + a * b.derivative(withRespectTo: variable)
            
        case let .division(a, b):
            return (a.derivative(withRespectTo: variable) * b - a * b.derivative(withRespectTo: variable)) / b ** 2
            
            
        case let .power(base, exponent):
            switch exponent {
            case -1:
                return base.derivative(withRespectTo: variable) * ln(base)
            default:
                return (exponent) * base ** (exponent - 1)
            }
            
        case let .function(f, of: inner):
            
            // Chain rule
            let innerDerivative = inner.derivative(withRespectTo: variable)
            
            switch f {
            case .sin:
                return cos(inner) * innerDerivative
            case .cos:
                return -sin(inner) * innerDerivative
            case .sqrt:
                return innerDerivative / (2 * sqrt(inner))
            case .arctan:
                return innerDerivative / 1 + inner ** 2
            case .arcsin:
                return innerDerivative / sqrt(1 - inner ** 2)
            case .arccos:
                return -innerDerivative / sqrt(1 - inner ** 2)
            default:
                fatalError("could not derrive \(self)")
            }
        }
    }
    
}
