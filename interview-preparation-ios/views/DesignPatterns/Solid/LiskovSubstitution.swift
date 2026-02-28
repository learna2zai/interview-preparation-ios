//
//  LiskovSubstitution.swift
//  interview-preparation-ios
//
//  Created on 01/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation

struct LiskovSubstitution: SolidPrincipleProtocol {
    let title: String = "Liskov Substitution Principle"
    let description: String = "The Liskov Substitution Principle states that subclasses must be substitutable for their base classes without altering the correctness of the program."
    
    let problem: String = """
        // MARK: - Liskov Substitue

        protocol Vehicle {
            func refuel()
            func move()
        }

        class ElectricVehicle: Vehicle {
            func refuel() {
                print("Refueling electric vehicle")
            }
            
            func move() {
                print("Moving electric vehicle")
            }
        }

        class PetrolVehicle: Vehicle {
            func refuel() {
                print("Refueling petrol vehicle")
            }
            
            func move() {
                print("Moving petrol vehicle")
            }
        }

        // service station
        
        func serviceVehicle(_ vehicle: Vehicle) {
            vehicle.refuel()
            vehicle.move()
        }
        
        /// voilates LSP rules
        """
    
    let resolution: String = """
        protocol Vehicle {
            func move()
        }

        protocol FuelVehicle: Vehicle {
            func refuel()
        }

        protocol EVehicle: Vehicle {
            func recharge()
        }

        class PetrolCar: FuelVehicle {
            func refuel() {
                print("Refueling petrol car")
            }
            
            func move() {
                print("Moving petrol car")
            }
        }

        class EVVehicle: EVehicle {
            func recharge() {
                print("Charge vehicale")
            }
            
            func move() {
                print("Moving EV car")
            }
        }

        // service stations

        func servicePetrolCar(_ car: PetrolCar) {
            car.refuel()
            car.move()
        }

        func serviceEVVehicle(_ evCar: EVehicle) {
            evCar.recharge()
            evCar.move()
        }
        """
}
