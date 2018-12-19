/*
* PokemonDetailsViewController.swift
* Created by Kajetan Dąbrowski on 18/12/2018.
*
* iOS 4 Beginners 2018
* Copyright 2018 DaftMobile Sp. z o. o.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*    http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or  * implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

import UIKit

class PokemonDetailsViewController: UIViewController {

	@IBOutlet weak var pokemonNameLabel: UILabel!
	@IBOutlet weak var bottomLineView: UIView!
	@IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
	@IBOutlet weak var pokemonImageView: UIImageView!

	var loader: PokemonResolving!
	var pokemonIndex: Int?

	override func viewDidLoad() {
		super.viewDidLoad()
		loader =  PokemonResolver(deviceId: UIDevice.current.identifierForVendor!.uuidString)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		guard let index = pokemonIndex else { fatalError() }
		view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
		self.title = "\(index)"
		setLoadingInProgress(true)
		loader.catch(index: index) { [weak self] (pokemon, data) in
			self?.loadPokemon(pokemon: pokemon, image: data)
			self?.setLoadingInProgress(false)
		}
	}

	private func loadPokemon(pokemon: Pokemon?, image: Data?) {
		guard let pokemon = pokemon, let data = image, let image = UIImage(data: data) else { showError(); return }
		pokemonNameLabel.text = pokemon.name
		bottomLineView.backgroundColor = pokemon.keyColor.darkenColor()
		pokemonNameLabel.textColor = pokemon.keyColor.darkenColor()
		view.backgroundColor = pokemon.keyColor
		pokemonImageView.image = image
		pokemonImageView.tintColor = pokemon.keyColor.darkenColor()
	}

	private func showError() {
		pokemonNameLabel.text = "Unknown Pokemon"
		bottomLineView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
		pokemonNameLabel.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
		view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
	}

	private func setLoadingInProgress(_ inProgress: Bool) {
		pokemonImageView.alpha = inProgress ? 0 : 1
		pokemonNameLabel.alpha = inProgress ? 0 : 1
		bottomLineView.alpha = inProgress ? 0 : 1
		if inProgress { loadingActivityIndicator.startAnimating() }
		else { loadingActivityIndicator.stopAnimating() }
	}
}
