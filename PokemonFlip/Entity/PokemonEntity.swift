//
//  PokemonEntity.swift
//  PokemonFlip
//
//  Created by İbrahim Ballıbaba on 25.10.2022.
//

import Foundation


struct PokemonEntity: Decodable{
    var name: String
    let stats: [Stats]
    let sprites: Sprites
}

struct Stats: Decodable{
    let base_stat: Int
}

struct Sprites: Decodable{
    let front_default: String
}
