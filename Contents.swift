

//1

protocol Cannons {
    func fireCannon(count: Int)
}

protocol CargoManaging {
    func addCargo(item: String)
    func removeCargo(item: String)
    func listCargo()
}

protocol CrewManaging {
    func addCrew(member: String)
    func removeCrew(member: String)
    func listCrew()
}

class CrewManager: CrewManaging {
    var crew: [String] = []
    
    func addCrew(member: String) {
        crew.append(member)
        print("New member -🧌\(member) has been added to crew.")
    }
    
    func removeCrew(member: String) {
        if let index = crew.firstIndex(of: member) {
            crew.remove(at: index)
            print("\(member) has been removed ❌")
        } else {
            print("\(member) is not in the crew.")
        }
    }
    
    func listCrew() {
        print("Crew members: \(crew)")
    }
}

class CargoManager: CargoManaging {
    var cargo: [String] = []
    
    func addCargo(item: String) {
        cargo.append(item)
        print("New cargo -🥃\(item) has been added.")
    }
    
    func removeCargo(item: String) {
        if let index = cargo.firstIndex(of: item) {
            cargo.remove(at: index)
            print("\(item) has been removed ❌")
        } else {
            print("\(item) is not in supply.")
        }
    }
    func listCargo() {
        print("Cargo list: \(cargo)")
    }
}

class PirateShip: Cannons, CrewManaging, CargoManaging {
    let name: String
    var cannonsCount: Int

    var cargoManager: CargoManaging
    var crewManager: CrewManaging
    
    init(name: String, cannonsCount: Int, cargoManager: CargoManaging, crewManager: CrewManaging) {
        self.name = name
        self.cannonsCount = cannonsCount
        self.cargoManager = cargoManager
        self.crewManager = crewManager
    }
    
    func firingCannons() {
        if cannonsCount > 0 {
            print("⛴️\(name) is firing canons🧨")
            cannonsCount -= 1
        } else {
            print("⛴️\(name) has run out of cannons.")
        }
    }
    
    func addCrew(member: String) {
            crewManager.addCrew(member: member)
        }

        func removeCrew(member: String) {
            crewManager.removeCrew(member: member)
        }

        func listCrew() {
            crewManager.listCrew()
        }

        func addCargo(item: String) {
            cargoManager.addCargo(item: item)
        }

        func removeCargo(item: String) {
            cargoManager.removeCargo(item: item)
        }
        
        func listCargo() {
            cargoManager.listCargo()
        }

        func cannonCount() -> Int {
            return cannonsCount
        }

        func fireCannon(count: Int) {
        firingCannons()
        }
    }

//2

class TreasureMap {
    let x: Double
    let y: Double
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
    
    func hintToTreasure(providedX: Double, providedY: Double) {
        if providedX == x && providedY == y {
            print("Congrats! Treasure is at coordinates (\(x), \(y))")
        } else {
            print("Treasure is not present. Follow this hint:")
            
            if providedX > x {
                print("Go West")
            } else {
                print("Go East")
            }
            
            if providedY > y {
                print("Go North")
            } else {
                print("Go South")
            }
        }
    }
}

//3

class SeaAdventure {
    let adventureType: String
    
    init(adventureType: String) {
        self.adventureType = adventureType
    }
    
    func encounter () {
        print("Experiencing sea adventure - \(adventureType)")
    }
}

//4

class pirateCode {
    
    private func discussTerms(term: String) {
        print("Discussing terms - \(term)")
    }
    
    func parley() {
        discussTerms(term: "Parley")
        print("Result - Agree to terms.")
    }
    
    func mutiny() {
        discussTerms(term: "Mutiny")
        print("Result - Start Conflict.")
    }
}
