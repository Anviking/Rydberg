import Foundation

public struct LatexRenderer {
    
    public init() {}
    
    public func render(expression: Expression) -> String {
        switch expression {
        case .constant(let c):
            return "\(c)"
        case .variable(let v):
            switch v.identifier {
            case "π":
                return "\\pi"
            default:
                return v.identifier
            }
        case let .addition(a, b):
            return render(expression: a) + " + " + render(expression: b)
        case let .multiplication(a, b):
            return render(expression: a) + " \\cdot " + render(expression: b)
        case let .division(a, b):
            return "\\frac{\(render(expression: a))}{\(render(expression: b))}"
        default:
            fatalError()
        }
    }
}
