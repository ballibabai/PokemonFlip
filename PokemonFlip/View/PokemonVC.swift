//
//  PokemonVC.swift
//  PokemonFlip
//
//  Created by İbrahim Ballıbaba on 24.10.2022.
//

import UIKit
import Kingfisher

class PokemonVC: UIViewController {
    
    //MARK: - UI Elements
    @IBOutlet weak var changeFlipButton: UIButton!
    @IBOutlet weak var pokemonView: UIView!
    @IBOutlet weak var pokeNameLabel: UILabel!
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var pokeHpLabel: UILabel!
    @IBOutlet weak var pokeHpValueLabel: UILabel!
    @IBOutlet weak var pokeAttackLabel: UILabel!
    @IBOutlet weak var pokeAttackValueLabel: UILabel!
    @IBOutlet weak var pokeDefenseLabel: UILabel!
    @IBOutlet weak var pokeDefenseValueLabel: UILabel!
    
    //MARK: - Properties
    private let pokemonVMDelegate = PokemonViewModel()
    private var index = 0
    var isFlipped = false
    private var pokeNames: PokemonEntity?
//    private var pokeNames: PokemonEntity? {
//        didSet{
//            guard let pokeNames = pokeNames else {
//                return
//            }
//            pokeNameLabel.text = pokeNames.name.capitalized
//            let setURL = URL(string: pokeNames.sprites.front_default)
//            pokeImageView.kf.setImage(with: setURL)
//            pokeHpValueLabel.text = String(pokeNames.stats[0].base_stat)
//            pokeAttackValueLabel.text = String(pokeNames.stats[1].base_stat)
//            pokeDefenseValueLabel.text = String(pokeNames.stats[2].base_stat)
//        }
//    }

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        pokemonView.layer.cornerRadius = 8
        changeFlipButton.layer.cornerRadius = changeFlipButton.frame.width / 2
        changeFlipButton.layer.masksToBounds = true
        pokemonVMDelegate.pokemonVMDelegate = self
        
        pokeNameLabel.text = "Pikachu"
        let seturlll = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png")
        pokeImageView.kf.setImage(with: seturlll)
        pokeHpValueLabel.text = "35"
        pokeAttackValueLabel.text = "55"
        pokeDefenseValueLabel.text = "40"
    }
    
    //MARK: - Functions
    @IBAction func tappedNextNewPokemon(_ sender: UIButton) {
        index += 1
        pokemonVMDelegate.getNewPokemon(String(self.index))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            guard let self = self else {return}
            self.changePokemon()
        }
        flipCard()
    }
    
    func changePokemon(){
        pokeNameLabel.text = pokeNames!.name.capitalized
        let setURL = URL(string: pokeNames!.sprites.front_default)
        pokeImageView.kf.setImage(with: setURL)
        pokeHpValueLabel.text = String(pokeNames!.stats[0].base_stat)
        pokeAttackValueLabel.text = String(pokeNames!.stats[1].base_stat)
        pokeDefenseValueLabel.text = String(pokeNames!.stats[2].base_stat)
    }
}

//MARK: - Extensions
private extension PokemonVC {
    
    //animations for pokemonView
    func flipCard(){
           if isFlipped{
               UIView.transition(with: pokemonView, duration: 0.5, options: UIView.AnimationOptions.transitionFlipFromTop, animations: nil, completion: nil)
               self.isFlipped = false
           }else{
               UIView.transition(with: pokemonView, duration: 0.5, options: UIView.AnimationOptions.transitionFlipFromLeft, animations: nil, completion: nil)
               self.isFlipped = true
       }
    }
}

extension PokemonVC: PokemonVMProtocol {
    func pokeVMFunc(_ isSuccess: Bool) {
        if isSuccess{
            print("yessss data came")
        }
    }
    func getOnePoke(_ poke: PokemonEntity) {
        DispatchQueue.main.async {
            self.pokeNames = poke
        }
    }
}
