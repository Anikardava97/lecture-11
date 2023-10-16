//1

/*მოდით ჩვენს ხომალდს მივხედოთ SOLID Principle-ბის დაცვით.
 
 შევქმნათ Class-ი PirateShip⛴️🏴‍☠️, with properties: როგორციაა name, cannonsCount, crew👫 და cargo🍗🍖🥃🍺.
 Methods: firingCannons, adding/removing crew, adding/removing cargo.
 დავიცვათ Single Responsibility ამისათვის - cargo management და adding/removing crew ფუნქციონალი უნდა განვაცალკევოთ.
 შესაბამისად მოდი შევქმნათ 2 Manager class-ი (CargoManager, CrewManager), სადაც გავიტანთ crew-ს და cargo-ს და შესაბამის methods გავიტანთ ამ კლასებში.
 
 ამის შემდეგ ჩვენს PirateShip-ში გვრჩება properties: name, cannonsCount და 2 მენეჯერი რომელიც ცალ-ცალკე გააკონტროლებს ჩვენი გემის ფუნქციონალს. Methods გვექნება
 addCargo, removeCargo, listCargo, addCrew, removeCrew, listCrew, cannonCount, fireCannon(count:) და ამ Method-ებში ჩვენი მენეჯერების შესაბამისი მეთოდები გამოვიყენოთ.
 
 დავიცვათ Open/Closed პრინციპი. ჩვენი მენეჯერები არ უნდა იყოს წვდომადი გარედან და მათი ფუნქციონალის გამოყენება მხოლოდ გემის წევრებს უნდა შეეძლოთ.
 
 დავიცვათ Liskov Substituion, შევქმნათ PirateShip-ის შვილობილი კლასები Frigate და Galleon. დაამატეთ ფუნქციონალი და ცვლადები თქვენი სურვილის მიხედვით, მაგრამ როცა
 PirateShip-ს Frigate-ით ან Galleon-ით ამოვცვლით ქცევა არ უნდა შეგვეცვალოს.
 
 დავიცვათ Interface Segregation. ყველა გემს არ აქვს საშუალება რომ იქონიონ cannon-ები და აწარმოონ ბრძოლა. ამიტომ შევქმნათ protocol Cannons შესაბამისი მეთოდები და
 დავაიმპლემენტიროთ PirateShip-ში.
 
 დავიცვათ Dependency Inversion პრინციპი, ამიტომ ჩვენს manager კლასებს გავუკეთოთ პროტოკოლები CargoManaging და CrewManaging სადაც მეთოდებს ავღწერთ რომლებიც აქამდე კლასებში გვქონდა, ხოლო PirateShip-ში CargoManager-ს და CrewManager-ს ჩავანაცვლებთ ამ Protocol-ის ტიპის ცვლადებით, ამითი ჩვენს PirateShips აღარ ეცოდინება სპეციფიური დეტალები თუ როგორ ხდება cargo-ს და crew-ის მენეჯმენტი  მას მხოლოდ აბსტრაქტულად ეცოდინება ის რომ ეს შესაძლებელია. ასევე ამ პრინციპის დაცვით ჩვენ საშუალება გვექნება ნებისმიერ დროს შევცვალოთ Crew და Cargo Management-ის მართვის სისტემა, უბრალოდ ჩავაწვდით ახალ კლასს სხვა იმპლემენტაციით რომელიც ამ პროტოკოლს აიმპლემენტირებს, ამის საშვალებით ჩვენ ნებისმიერ დროს შეგვეძლება PirateShip-ში მარტივი ცვლილებების შეტანა, ისე რომ თვითონ კლასში ცვლილებების გაკეთება არ მოგვიწევს.
 */

protocol Cannons {
    func fireCannon(count: Int)
}

protocol CargoManaging {
    func addCargo(item: [String])
    func removeCargo(item: [String])
    func listCargo()
}

protocol CrewManaging {
    func addCrew(member: [String])
    func removeCrew(member: [String])
    func listCrew()
}

class CrewManager: CrewManaging {
    var crew: [String] = []
    
    func addCrew(member: [String]) {
        crew.append(contentsOf: member)
        print("🧌\(member) has been added to crew.")
    }
    
    func removeCrew(member: [String]) {
        for member in member {
            if let index = crew.firstIndex(of: member) {
                crew.remove(at: index)
                print("\(member) has been removed ❌")
            } else {
                print("\(member) is not in the crew.")
            }
        }
    }
    
    func listCrew() {
        print("Crew members: \(crew)")
    }
}

class CargoManager: CargoManaging {
    var cargo: [String] = []
    
    func addCargo(item: [String]) {
        cargo.append(contentsOf: item)
        print("🥃🚬🔪🍗\(item) has been added.")
    }
    
    func removeCargo(item: [String]) {
        for item in item {
            if let index = cargo.firstIndex(of: item) {
                cargo.remove(at: index)
                print("\(item) has been removed ❌")
            } else {
                print("\(item) is not in supply.")
            }
        }
    }
    func listCargo() {
        print("Cargo list: \(cargo)")
    }
}

class PirateShip: Cannons {
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
            print("⛴️ \(name) is firing canons🧨")
            cannonsCount -= 1
        } else {
            print("⛴️ \(name) has run out of cannons.")
        }
    }
    
    func addCrew(member: [String]) {
        crewManager.addCrew(member: member)
    }
    
    func removeCrew(member: [String]) {
        crewManager.removeCrew(member: member)
    }
    
    func listCrew() {
        crewManager.listCrew()
    }
    
    func addCargo(item: [String]) {
        cargoManager.addCargo(item: item)
    }
    
    func removeCargo(item: [String]) {
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

// ვერ ვხვდები, როგორ დავიცვა ---> "Open/Closed პრინციპი. ჩვენი მენეჯერები არ უნდა იყოს წვდომადი გარედან და მათი ფუნქციონალის გამოყენება მხოლოდ გემის წევრებს უნდა შეეძლოთ"

class Frigate: PirateShip {
    
    var shipType: String
    
    init(shipType: String, name: String, cannonsCount: Int, cargoManager: CargoManaging, crewManager: CrewManaging) {
        self.shipType = shipType
        super.init(name: name, cannonsCount: cannonsCount, cargoManager: cargoManager, crewManager: crewManager)
    }
}


class Galleon: PirateShip {
    
    var speed: Int
    
    init(speed: Int, name: String, cannonsCount: Int, cargoManager: CargoManaging, crewManager: CrewManaging) {
        self.speed = speed
        super.init(name: name, cannonsCount: cannonsCount, cargoManager: cargoManager, crewManager: crewManager)
    }
    
    func trading(with partner: PirateShip) {
        print("\(name) is trading with \(partner)")
    }
    
}

//2
/*
 TreasureMap KISS პრინციპის დაცვით.
 
 TreasureMap კლასი გვექნება ძალიან მარტივი ორი ფროფერთით: x და y ექნება. ერთი მეთოდი hintToTreasure, რომელიც მიიღებს x და y-ს და თუ ვიპოვეთ ჩვენი საგანძური
 დაგვიწერს ამას, თუ არასწორად მივუთითებთ კოორდინატებს მაშინ უნდა მოგვცეს hint-ი თუ საით უნდა წავიდეთ რომ მივაგნოთ საგანძურს.
 */

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
/*
 SeaAdventure YAGNI პრინციპის დაცვით, პირატების მოგზაურობა თავგადასავლის გარეშე ვის გაუგია
 
 შევქმნათ მარტივი SeaAdventure class-ი, ერთი String adventureType ფროფერთით და ერთი მეთოდით encounter რომელიც დაგვიბეჭდავს თუ რა adventure-ს წააწყდა ჩვენი ხომალდი.
 დავიცვათ YAGNI და არ დავამატოთ გავრცობილი ფუნქციონალი რომელიც სხვადასხვა adventure-ს შეიძლება მოიცავდეს, რომელიც ჯერ ჯერობით არ გვჭირდება.
 */

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
/*
 SeaAdventure YAGNI პრინციპის დაცვით, პირატების მოგზაურობა თავგადასავლის გარეშე ვის გაუგია
 
 შევქმნათ მარტივი SeaAdventure class-ი, ერთი String adventureType ფროფერთით და ერთი მეთოდით encounter რომელიც დაგვიბეჭდავს თუ რა adventure-ს წააწყდა ჩვენი ხომალდი.
 დავიცვათ YAGNI და არ დავამატოთ გავრცობილი ფუნქციონალი რომელიც სხვადასხვა adventure-ს შეიძლება მოიცავდეს, რომელიც ჯერ ჯერობით არ გვჭირდება.
 */

class PirateCode {
    
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

//5
/*
 დროა საგანძურის საძებნელად გავეშვათ. (Treasure hunting😄💰)
 
 შევქმნათ ჩვენი ხომალდი დავარქვათ სახელი, ეკიპაჟი დავამატოთ, საომრად გავამზადოთ, ავტვირთოთ cargo.
 
 შევქმნათ ჩვენი საგანძულის კარტა და გადავაწდოთ კოორდინატები.
 
 შევქმნათ პირატის კოდექსი რომელიც მოგზაურობისას დაგვეხმარება.
 
 შევქმნათ SeaAdventure რომელსაც ჩვენი ეკიპაჟი შეიძლება გადააწყდეს, ამ შემთხვევაში ეს იქნება FlyingDutchman-თან გადაყრა.
 
 პირველ რიგში დავიწყოთ ჩვენი საგანძურის ძებნით, შევქმნათ ორი ცვლადი საწყისი კოორდინატები საიდანაც ჩვენი გემი აიღებს გეზს, და treasureMap-ის hintToTreasure მეთოდის
 გამოყენებით ვეცადოთ ვიპოვოთ ჩვენი საგანძური.
 
 საგანძურის პოვნის შემდეგ გადააწყდება adventure-ს, დავბეჭდოთ რა adventure-ა, PirateCode-ს გამოყენებით გადავწყვიტოთ რას იზამს ჩვენი კაპიტანი, ეცდება აარიდოს თავი
 თავგადასავალს თუ მიხვდება რომ აზრი არ აქვს მოლაპარაკებებს და შეუტევს? არჩევის შემდეგ რის განხილვას მოახდენს თავის ეკიპაჟთან ერთად? როგორ გაიქცეს თუ როგორ შეუტიოს
 ეფექტურად? გამოიყენებს ის ყველა არსებულ cannon-ს ხომალდზე თუ არა?
 
 ამ რთულ გადაწყვეტილების მიღების შემდეგ ჩვენ უკვე ვეღარასდროს ვერ გავიგებთ თუ როგორ დამთავრდა ჩვენი კაპიტნის და მისი ეკიპაჟის ამბავი.😄
 */

let crewManager = CrewManager()
let cargoManager = CargoManager()
let pirateShip = PirateShip(name: "MOBY-DICK", cannonsCount: 20, cargoManager: cargoManager, crewManager: crewManager)

pirateShip.addCrew(member: ["Jim Morrison", "Janis Joplin", "Jimi Hendrix"])
pirateShip.addCargo(item: ["Rum", "Tobacco", "Weapons", "Food and Drink supply"])


class PiratesCodex {
    var rules: [String]
    
    init(rules: [String]) {
        self.rules = rules
    }
    
    func piratesCodex() {
        print("Pirates Codex 📜")
        for rule in rules {
            print(rule)
        }
    }
}

let piratesCodexRules = [
    "Any Man Who Falls Behind Is Left Behind",
    "Make Friends Wisely",
    "The Captain of a Ship is to be elected by a majority vote of its crew",
    "Keep a Weather Eye Open",
    "Keep the Ship Clean"
]

let piratesCodex = PiratesCodex(rules: piratesCodexRules)

let treasureMap = TreasureMap(x: 25.0, y: 35.0)
var currentX = 10.0
var currentY = 20.0

while true {
    treasureMap.hintToTreasure(providedX: currentX, providedY: currentY)
    
    if currentX == treasureMap.x && currentY == treasureMap.y {
        print("Congrats! Treasure is at coordinates (\(currentX), \(currentY))")
        break
    }
    
    if currentX > treasureMap.x {
        currentX -= 1.0
    } else {
        currentX += 1.0
    }
    
    if currentY > treasureMap.y {
        currentY -= 1.0
    } else {
        currentY += 1.0
    }
}

//Congrats! Treasure is at coordinates (25.0, 35.0) -- ამას ორჯერ მიბეჭდავს და ვერ ვხვდები რატო

let seaAdventure = SeaAdventure(adventureType: "Come across the Flying Dutchman.")
seaAdventure.encounter()

let pirateCode = PirateCode()
pirateCode.mutiny()

pirateShip.fireCannon(count: 5)

