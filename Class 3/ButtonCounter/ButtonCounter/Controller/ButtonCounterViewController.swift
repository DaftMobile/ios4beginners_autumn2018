import UIKit

class ButtonCounterViewController: UIViewController {

	// MARK: - Views
	@IBOutlet weak var counterLabel: UILabel!

	// MARK: - Model
	let counter: Counter = CounterImpl()

	override func viewDidLoad() {
		super.viewDidLoad()
		counterLabel.font = UIFont.monospacedDigitSystemFont(ofSize: counterLabel.font.pointSize, weight: .bold)
		setupGestureRecognizer()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		updateLabel()
	}

	@objc func randomizeCounter() {
		counter.randomize()
		updateLabel()
	}

	@IBAction func incrementButtonPressed(_ sender: UIButton) {
		counter.increment()
		updateLabel()
	}

	@IBAction func decrementButtonPressed(_ sender: UIButton) {
		counter.decrement()
		updateLabel()
	}

	private func setupGestureRecognizer() {
		let tap = UITapGestureRecognizer(target: self, action: #selector(randomizeCounter))
		tap.numberOfTapsRequired = 3
		counterLabel.addGestureRecognizer(tap)
	}

	private func updateLabel() {
		counterLabel.text = "\(counter.value)"
	}
}
