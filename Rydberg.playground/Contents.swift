//: Playground - noun: a place where people can play

import Cocoa

let x = Variable(identifier: "x", value: 3)
let ƒ: Expression = 1 + 3 * sin((2 * x))
let ƒ´ = ƒ.derivative(withRespectTo: x)
ƒ´.value

let g: Expression = x ** 2 + 1
g.derivative(ofDegree: 2, withRespectTo: x)
let y = Variable(identifier: "y", value: 3)

let p: Expression = 4 * x ** 3 + 2 * x ** 2 - 4 * x + 1

var eq = Equation(lhs: .variable(y), rhs: g)
eq.solve(for: x)
eq.solve(for: y)
eq.lhs.derivative(withRespectTo: x)

let π = Expression.variable(Variable(identifier: "π", value: M_PI))

let renderer = LatexRenderer()
renderer.render(x / (2 + 3) + 3 *  π)

let a = 4

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

(x ** -1).derivative(withRespectTo: x)

let data: [(Double, Double?)] = [
    (-22.2547, nil),
    (-46.5711, nil),
    (-68.5552, 5790.663),
    (-69.7995, 5769.598),
    (-88.2639, 5460.735),
    (-110.6789, 5085.822),
    (-127.7708, 4799.912),
    (-135.0529, 4678.149),
    (-154.1858,	4358.328),
    (-155.2243,	nil),
    (-172.8485,	nil),
    (-195.8549,	nil),
    (-196.3301,	nil),
    (-196.6079,	nil)
]

// Filter data
let calibrationData = data.flatMap { (x, y) in y.map { (x: x, y: $0) }}

let curve = LinearRegression(data: calibrationData).function
data.map { curve($0.0) }
