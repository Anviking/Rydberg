//: Playground - noun: a place where people can play

import Cocoa
import XCPlayground

var document = LatexDocument()

let f = arctan(1 / x.self) + arctan(x.self)
f′
f[2]

let a = f′.simplified().expanded.simplified().eliminateEqualTerms().simplified()


print(a)
let b = print(a.parseSum())

let lhs: Function<x> = 2 * x.self / 2 + 2
let rhs: Function<x> = (x.self + 2)
let t = CFAbsoluteTimeGetCurrent()
lhs == rhs
CFAbsoluteTimeGetCurrent() - t

document.append(f)
document.append(a)

let v = SJLatexView(latex: document.latex, frame: CGRect(x: 0, y: 0, width: 300, height: 500))
XCPlaygroundPage.currentPage.liveView = v
