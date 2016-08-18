import Foundation

extension Double {
    public var g: Measurement<UnitMass> {
        return Measurement(value: self, unit: .grams)
    }
    
    public var kg: Measurement<UnitMass> {
        return Measurement(value: self, unit: .kilograms)
    }
}

extension Int {
    public var g: Measurement<UnitMass> {
        return Measurement(value: Double(self), unit: .grams)
    }
    
    public var kg: Measurement<UnitMass> {
        return Measurement(value: Double(self), unit: .kilograms)
    }
}
