//
//  PokemonApiCall.swift
//  PokemonFlip
//
//  Created by İbrahim Ballıbaba on 25.10.2022.
//

import Foundation
import Alamofire

protocol PokemonApiCallProtocol:AnyObject {
    func getPokemon(_ isSuccess: Bool)
}

final class PokemonApiCall {
    
    weak var getPokemonDelegate: PokemonApiCallProtocol?
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    var pokemon: PokemonEntity?
        
    //with alamofire
    func getOneePokemon(withURL urlCount : String){
        let requestURL = baseURL.appendingPathComponent(urlCount) //add to last /.
        let request = URLRequest(url: requestURL)
        AF.request(request).response {[weak self ] response in
            guard let self = self else {return}
            
            guard let data = response.data else { return }
            do {
                let pokemon = try JSONDecoder().decode(PokemonEntity.self, from: data)
                self.pokemon = pokemon //if i dont write this line again code success cuz i dont use this self.pokemon
                self.getPokemonDelegate?.getPokemon(true)
            } catch {
                print("Error decoding Pokemon: \(error)")
                self.getPokemonDelegate?.getPokemon(true)
                return
            }
            
        }
    }
}
