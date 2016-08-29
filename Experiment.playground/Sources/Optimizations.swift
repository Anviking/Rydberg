import Foundation

extension Function: Equatable, Hashable {
    
    public var hashValue: Int {
        return "\(self)".hashValue
    }
    
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
    
    public func eliminateEqualTerms() -> Function {
        let terms = parseSum()
        var dict = [Function: Int]()
        
        for term in terms {
            dict[term] = (dict[term] ?? 0) + 1
        }
        
        var result = Function.constant(0)
        for (term, coef) in dict {
            result = result + (.constant(Double(coef)) * term)
        }
        return result
        
    }
    
    public func parseSum() -> [Function<X>] {
        // x + 3 + (1 * 2)
        //  (  +  )
        //    / \
        //   x  +
        //     / \
        //    3   *
        //       /\
        //      1 2
        switch self {
        case let .addition(a, b):
            return a.parseSum() + b.parseSum()
        case let .subtraction(a, b):
            return a.parseSum() + b.parseSum().map { -1 * $0 }
        default:
            return [self]
        }
    }
    
    
    
    /// Perform simplifications on this node only
    func optimized() -> Function {
        switch self {
        case .addition(let a, 0):
            return a
        case .addition(0, let a):
            return a
            
        case let .addition(.multiplication(a, b), c):
            switch (a.containsVariable, b.containsVariable, c.containsVariable) {
            case (true, false, true):
                return a * (b + (c / a))
            default:
                return a * b + c
            }
        case .subtraction(let a, 0):
            return a
            
        case .multiplication(0, _):
            return 0
        case .multiplication(_, 0):
            return 0
        case .multiplication(1, let a):
            return a
        case let .addition(a, .multiplication(-1, b)):
            return a - b
        case .multiplication(let a, 1):
            return a
        case let .multiplication(a, .division(b, c)):
            return ((a * b) / c)
        case let .multiplication(a, b):
            if a.simplified() == (1 / b).simplified() {
                return .constant(1)
            }
            if a == b ** -1 || a ** -1 == b {
                return .constant(1)
            }
            return a * b
        case let .addition(.constant(a), .constant(b)):
            return .constant(a + b)
        case let .subtraction(.constant(a), .constant(b)):
            return .constant(a - b)
            
        case let .power(.division(1, base), exponent):
            return 1 / base ** exponent
            
        case .power(let base, 1):
            return base
            
            /*
        case .power(let base, -1):
            return 1 / base
            */
            /*
        case .power(let base, 0.5):
            return sqrt(base)
            
        case .power(let base, .division(1, 2)):
            return sqrt(base)
            */
            
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
    
    public var nominalForm: Function {
        var result = mapChildren { $0.nominalForm }
        switch result {
        case let .addition(.addition(a, b), c):
            switch (a.containsVariable, b.containsVariable, c.containsVariable) {
            case (true, false, true):
                return (a + c) + b
            case (false, true, true):
                return (b + c) + a
            default:
                return a + b + c
            }
        case let .addition(a, b):
            switch (a.containsVariable, b.containsVariable) {
            case (false, true):
                return (b + a)
            default:
                return (a + b)
            }
        case let .subtraction(a, b):
            return (a + -b).nominalForm
        case let .division(a, b):
            return (a * b ** -1).nominalForm
        case let .multiplication(.multiplication(a, b), c):
            print("mul", a, b, c)
            switch (a.containsVariable, b.containsVariable, c.containsVariable) {
            case (true, false, true):
                return (b * (a * c)).nominalForm
            case (false, true, true):
                return (a * (b * c)).nominalForm
            default:
                return a * b * c
            }
            return a * b * c
        case let .multiplication(a, b):
            if b.containsVariable && !a.containsVariable {
                return b * a
            } else {
                return result
            }
        default:
            return result
        }
    }
}

public func == <X>(lhs: Function<X>, rhs: Function<X>) -> Bool {
    
    switch (lhs, rhs) {
    case let (.constant(a), .constant(b)):
        return a == b
    case let (.variable(_), .variable(_)):
        return true
    case let (.addition(a), .addition(b)):
        return a == b
    case let (.subtraction(a), .subtraction(b)):
        return a == b
    case let (.multiplication(a), .multiplication(b)):
        return a == b
    case let (.division(a), .division(b)):
        return a == b
    case let (.power(a), .power(b)):
        return a == b
    case let (.function(a), .function(b)):
        return a == b
    default:
        return false
    }
}
