//: [Previous](@previous)

import Foundation

/*
enum Expression<A> {
    case variable(A)
    case constant(Double)
    case addition(Function<A>, Function<A>)
}
*/

postfix operator ′ {}

indirect enum Function<X: Variable>: CustomStringConvertible {
    case variable(X.Type)
    case constant(Double)
    case addition(Function<X>, Function<X>)
    
    subscript(_ x: X) -> Double {
    switch self {
    case .variable:
        return x.value
    case .constant(let constant):
        return constant
    case let .addition(a, b):
        return a[x] + b[x]
    }
    }
    
    var description: String {
        switch self {
        case .variable:
            return "\(X.self)"
        case .constant(let constant):
            return "\(constant)"
        case let .addition(a, b):
            return a.description + " + " + b.description
        }
    }
    
    var derivative: Function {
        switch self {
        case .variable:
            return .constant(1)
        case .constant(_):
            return .constant(0)
        case let .addition(a, b):
            return .addition(a.derivative, b.derivative)
        }
    }
    
}


postfix func ′ <X: Variable>(f: Function<X>) -> Function<X> {
    return f.derivative
}

protocol Variable: ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral {
    var value: Double { get set}
}


struct x: Variable { var value: Double; init(floatLiteral value: Double) { self.value = value }; init(integerLiteral value: Int) { self.value = Double(value) } }

func + <A: Variable>(lhs: A.Type, rhs: Double) -> Function<A> {
    return Function<A>.addition(.variable(lhs), .constant(rhs))
}

func + <A: Variable>(lhs: A.Type, rhs: Int) -> Function<A> {
    return Function<A>.addition(.variable(lhs), .constant(Double(rhs)))
}

let x_0: x = 1
let f = x.self + 2
f′
f[2]

/*
func + <A>(lhs: Variable<A>, rhs: Variable<A>) -> Expression<A> {
    return .addition(.variable(lhs), .variable(rhs))
}*/


/*
x_0 + 2

X.self + 2
*/
//: [Next](@next)
