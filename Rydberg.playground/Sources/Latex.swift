import Foundation

public struct LatexDocument {
    public var renderer: LatexRenderer
    public var latex: String
    
    public init(latex: String = "", renderer: LatexRenderer = LatexRenderer()) {
        self.renderer = renderer
        self.latex = latex
    }
    
    public mutating func append(_ expression: Expression) {
        latex.append("\\[" + renderer.render(expression) + "\\]")
    }
    
    public mutating func append(_ paragraph: String) {
        latex.append("\n" + paragraph + "\n")
    }
}

public struct LatexRenderer {
    
    public init() {}
    
    public func render(_ expression: Expression) -> String {
        switch expression {
        case .constant(let c):
            return String(format: "%g", arguments: [c])
        case .variable(let v):
            switch v {
            case "π":
                return "\\pi"
            default:
                return v
            }
        case let .addition(a, b):
            return render(a) + " + " + render(b)
        case let .subtraction(a, b):
            return render(a) + " - " + render(b)
            
        case let .multiplication(a, .addition(b, c)):
            return render(a) + " \\left(" + render(b) + " + " + render(c) + "\\right)"
        case let .multiplication(a, b):
            return render(a) + " \\cdot " + render(b)
        
        case let .division(a, b):
            return "\\frac{\(render(a))}{\(render(b))}"
        
        case let .power(.variable(base), exponent):
            return "{" + render(.variable(base)) + "}^{" + render(exponent) + "}"
        case let .power(base, exponent):
            return "\\left(" + render(base) + "\\right)^{" + render(exponent) + "}"
        
        case let .function(f, of: inner):
            switch f {
            case .arctan:
                return "\\arctan{" + render(inner) + "}"
            case .arcsin:
                return "\\arcsin{" + render(inner) + "}"
            default:
                fatalError("Couldn't render \(f)(\(inner))")
            }
        default:
            fatalError()
        }
    }
    
    public func render(_ equation: Equation) -> String {
        return render(equation.lhs) + " = " + render(equation.rhs)
    }

    
    /*
    /// Renders an expression and wraps it in an \begin{equation} ... \end{equation}
    public func render(equation: Expression, label: String?, ordered: Bool = true) -> String {
        let begin = ordered ? "\\begin{equation}" : "\\begin{equation*}"
        let end = "\\end{equation}"
        let label = label.map { "\\label{\($0)}" }
        return [begin, render(expression: equation), label, end]
            .flatMap { $0 }
            .joined(separator: "\n")
    }
     */
}
