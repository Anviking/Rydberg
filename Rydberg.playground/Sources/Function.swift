import Foundation

public enum Function {
    case sin, cos, ln, exp, sqrt
    
    private var closure: (Double) -> Double {
        switch self {
        case .sin: return Darwin.sin
        case .cos: return Darwin.cos
        case .ln: return Darwin.log
        case .exp: return Darwin.exp
        case .sqrt: return Darwin.sqrt
        }
    }
    
    public func evaluate(_ value: Double) -> Double {
        return closure(value)
    }
}
