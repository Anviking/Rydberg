import Foundation

public func factorial<I: Integer>(_ number: I) -> (I) {
    if (number <= 1) {
        return 1
    }
    
    return number * factorial(number - 1)
}

public func taylorExpansion<X>(of f: Function<X>, at a: X, degree: UInt) -> Function<X> {
    var result: Function<X> = .constant(0)
    for i in 0 ... degree {
        let der = f.derivative(ofDegree: degree)
        let coefficient = der[a]
        
        let a: Function<X> = (.variable(X.self) - .constant(a.value)) ** .constant(Double(i))
        result = result + a * .constant(coefficient) / .constant(Double(factorial(i)))
    }
    
    return result
}
