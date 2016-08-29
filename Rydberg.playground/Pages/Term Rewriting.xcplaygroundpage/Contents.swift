//: [Previous](@previous)

import Foundation

struct RewriteRule {
    let lhs: Expression
    let rhs: Expression
}

infix operator <=>

func <=> (lhs: (Variable) -> Expression, rhs: (Variable) -> Expression) -> RewriteRule {
    return RewriteRule(lhs: lhs, rhs: rhs)
}

_ = { $0 + 1 } <=> { $0 + 2 }



//: [Next](@next)
