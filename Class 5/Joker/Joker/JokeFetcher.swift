import Foundation

protocol JokeFetcher {
	func fetchNext(completion: @escaping (Joke?) -> Void)
}

class JokeFetcherImpl: JokeFetcher {
	let session: URLSession
	let deviceIdentifier: String

	private let jokeURL: URL = URL(string: "https://switter.app.daftmobile.com/api/joke")!

	init(deviceIdentifier: String) {
		session = URLSession(configuration: .ephemeral)
		self.deviceIdentifier = deviceIdentifier
	}

	func fetchNext(completion: @escaping (Joke?) -> Void) {
		let request = createNewJokeRequest()
		session.dataTask(with: request) { data, response, error in
			var joke: Joke? = nil
			defer { DispatchQueue.main.async { completion(joke) } }
			guard error == nil else { return }
			guard let data = data else { return }

			joke = try? JSONDecoder().decode(Joke.self, from: data)
		}.resume()
	}

	private func createNewJokeRequest() -> URLRequest {
		var request = URLRequest(url: jokeURL)
		request.addValue(deviceIdentifier, forHTTPHeaderField: "x-device-uuid")
		return request
	}
}
