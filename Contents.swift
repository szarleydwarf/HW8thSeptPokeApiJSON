import Foundation

let pokemonURLString = "https://pokeapi.co/api/v2/pokemon/5/"

struct Abilities : Decodable {
    let name:String
    
    enum CodingKeys: String, CodingKey {
        case ability
    }
    
    enum AbilityCodingKeys: String, CodingKey {
        case name
    }
    init(from decoder: Decoder) throws {
        let container =  try decoder.container(keyedBy: CodingKeys.self)
        let nestedContainer = try container.nestedContainer(keyedBy: AbilityCodingKeys.self, forKey: .ability)
        
        self.name = try nestedContainer.decode(String.self, forKey: .name)
    }
}

struct Forms: Decodable {
    let name:String
    enum CodingKeys: String, CodingKey {
        case name
    }
}

struct GameIndices: Decodable {
    let name:String
    
    enum CodingKeys:String, CodingKey {
        case version
    }
    
    enum GameIndicesCodingKeys: String, CodingKey {
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container =  try decoder.container(keyedBy: CodingKeys.self)
        let nestedContainer = try container.nestedContainer(keyedBy: GameIndicesCodingKeys.self, forKey: .version)
        
        self.name = try nestedContainer.decode(String.self, forKey: .name)
    }
}

struct Moves: Decodable {
    let name:String
    
    enum CodingKeys:String, CodingKey {
        case move
    }
    
    enum MoveCodingKeys: String, CodingKey {
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container =  try decoder.container(keyedBy: CodingKeys.self)
        let nestedContainer = try container.nestedContainer(keyedBy: MoveCodingKeys.self, forKey: .move)
        
        self.name = try nestedContainer.decode(String.self, forKey: .name)
    }
}

struct Stats: Decodable {
    let name:String
    
    enum CodingKeys:String, CodingKey {
        case stat
    }
    
    enum StatsCodingKeys: String, CodingKey {
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container =  try decoder.container(keyedBy: CodingKeys.self)
        let nestedContainer = try container.nestedContainer(keyedBy: StatsCodingKeys.self, forKey: .stat)
        
        self.name = try nestedContainer.decode(String.self, forKey: .name)
    }
}

struct Types: Decodable {
    let name:String

    enum CodingKeys:String, CodingKey {
        case type
    }

    enum TypesCodingKeys: String, CodingKey {
        case name
    }

    init(from decoder: Decoder) throws {
        let container =  try decoder.container(keyedBy: CodingKeys.self)
        let nestedContainer = try container.nestedContainer(keyedBy: TypesCodingKeys.self, forKey: .type)

        self.name = try nestedContainer.decode(String.self, forKey: .name)
    }
}



struct Pokemon : Decodable{
    let id:Int
    let name:String
    let baseExperience: Int
    let height: Int
    let weight: Int
    let abilities:[Abilities]
    let forms:[Forms]
    let gameIndices:[GameIndices]
    let moves:[Moves]
    let stats:[Stats]
    let types:[Types]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case baseExperience = "base_experience"
        case height
        case weight
        case abilities
        case forms
        case gameIndices = "game_indices"
        case moves
        case stats
        case types
    }
    
    func printMe() -> String {
        let typesArray:[String] = self.types.map{$0.name}
        let typeString:String = typesArray.joined(separator: ", ")
        
        let abilitiesArray: [String] = self.abilities.map{$0.name}
        let abilitiesString: String = abilitiesArray.joined(separator:", ")
        
        let formsArray: [String] = self.forms.map{$0.name}
        let formsString: String = formsArray.joined(separator:", ")
        
        let gameIndicesArray: [String] = self.gameIndices.map{$0.name}
        let gameIndicesString: String = gameIndicesArray.joined(separator:", ")
        
        let movesArray: [String] = self.moves.map{$0.name}
        let movesString: String = movesArray.joined(separator:", ")
        
        let statsArray: [String] = self.stats.map{$0.name}
        let statsString: String = statsArray.joined(separator:", ")
        
        return "This is me. ID-> \(self.id); NAME-> \(name); BASE EXPERIENCE-> \(baseExperience); HEIGHT-> \(height); WEIGHT-> \(weight); TYPE-> \(typeString); FORMS-> \(formsString);  ABILITIES-> \(abilitiesString); STATS-> \(statsString); GAME INDICES-> \(gameIndicesString); MOVES-> \(movesString);"
    }
}

if let pokemonURL = URL(string: pokemonURLString) {
    URLSession.shared.dataTask(with: pokemonURL) { (data, respons, error) in
        guard let data = data else {return}
        let pokemon = try? JSONDecoder().decode(Pokemon.self, from: data)
        
        print("pokemon-> \(pokemon?.printMe())")
    }.resume()
}
