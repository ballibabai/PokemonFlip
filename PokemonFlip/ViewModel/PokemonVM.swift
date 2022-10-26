//
//  PokemonVM.swift
//  PokemonFlip
//
//  Created by İbrahim Ballıbaba on 25.10.2022.
//

import Foundation

protocol PokemonVMProtocol: AnyObject {
    func pokeVMFunc(_ isSuccess: Bool)
    func getOnePoke(_ poke: PokemonEntity)
}

final class PokemonViewModel {
    weak var pokemonVMDelegate: PokemonVMProtocol?
    private let pokemonApiCall = PokemonApiCall()
    
    init(){
        pokemonApiCall.getPokemonDelegate = self
    }
    
    func getNewPokemon(_ urlCount: String){
        pokemonApiCall.getOneePokemon(withURL: urlCount)
    }
}

//MARK: - Extension
extension PokemonViewModel: PokemonApiCallProtocol {
    func getPokemon(_ isSuccess: Bool) {
        if isSuccess{
            let poke = pokemonApiCall.pokemon
            pokemonVMDelegate?.getOnePoke(poke!)
            pokemonVMDelegate?.pokeVMFunc(true)
        }else{
            print("errorr VM")
            pokemonVMDelegate?.pokeVMFunc(false)
        }
    }
}
