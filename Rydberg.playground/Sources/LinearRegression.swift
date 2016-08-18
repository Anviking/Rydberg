import Foundation

public typealias Point = (x: Double, y: Double)


// Mostly borrowed from https://github.com/raywenderlich/swift-algorithm-club/blob/master/Linear%20Regression/LinearRegression.playground/Contents.swift

public struct LinearRegression {
    
    /// The datapoints used to create this linear regression
    public let data: [Point]
    
    /// The k in `kx+m`
    public let slope: Double
    
    /// The m in `kx+m`
    public let intercept: Double
    
    /// A closure that returns kx+m given a x
    public let function: (Double) -> Double
    
    public init(data: [Point]) {
        self.data = data
        let x = data.lazy.map { $0.x }
        let y = data.lazy.map { $0.y }
        
        let sum1 = average(data.map { $0.x * $0.y }) - average(x) * average(y)
        let sum2 = average(data.map { $0.x * $0.x }) - pow(average(x), 2)
        
        slope = sum1 / sum2
        intercept = average(y) - slope * average(x)
        
        // Avoid references
        let k = slope
        let m = intercept
        function = { k * $0 + m }
    }
}

func average<C: Collection>(_ input: C) -> Double where C.Iterator.Element == Double, C.IndexDistance == Int {
    return input.reduce(0, +) / Double(input.count)
}
