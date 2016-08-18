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

let renderer = LatexRenderer()
renderer.render(x / (2 + 3) + 3 *  π)

let a = 4.kg

//renderer.render(equation: p, label: "polynomial")

// Rydberg's formula
let λ = Variable(identifier: "λ", value: 5000)
let R = Variable(identifier: "R", value: 1.0973731569e7)
let n1 = Variable(identifier: "n_1", value: 2)
let n2 = Variable(identifier: "n_2", value: 3)

// TODO: Constraint to integers, solve for multiple variables and regression and stuff
// Note, this isn't perfect (missing paranthensis)
let rydbergsFormula = 1 / λ == R * (1 / n1 ** 2 - 1 / n2 ** 2)
let s = rydbergsFormula.solving(for: λ).rhs.value
//print(renderer.render(s))