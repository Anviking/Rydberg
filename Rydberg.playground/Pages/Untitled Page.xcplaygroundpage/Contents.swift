//: Playground - noun: a place where people can play

import Cocoa

let x = Variable(identifier: "x", value: 0)

let f = arctan(1 / x) + arctan(x)
f.derivative(withRespectTo: x)


//renderer.render(equation: p, label: "polynomial")






