//: [Previous](@previous)

import Foundation

let x = Variable(identifier: "x", value: 0)

let f = x ** (2 - 0) + 0 * x ** 3 / 0
f.simplified()


//: [Next](@next)
