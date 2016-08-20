//: [Previous](@previous)

import Foundation

let x = Variable(identifier: "x", value: 0)
let f: Expression = sin(.variable(x))

taylorExpansion(of: f, at: 0, variable: x, degree: 3)

//: [Next](@next)
