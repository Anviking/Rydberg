//: Playground - noun: a place where people can play

import Cocoa
import XCPlayground

var document = LatexDocument()

let x_0: x = 1
let f = arctan(1 / x.self) + arctan(x.self)
f′
f[2]


document.append(f)
print(f′.simplified().expanded.simplified())

let v = SJLatexView(latex: document.latex, frame: CGRect(x: 0, y: 0, width: 300, height: 500))
XCPlaygroundPage.currentPage.liveView = v
