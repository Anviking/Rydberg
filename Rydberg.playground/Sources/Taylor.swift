import Foundation

public func factorial<I: Integer>(_ number: I) -> (I) {
    if (number <= 1) {
        return 1
    }
    
    return number * factorial(number - 1)
}

// THIS IS HORRIBLE
public func taylorExpansion(of f: Expression, at a: Double, variable x: Variable, degree: UInt) -> Expression {
    x.value = a
    var expression: Expression = 0
    var f_n = f
    for i in 0 ... degree {
        let coefficient = f_n.derivative(withRespectTo: x)
        expression = expression + (.variable(x) - .constant(Double(a))) ** .constant(Double(i)) * .constant(coefficient) / .constant(Double(factorial(i)))
    }
    
    return expression.simplified()
}
 
