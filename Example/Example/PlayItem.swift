import Foundation
import KKCarPlayManager
import AVFoundation

enum PlayItemError: Error {
	case noURL
}

class PlayItem: KKBasicContentItem {

	var url: URL?

	public init(identifier: String, title: String, url urlString: String) {
		super.init(identifier: identifier)
		self.title = title
		self.url = URL(string: urlString)
		self.isContainer = true
		self.isPlayable = false
	}

	override func play(completionHandler: @escaping (Error?) -> Void) throws -> Bool {
		guard let url = url else {
			completionHandler(PlayItemError.noURL)
			return false
		}
		appDelegate().player.replaceCurrentItem(with: AVPlayerItem(url: url))
		appDelegate().player.play()
		completionHandler(nil)
		return true
	}
}
