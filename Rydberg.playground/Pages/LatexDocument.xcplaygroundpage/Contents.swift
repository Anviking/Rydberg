//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

let x = Variable(identifier: "x", value: 0)

var document = LatexDocument()

let f = arctan(1 / x) + arctan(x)
let f´ = f.derivative(withRespectTo: x)

document.append(f)

let v = SJLatexView(latex: document.latex, frame: CGRect(x: 0, y: 0, width: 300, height: 500))
XCPlaygroundPage.currentPage.liveView = v





