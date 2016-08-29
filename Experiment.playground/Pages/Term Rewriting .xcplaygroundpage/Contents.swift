//: [Previous](@previous)

import Foundation

protocol Node {
    var value: Double {get}
}

struct Sum: Node {
    var value: Double {
        return terms.map { $0.value }.reduce(0, +)
    }

    var terms: [Node]
}

struct Product: Node {
    var value: Double {
        return coefficients.map { $0.value }.reduce(0, *)
    }
    var coefficients: [Node]
}

struct Power: Node {
    var value: Double {
        return pow(base.value, exponent.value)
    }
    
    var base: Node
    var exponent: Node
}

struct Function: Node {
    let function: StandardFunction
    let inner: Node
    
    var value: Double {
        return function.evaluate(inner.value)
    }
}




/*
func aRule<X: Variable>(expression: Function<X>) -> Function<X>? {
    switch expression {
    case let .addition(a, b):
        return .addition(b, a)
    default:
        return nil
    }
}
*/
/*
let rules: [(Function<x>) -> Function<x>?] = [aRule]


precedencegroup A {
    lowerThan: AssignmentPrecedence, PowerPrecedence, AdditionPrecedence
}

infix operator <=> : A
infix operator => : A

/*
func <=> (lhs: (Function<x>) -> Function<x>, rhs: (Function<x>) -> Function<x>) -> Int {
    fatalError()
}
*/
func <=> (lhs: Function<x>, rhs: Function<x>) -> Int {
    fatalError()
}

func => (lhs: Function<x>, rhs: Function<x>) -> Int {
    fatalError()
}

let A = x.self * 1 <=> x.self

*/ 


//: [Next](@next)
