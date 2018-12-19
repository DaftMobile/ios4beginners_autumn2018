/*
* PokemonLoader.swift
* Created by Kajetan Dąbrowski on 04/12/2018.
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

protocol PokemonLoading {
	func load(completion: @escaping ([Pokemon]?) -> Void)
	func peek(index: Int, completion: @escaping (Pokemon?) -> Void)
	func image(index: Int, completion: @escaping (Data?) -> Void)
	func `catch`(index: Int, completion: @escaping (Pokemon?) -> Void)
}

extension URLSession {
	func dataTask(request: URLRequest, completion: @escaping (Data?) -> Void) {
		var data: Data?
		self.dataTask(with: request) { data, response, error in
			defer {
				DispatchQueue.main.async {
					completion(data)
				}
			}

			guard error == nil else { print(error!); return }
			guard let status = (response as? HTTPURLResponse)?.statusCode else { print("Invalid response!"); return }
			guard 200..<300 ~= status else { print("Invalid status \(status) at \(request.url!)"); return }
		}.resume()
	}

	func dataTask<T>(request: URLRequest, completion: @escaping(T?) -> Void, transform: @escaping (Data) -> T?) {
		self.dataTask(request: request) { (data) in
			guard let data = data else { completion(nil); return }
			completion(transform(data))
		}
	}
}

class PokemonAsyncLoader: PokemonLoading {

	private let session: URLSession
	private let deviceIdentifier: String

	init(deviceIdentifier: String) {
		session = URLSession(configuration: .ephemeral)
		self.deviceIdentifier = deviceIdentifier
	}

	func load(completion: @escaping ([Pokemon]?) -> Void) {
		session.dataTask(request: request(url: getAllURL()), completion: completion) { (data) -> [Pokemon]? in
			return try? JSONDecoder().decode([Pokemon].self, from: data)
		}
	}

	func peek(index: Int, completion: @escaping (Pokemon?) -> Void) {
		session.dataTask(request: request(url: peekUrl(index: index)), completion: completion) { (data) -> Pokemon? in
			return try? JSONDecoder().decode(Pokemon.self, from: data)
		}
	}

	func image(index: Int, completion: @escaping (Data?) -> Void) {
		session.dataTask(request: request(url: imageUrl(index: index)), completion: completion)
	}

	func `catch`(index: Int, completion: @escaping (Pokemon?) -> Void) {
		session.dataTask(request: postRequest(url: catchUrl(index: index)), completion: completion) { (data) -> Pokemon? in
			return try? JSONDecoder().decode(Pokemon.self, from: data)
		}

	}

	private func request(url: URL) -> URLRequest {
		var request = URLRequest(url: url)
		request.addValue(deviceIdentifier, forHTTPHeaderField: "x-device-uuid")
		return request
	}

	private func postRequest(url: URL) -> URLRequest {
		var request = self.request(url: url)
		request.httpMethod = "POST"
		return request
	}

	private func peekUrl(index: Int) -> URL {
		return URL(string: "https://switter.app.daftmobile.com/api/pokemon/\(index)/peek")!
	}

	private func catchUrl(index: Int) -> URL {
		return URL(string: "https://switter.app.daftmobile.com/api/pokemon/\(index)/catch")!
	}

	private func getAllURL() -> URL {
		return URL(string: "https://switter.app.daftmobile.com/api/pokemon")!
	}

	private func imageUrl(index: Int) -> URL {
		return URL(string: "https://switter.app.daftmobile.com/api/pokemon/\(index)/image")!
	}
}
