import Foundation

public enum Function {
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
}
