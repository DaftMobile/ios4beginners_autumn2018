/*
* PokemonResolving.swift
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

import Foundation

protocol PokemonResolving {
	func `catch`(index: Int, completion: @escaping (Pokemon?, Data?) -> Void)
}

class PokemonResolver: PokemonResolving {

	private let loader: PokemonLoading

	init(deviceId: String) {
		self.loader = PokemonAsyncLoader(deviceIdentifier: deviceId)
	}

	func `catch`(index: Int, completion: @escaping (Pokemon?, Data?) -> Void) {
		loader.catch(index: index) { [weak self] pokemon -> Void in
			guard let `self` = self, let pokemon = pokemon else { completion(nil, nil); return }
			self.loader.image(index: index, completion: { data -> Void in
				guard let data = data else { completion(nil, nil); return }
				completion(pokemon, data)
			})
		}
	}
}
