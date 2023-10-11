import Foundation

class SuperEnemy {
    let name: String
    var hitPoints: Int
    
    init(name: String, hitPoints: Int) {
        self.name = name
        self.hitPoints = hitPoints
    }
}

extension SuperEnemy {
    func printEnemyInfo() {
        print("Enemy Name: \(self.name)")
        print("Hit Points: \(self.hitPoints)")
    }
}


protocol Superhero {
    var name: String { get }
    var alias: String { get }
    var isEvil: Bool { get }
    var superPowers: [String : Int] { get set }
    
    func attack(target: SuperEnemy) -> Int
    mutating func performSuperPower(target: SuperEnemy) -> Int
}

extension Superhero {
    func printSuperheroInfo() {
        print("Superhero Name: \(self.name)")
        print("Remaining Superpowers:")
        for (power, damage) in self.superPowers {
            print("\(power): \(damage)")
        }
    }
}

struct Komble: Superhero {
    let name: String
    let alias: String
    let isEvil: Bool
    var superPowers: [String : Int]
    
    func attack(target: SuperEnemy) -> Int {
        var basicAttack = Int.random(in: 20...40)
        target.hitPoints -= basicAttack
        return target.hitPoints
    }
    
    mutating func performSuperPower(target: SuperEnemy) -> Int {
        if !superPowers.isEmpty {
            if let (powerName, damage) = superPowers.randomElement() {
                target.hitPoints -= damage
                superPowers.removeValue(forKey: powerName)
                return target.hitPoints
            }
            
        }
        return attack(target: target)
    }
}

struct Nacarqeqia: Superhero {
    let name: String
    let alias: String
    let isEvil: Bool
    var superPowers: [String : Int]
    
    func attack(target: SuperEnemy) -> Int {
        var basicAttack = Int.random(in: 20...40)
        target.hitPoints -= basicAttack
        return target.hitPoints
    }
    
    mutating func performSuperPower(target: SuperEnemy) -> Int {
        if !superPowers.isEmpty {
            if let (powerName, damage) = superPowers.randomElement() {
                target.hitPoints -= damage
                superPowers.removeValue(forKey: powerName)
                return target.hitPoints
            }
            
        }
        return attack(target: target)
    }
}

struct Tsiqara: Superhero {
    let name: String
    let alias: String
    let isEvil: Bool
    var superPowers: [String : Int]
    
    func attack(target: SuperEnemy) -> Int {
        var basicAttack = Int.random(in: 20...40)
        target.hitPoints -= basicAttack
        return target.hitPoints
    }
    
    mutating func performSuperPower(target: SuperEnemy) -> Int {
        if !superPowers.isEmpty {
            if let (powerName, damage) = superPowers.randomElement() {
                target.hitPoints -= damage
                superPowers.removeValue(forKey: powerName)
                return target.hitPoints
            }
            
        }
        return attack(target: target)
    }
}

class SuperheroSquad<T: Superhero> {
    var superheroes: [T]
    
    init(superheroes: [T]) {
        self.superheroes = superheroes
    }
    
    func listSuperheroes()  {
        print("Superhero Squad:")
        for hero in superheroes {
            print(hero.name)
        }
    }
}

func simulateShowdown<T: Superhero>(squad: SuperheroSquad<T>, enemy: SuperEnemy) {
    while enemy.hitPoints > 0 && squad.superheroes.count > 0 {
        let randomHeroIndex = Int.random(in: 0..<squad.superheroes.count)
        var hero = squad.superheroes[randomHeroIndex]
        
        if !hero.superPowers.isEmpty {
            let remainingLife = hero.performSuperPower(target: enemy)
            print("\(hero.name) used a superpower against \(enemy.name). \(enemy.name)'s remaining life: \(remainingLife)")
        }
        
        if hero.superPowers.isEmpty {
            squad.superheroes.remove(at: randomHeroIndex)
            print("\(hero.name) has run out of superpowers.")
            let remainingLife = hero.attack(target: enemy)
            print("\(hero.name) made a normal attack against \(enemy.name). \(enemy.name)'s remaining life: \(remainingLife)")
        }
        
        if enemy.hitPoints <= 0 {
            print("\(enemy.name) has been defeated!")
        }
    }
    
    if enemy.hitPoints <= 0 {
        print("Superheroes win!")
    } else {
        print("Superheroes are out of superpowers. The enemy wins.")
    }
}


class AnySuperhero: Superhero {
    var base: Superhero
    
    init(_ superhero: Superhero) {
        self.base = superhero
    }
    
    var name: String {
        return base.name
    }
    
    var alias: String {
        return base.alias
    }
    
    var isEvil: Bool {
        return base.isEvil
    }
    
    var superPowers: [String: Int] {
        get {
            return base.superPowers
        }
        
        set {
            base.superPowers = newValue
        }
        
    }
    
    func attack(target: SuperEnemy) -> Int {
        return base.attack(target: target)
    }
    
    func performSuperPower(target: SuperEnemy) -> Int {
        return base.performSuperPower(target: target)
    }
}


let komble = Komble(name: "Komble", alias: "Georgian fairy tales ", isEvil: false, superPowers: ["kombali1": 20, "kombali2": 30])
let nacarqeqia = Nacarqeqia(name: "Nacarqeqia", alias: "Georgian fairy tales", isEvil: false, superPowers: ["yveli": 25, "chxiri": 35, "nacari" : 15])
let tsiqara = Tsiqara(name: "Tsiqara", alias: "Georgian fairy tales", isEvil: false, superPowers: ["qva": 40])
let squad = SuperheroSquad(superheroes: [AnySuperhero(komble), AnySuperhero(nacarqeqia), AnySuperhero(tsiqara)])
let enemy = SuperEnemy(name: "Devi", hitPoints: 190)

squad.listSuperheroes()
print("VS \(enemy.name) \n")
simulateShowdown(squad: squad, enemy: enemy)

