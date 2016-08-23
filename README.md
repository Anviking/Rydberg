# Rydberg
An experiment to see if Swift can help with writing physics lab reports. Still at a conceptual level.

![image](http://imgur.com/download/ilo046h)

## Motivation
Managing complicated calculations in Python as well as updating the results in your paper can be very challanging.

### Implemented features
- Create expressions using operator overloads in a type safe way

### Partially implemented features
- Deriving expressions using common derivation rules
- Solve simple equations
- Render expressions as `LaTeX`

### Todo
### Possible move towards using *types* as generic variables instead of instances
As seen in `Experiment.playground` you could do this:
```swift
let f = sin(x.self) // type is Function<x>
f[0] // 0
f´ // Function<x> = cos(x)
```
The requirement to call `.self` to reference the type will perhaps go away in future Swift versions, so this is perhaps not as crazy as it initially seems.

How this scales to multi-variable expressions and equation systems I don't know.

### Other
- Plot equations automatically in an appropriate interval if derivatives can be found.
- Better `LaTeX` support
- Linear Regressions etc.
- Measurements with uncertainties (preferably inferred based on significant digits)
- Better Unit system
- Leverage type system if possible
- More algebraeic functionality
- MathJax?
