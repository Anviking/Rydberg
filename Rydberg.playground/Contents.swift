//: Playground - noun: a place where people can play

import Cocoa

let x = Variable(identifier: "x", value: 3)
let ƒ: Expression = 1 + 3 * sin((2 * x))
let ƒ´ = ƒ.derive(withRespectTo: x)
ƒ´.value

let g: Expression = 2 * x + 3

let y = Variable(identifier: "y", value: 3)

let p: Expression = 4 * x ** 3 + 2 * x ** 2 - 4 * x + 1

var eq = Equation(lhs: .variable(y), rhs: g)
eq.solve(for: x)
eq.solve(for: y)
eq.lhs.derive(withRespectTo: x)

let π = Expression.variable(Variable(identifier: "π", value: M_PI))

LatexRenderer().render(expression: x / (2 + 3) + 3 * π)

let a = 4.kg
