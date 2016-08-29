import Foundation

extension Function {
    
    /// y = f(x)
    /// x = f^-1(y)
    ///
    /// y = 2 * (x + 3)
    ///            - 3
    ///     / 2
    
    
    
    // y = 2x + 3
    // y = a + 3
    // a = y - 3
    //
    // x - 3
    // x - 3
    
    
    /*
     y = 2x + 3
     y.i = (x - 3).sub(2x.i)
     =
     
     
     
     */
    
    //    private func inverse(infixOperator: Function, solvingFor x: Function, from y: Function) -> Function {
    //        switch lhs {
    //        case let .addition(_, _):
    //            return self -
    //    }
    //
    
    func map(transform: (Function) -> Function) -> Function {
        switch self {
        case let .addition(a, b):
            return a.map(transform: transform) + b.map(transform: transform)
        case let .subtraction(a, b):
            return a.map(transform: transform) - b.map(transform: transform)
        case let .multiplication(a, b):
            return a.map(transform: transform) * b.map(transform: transform)
        case let .division(a, b):
            return a.map(transform: transform) / b.map(transform: transform)
            
        case let .power(a, b):
            return a.map(transform: transform) ** b.map(transform: transform)
            
        case let .function(f, inner):
            return .function(f, of: inner.map(transform: transform))
            
        case let .variable(v):
            return transform(.variable(v))
        case let .constant(v):
            return transform(.constant(v))
        }
    }
    
    
    
    func substituteVariable(for f: Function) -> Function {
        return map { expression in
            switch expression {
            case .variable(_):
                return f
            default: return expression
            }
        }
    }

    public subscript(_ expression: Function) -> Function {
        return substituteVariable(for: expression)
    }
    
    public var inverse: Function? {
        switch self {
        case let .addition(a, b):
            switch (a.containsVariable, b.containsVariable) {
            case (true, true):
                return factorized?.inverse
            case (true, false):
                return a.inverse?.substituteVariable(for: .variable(X.self) - b)
            case (false, true):
                return b.inverse?.substituteVariable(for: .variable(X.self) - a)
            case (false, false):
                return nil
            }
        case let .multiplication(a, b):
            switch (a.containsVariable, b.containsVariable) {
            case (true, true):
                return factorized?.inverse
            case (true, false):
                return a.inverse?.substituteVariable(for: .variable(X.self) / b)
            case (false, true):
                return b.inverse?.substituteVariable(for: .variable(X.self) / a)
            case (false, false):
                return nil
            }
            
        case let .division(a, b):
            switch (a.containsVariable, b.containsVariable) {
            case (true, true):
                return factorized?.inverse
            case (true, false):
                return a.inverse?.substituteVariable(for: .variable(X.self) * b)
            case (false, true):
                return b.inverse?.substituteVariable(for: .variable(X.self) / a)
            case (false, false):
                return nil
            }
            
        case let .variable(v):
            return .variable(v)
        case let .constant(c):
            return .constant(c)
        default:
            return nil
        }
    }
}
