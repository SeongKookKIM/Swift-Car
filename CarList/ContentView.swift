//
//  ContentView.swift
//  CarList
//
//  Created by SeongKook on 4/16/24.
//

import SwiftUI

protocol Fuel {
    var fuelEfficiency: Double { get set } // 연비
    var isGasoline: Bool { get set } // 가솔린일까 디젤일까
    var fuelEfficiencyString: String { get }
    var isGasolineString: String { get }
}
protocol Electric {
    var autoLevel: Int { set get }
}

class Car: Identifiable {
    let id = UUID()
    var brand: String
    var modelName: String
    var year: Int
    var doorCount: Int
    var weight: Double
    var height: Double
    
    init(brand: String, modelName: String, year: Int, doorCount: Int,
         weight: Double, height: Double) {
        self.brand = brand
        self.modelName = modelName
        self.year = year
        self.doorCount = doorCount
        self.weight = weight
        self.height = height
    }
}

class ElectricCar: Car, Electric {
    var electricEfficiency: Double
    var fullChargeHours: Double
    var autoLevel: Int
    
    init(brand: String, modelName: String, year: Int, doorCount: Int, weight: Double, height: Double,
         electricEfficiency: Double, fullChargeHours: Double, autoLevel: Int) {
        self.electricEfficiency = electricEfficiency
        self.fullChargeHours = fullChargeHours
        self.autoLevel = autoLevel
        super.init(brand: brand, modelName: modelName, year: year, doorCount: doorCount,
                   weight: weight, height: height)
    }
}

class OilCar: Car, Fuel{
    var isAutomatic: Bool
    var fuelEfficiency: Double
    var isGasoline: Bool
    
    init(brand: String, modelName: String, year: Int, doorCount: Int, weight: Double, height: Double,
         isAutomatic: Bool, fuelEfficiency: Double, isGasoline: Bool) {
        self.isAutomatic = isAutomatic
        self.fuelEfficiency = fuelEfficiency
        self.isGasoline = isGasoline
        super.init(brand: brand, modelName: modelName, year: year, doorCount: doorCount, weight: weight, height: height)
        
    }
}

class HybridCar: Car, Electric, Fuel {
    var fuelEfficiency: Double
    var isGasoline: Bool
    var autoLevel: Int
    
    init(brand: String, modelName: String, year: Int, doorCount: Int, weight: Double, height: Double,
         fuelEfficiency: Double, isGasoline: Bool, autoLevel: Int) {
        self.fuelEfficiency = fuelEfficiency
        self.isGasoline = isGasoline
        self.autoLevel = autoLevel
        super.init(brand: brand, modelName: modelName, year: year, doorCount: doorCount, weight: weight, height: height)
    }
}

extension Fuel {
    var fuelEfficiencyString: String {
        String(format: "%.2f"
               
               , fuelEfficiency)
        
    }
    var isGasolineString: String {
        isGasoline ? "가솔린" : "디젤"
    }
}


let teslaModelX: ElectricCar = ElectricCar(brand: "Tesla", modelName: "Model X", year: 2015, doorCount: 4, weight: 100, height: 40, electricEfficiency: 439, fullChargeHours: 5, autoLevel: 2)
let teslaModelY: ElectricCar = ElectricCar(brand: "Tesla", modelName: "Model Y", year: 2015, doorCount: 4, weight: 100, height: 40, electricEfficiency: 511 , fullChargeHours: 7, autoLevel: 3)
let kiaK9: OilCar = OilCar(brand: "KIA", modelName: "K9", year: 2022, doorCount: 4, weight: 70, height: 35, isAutomatic: true, fuelEfficiency: 9.0, isGasoline: true)
let kiaK8: OilCar = OilCar(brand: "KIA", modelName: "K8", year: 2023, doorCount: 4, weight: 70, height: 35, isAutomatic: true, fuelEfficiency: 18.0, isGasoline: true)
let kiaK5: OilCar = OilCar(brand: "KIA", modelName: "K5", year: 2023, doorCount: 4, weight: 70, height: 35, isAutomatic: true, fuelEfficiency: 20.0, isGasoline: true)
let prius: HybridCar = HybridCar(brand: "Toyota", modelName: "Prius", year: 2023, doorCount: 4, weight: 60, height: 40, fuelEfficiency: 65, isGasoline: true, autoLevel: 0)
let grandeurHybrid: HybridCar = HybridCar(brand: "Hyundai", modelName: "그렌저 하이브리드", year: 2023, doorCount: 4, weight: 70, height: 35, fuelEfficiency: 16.7, isGasoline: true, autoLevel: 1)

let cars: [Car] = [teslaModelX, teslaModelY, kiaK9, kiaK8, kiaK5, prius, grandeurHybrid ]

struct ContentView: View {
    
    var body: some View {
        NavigationStack{
            List {
                Section(header: Text("Electric Cars")){
                    ForEach(cars.filter {$0 is ElectricCar}, id: \.id){ car in
                        NavigationLink(destination: ElectricCarView(electricCar: car as! ElectricCar)) {
                            Text(car.modelName)
                        }
                    }
                    
                }
                Section(header: Text("Oil Cars")){
                    ForEach(cars.filter {$0 is OilCar}, id: \.id){ car in
                        NavigationLink(destination: OilCarView(oilCar: car as! OilCar)) {
                            Text(car.modelName)
                        }
                    }
                }
                Section(header: Text("Hybrid Cars")){
                    ForEach(cars.filter {$0 is HybridCar}, id: \.id){ car in
                        NavigationLink(destination: HybridCarView(hybridCar: car as! HybridCar)) {
                            Text(car.modelName)
                        }
                    }
                }
                
            }
            
        }
        .padding()
    }
}

struct ElectricCarView: View {
    var electricCar: ElectricCar
    
    var body: some View {
        VStack {
            Text("Brand: \(electricCar.brand)")
            Text("Model: \(electricCar.modelName)")
            Text("Year: \(electricCar.year)")
            Text("DoorCount: \(electricCar.doorCount)")
            Text("Weight: \(electricCar.weight)")
            Text("Height: \(electricCar.height)")
            Text("ElectricEfficiency: \(electricCar.electricEfficiency)")
            Text("FullChargeHours: \(electricCar.fullChargeHours)")
            Text("AutoLevel: \(electricCar.autoLevel)")
        }
    }
}

struct OilCarView: View {
    var oilCar: OilCar
    
    var body: some View {
        VStack {
            Text("Brand: \(oilCar.brand)")
            Text("Model: \(oilCar.modelName)")
            Text("Year: \(oilCar.year)")
            Text("DoorCount: \(oilCar.doorCount)")
            Text("Weight: \(oilCar.weight)")
            Text("Height: \(oilCar.height)")
            Text("IsAutomatic: \(oilCar.isAutomatic)")
            Text("FuelEfficiency: \(oilCar.fuelEfficiency)")
            Text("IsGasoline: \(oilCar.isGasoline)")
        }
    }
}

struct HybridCarView: View {
    var hybridCar: HybridCar
    
    var body: some View {
        VStack {
            Text("Brand: \(hybridCar.brand)")
            Text("Model: \(hybridCar.modelName)")
            Text("Year: \(hybridCar.year)")
            Text("DoorCount: \(hybridCar.doorCount)")
            Text("Weight: \(hybridCar.weight)")
            Text("Height: \(hybridCar.height)")
            Text("FuelEfficiency: \(hybridCar.fuelEfficiency)")
            Text("IsGasoline: \(hybridCar.isGasoline)")
            Text("AutoLevel: \(hybridCar.autoLevel)")
        }
    }
}

#Preview {
    ContentView()
}
