import Foundation
import KKCarPlayManager
import AVFoundation
import MediaPlayer

enum PlayItemError: Error {
	case noURL
}

class PlayItem: KKBasicContentItem {

	var url: URL?

	public init(identifier: String, title: String, url urlString: String) {
		super.init(identifier: identifier)
		self.title = title
		url = URL(string: urlString)
		isContainer = false
		isPlayable = true
	}

	override func play(completionHandler: @escaping (Error?) -> Void) throws -> Bool {
		guard let url = url else {
			completionHandler(PlayItemError.noURL)
			return false
		}
		appDelegate().player.replaceCurrentItem(with: AVPlayerItem(url: url))
		appDelegate().player.play()
		MPNowPlayingInfoCenter.default().nowPlayingInfo = [
			MPMediaItemPropertyPersistentID: 0,
			MPMediaItemPropertyTitle: self.title ?? "",
			MPMediaItemPropertyArtist: "zonble"
		]
		completionHandler(nil)
		return true
	}
}
