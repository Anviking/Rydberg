import Foundation

extension Function {
    
    func mapChildren(transform: (Function) -> Function) -> Function {
        var result: Function
        switch self {
        case let .addition(a, b):
            result = transform(a) + transform(b)
        case let .subtraction(a, b):
            result = transform(a) - transform(b)
        case let .multiplication(a, b):
            result = transform(a) * transform(b)
        case let .division(a, b):
            result = transform(a) / transform(b)
            
        case let .power(a, b):
            result = transform(a) ** transform(b)
            
        case let .function(f, inner):
            result = .function(f, of: transform(inner))
            
        case let .variable(v):
            result = .variable(v)
        case let .constant(v):
            result = .constant(v)
        }

        return result
    }
    
    /// Perform recursive simplifications from the bottom and up
    public func simplified() -> Function {
        return mapChildren { $0.simplified()  }.optimized()
    }
    
    // Experimental
    public var factorized: Function? {
        switch self {
        case let .addition(a, b):
            guard a.containsVariable, b.containsVariable else { return nil }
            switch (a, b) {
            case let (.division(a, c), .division(b, d)):
                return ((a * d + b * c) / (c*d)).simplified()
            default:
                return nil
            }
        default:
            return nil
        }
    }
    
    // Experimental
    public var expanded: Function {
        let result =  mapChildren { $0.expanded }
        
        switch result {
        case let .multiplication(a, .addition(b, c)):
            return a * b + a * c
        case let .division(a, .addition(b, c)):
            return a * b + a * c
        default:
            return result
        }
    }
    
    /// Perform simplifications on this node only
    func optimized() -> Function {
        switch self {
        case .addition(let a, 0):
            return a
        case .addition(0, let a):
            return a
            
        case .subtraction(let a, 0):
            return a.optimized()
            
        case .multiplication(0, _):
            return 0
        case .multiplication(_, 0):
            return 0
        case .multiplication(1, let a):
            return a
        case .multiplication(let a, 1):
            return a
            
            
        case let .addition(.constant(a), .constant(b)):
            return .constant(a + b)
        case let .subtraction(.constant(a), .constant(b)):
            return .constant(a - b)
            
        case let .power(.division(1, base), exponent):
            return 1 / base ** exponent
            
        case .power(let base, 1):
            return base
            
        case .power(let base, -1):
            return 1 / base
            
        case .power(let base, 0.5):
            return sqrt(base)
            
        case .power(let base, .division(1, 2)):
            return sqrt(base)
            
        case .division(let a, 1):
            return a
        case .division(0, _):
            return 0
            
        case let .division(.constant(a), .constant(b)):
            if a.truncatingRemainder(dividingBy: b) == 0 {
                return .constant(a / b)
            } else {
                return .constant(a) / .constant(b)
            }
            
        case let .division(.multiplication(a, .constant(b)), .constant(c)):
            return ((.constant(b) / .constant(c)) * a).optimized()
            
        case let .division(.division(a, b), .division(c, d)):
            return (a * d).optimized() / (b * c).optimized()
        case let .division(.division(a, b), c):
            return (a).optimized() / (b * c).optimized()
            
        default:
            return self
        }
    }
}
