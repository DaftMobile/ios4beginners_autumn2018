import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var jokeLabel: UILabel!
	@IBOutlet weak var fetchIndicator: UIActivityIndicatorView!

	let jokeFetcher: JokeFetcher = JokeFetcherImpl(deviceIdentifier: UIDevice.current.identifierForVendor!.uuidString)

	override func viewDidLoad() {
		super.viewDidLoad()
		fetchIndicator.stopAnimating()
	}

	@IBAction func fetchButtonPressed(_ sender: Any) {
		fetchNewJoke()
	}

	private func fetchNewJoke() {
		self.fetchIndicator.startAnimating()
		self.jokeLabel.isHidden = true
		self.view.isUserInteractionEnabled = false
		jokeFetcher.fetchNext { [weak self] joke -> Void in
			guard let `self` = self else { return }
			self.fetchIndicator.stopAnimating()
			self.jokeLabel.isHidden = false
			self.view.isUserInteractionEnabled = true
			self.jokeLabel.text = joke?.content
		}
	}
}
