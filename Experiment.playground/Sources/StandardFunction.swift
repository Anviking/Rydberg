import Foundation

public enum StandardFunction: CustomStringConvertible {
    case sin, cos, ln, exp, sqrt, arcsin, arccos, arctan
    
    private var closure: (Double) -> Double {
        switch self {
        case .sin: return Darwin.sin
        case .cos: return Darwin.cos
        case .ln: return Darwin.log
        case .exp: return Darwin.exp
        case .sqrt: return Darwin.sqrt
        case .arcsin: return Darwin.asin
        case .arccos: return Darwin.atan
        case .arctan: return Darwin.atan
        }
    }
    
    public func evaluate(_ value: Double) -> Double {
        return closure(value)
    }
    
    public var description: String {
        switch self {
        case .sin: return "sin"
        case .cos: return "cos"
        case .ln: return "ln"
        case .exp: return "exp"
        case .sqrt: return "sqrt"
        case .arcsin: return "arcsin"
        case .arccos: return "arccos"
        case .arctan: return "arctan"
        }
    }
}

public func sqrt<X: Variable>(_ x: Function<X>) -> Function<X> {
    return .function(.sqrt, of: x)
}

public func cos<X: Variable>(_ x: Function<X>) -> Function<X> {
    return .function(.cos, of: x)
}

public func sin<X: Variable>(_ x: Function<X>) -> Function<X> {
    return .function(.sin, of: x)
}

public func arctan<X: Variable>(_ x: Function<X>) -> Function<X> {
    return .function(.arctan, of: x)
}

public func arcsin<X: Variable>(_ x: Function<X>) -> Function<X> {
    return .function(.arcsin, of: x)
}

public func arccos<X: Variable>(_ x: Function<X>) -> Function<X> {
    return .function(.arccos, of: x)
}

public func ln<X: Variable>(_ x: Function<X>) -> Function<X> {
    return .function(.ln, of: x)
}

///

public func sqrt<X: Variable>(_ x: X.Type) -> Function<X> {
    return .function(.sqrt, of: .variable(x))
}

public func cos<X: Variable>(_ x: X.Type) -> Function<X> {
    return .function(.cos, of: .variable(x))
}

public func sin<X: Variable>(_ x: X.Type) -> Function<X> {
    return .function(.sin, of: .variable(x))
}

public func arctan<X: Variable>(_ x: X.Type) -> Function<X> {
    return .function(.arctan, of: .variable(x))
}

public func arcsin<X: Variable>(_ x: X.Type) -> Function<X> {
    return .function(.arcsin, of: .variable(x))
}

public func arccos<X: Variable>(_ x: X.Type) -> Function<X> {
    return .function(.arccos, of: .variable(x))
}

public func ln<X: Variable>(_ x: X.Type) -> Function<X> {
    return .function(.ln, of: .variable(x))
}
