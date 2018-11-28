import Foundation

protocol Counter {
	func increment()
	func decrement()
	func randomize()
	var value: Int { get }
}

class CounterImpl: Counter {
	private(set) var value: Int

	func increment() {
		value += 1
	}

	func decrement() {
		value -= 1
	}

	func randomize() {
		value = Int.random(min: -100, max: 100)
	}

	init(value: Int) {
		self.value = value
	}

	convenience init() {
		self.init(value: 0)
	}
}
