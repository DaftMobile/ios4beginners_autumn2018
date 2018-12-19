/*
* PokemonListTableViewController.swift
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

class PokemonListTableViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!

	// Model
	private(set) var pokemonList: [Pokemon] = []
	private var loader: PokemonLoading!

	override func viewDidLoad() {
		super.viewDidLoad()
		loader = PokemonAsyncLoader(deviceIdentifier: UIDevice.current.identifierForVendor!.uuidString)
		tableView.dataSource = self
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		loader.load { [weak self] (pokemonList) in
			guard let pokemonList = pokemonList else { return }
			self?.pokemonList = pokemonList
			self?.tableView.reloadData()
		}
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard segue.identifier == "showPokemonDetails" else { return }
		guard let cell = sender as? UITableViewCell,
			let destination = segue.destination as? PokemonDetailsViewController,
			let indexPath = tableView.indexPath(for: cell) else { return }

		tableView.deselectRow(at: indexPath, animated: true)
		destination.pokemonIndex = pokemonList[indexPath.row].number
	}
}

extension PokemonListTableViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return pokemonList.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath) as? PokemonTableViewCell else { fatalError("Invalid cell") }
		let index = indexPath.row
		let modelForCell = pokemonList[index]

		cell.pokemonNameLabel.text = "\(modelForCell.number): \(modelForCell.name)"
		cell.pokemonColorIndicatorView.backgroundColor = modelForCell.keyColor

		return cell
	}
}
