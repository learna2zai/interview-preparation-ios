//: [Previous](@previous)

import Foundation

// MARK: - Automatic Reference Counting(ARC)

// ARC applies only to instances of classes.

// Unowned References and Implicitly Unwrapped Optional Properties

// A scenario, in which both properties should always have a value, and neither property should ever be nil once initialization is complete. In this scenario, it’s useful to combine an unowned property on one class with an implicitly unwrapped optional property on the other class.


class Country {
    let name: String
    var capital: City!
    
    init(name: String, capitalCityName: String) {
        self.name = name
        self.capital = City(name: capitalCityName, country: self)
    }
    
    deinit {
        print("Country deallocated")
    }
}


class City {
    let name: String
    unowned let country: Country
    
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
    
    deinit {
        print("City deallocated")
    }
}

var country: Country? = Country(name: "France", capitalCityName: "Paris")

country = nil

//: [Next](@next)
