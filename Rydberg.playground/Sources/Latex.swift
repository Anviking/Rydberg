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
        case let .subtraction(a, b):
            return render(expression: a) + " - " + render(expression: b)
        case let .multiplication(a, b):
            return render(expression: a) + " \\cdot " + render(expression: b)
        case let .division(a, b):
            return "\\frac{\(render(expression: a))}{\(render(expression: b))}"
        case let .power(base, exponent):
            return "{" + render(expression: base) + "}^{" + render(expression: exponent) + "}"
        default:
            fatalError()
        }
    }
    
    /// Renders an expression and wraps it in an \begin{equation} ... \end{equation}
    public func render(equation: Expression, label: String?, ordered: Bool = true) -> String {
        let begin = ordered ? "\\begin{equation}" : "\\begin{equation*}"
        let end = "\\end{equation}"
        let label = label.map { "\\label{\($0)}" }
        return [begin, render(expression: equation), label, end]
            .flatMap { $0 }
            .joined(separator: "\n")
    }
}
