#!/usr/bin/swift

struct Overload {
    let lhs: String
    let rhs: String
    let body: String
}

var types: [(String, (String) -> String)] = [
     ("Double", { ".constant(\($0))" }),
     ("Int", { ".constant(Double(\($0)))" }),
     ("A.Type", { ".variable(\($0))" }), 
     ("Function<A>", { $0 })
]

// http://stackoverflow.com/questions/25162500/apple-swift-generate-combinations-with-repetition
func combos<T>(_ array: Array<T>, _ k: Int) -> Array<Array<T>> {

    var array = array

    if k == 0 {
        return [[]]
    }

    if array.isEmpty {
        return []
    }

    let head = [array[0]]
    let subcombos = combos(array, k - 1)
    var ret = subcombos.map {head + $0}

    array.remove(at: 0)
    ret += combos(array, k)
    
    return ret
}



func generateOverload(symbol:String, expression: (String, String) -> String, types: [(String, (String) -> String)]) -> String {
    let lhs = types[0]
    let rhs = types[1]

    let decl = "public func \(symbol) <A: Variable>(lhs: \(lhs.0), rhs: \(rhs.0)) -> Function<A>"

    let a = lhs.1("lhs")
    let b = rhs.1("rhs")

    let body = "    return \(expression(a, b))"
    return "\(decl) {\n\(body)\n}\n"
}


let operators: [(String, (String, String) -> String)] = [
    ("+", { ".addition(\($0), \($1))" }),
    ("-", { ".subtraction(\($0), \($1))" }),
    ("*", { ".multiplication(\($0), \($1))" }),
    ("/", { ".division(\($0), \($1))" }),
    ("**", { ".power(base: \($0), exponent: \($1))" })
]

var typeCombinations = combos(types, 2).filter { (array: [(String, (String) -> String)]) -> Bool in
    switch (array[0].0, array[1].0) {
        case ("Double", "Int"): return false
        case ("Int", "Double"): return false
        case ("Int", "Int"): return false
        case ("Double", "Double"): return false
        default: return true
    }
}.flatMap {
    // Reverse
    ($0[0].0 == $0[1].0) ? [$0] : [$0, $0.reversed()]
}

let result = operators.flatMap { s, e in 
    typeCombinations.map { 
        generateOverload(symbol: s, expression: e, types: $0) 
    }
}

print("// Score: \(result.count) overloads\n")
print(result.joined(separator: "\n"))

