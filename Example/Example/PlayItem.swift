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

	override func play(callback: @escaping (Error?) -> Void) throws -> Bool {
		guard let url = url else {
			callback(PlayItemError.noURL)
			return false
		}
		appDelegate().player.replaceCurrentItem(with: AVPlayerItem(url: url))
		appDelegate().player.play()
		MPNowPlayingInfoCenter.default().nowPlayingInfo = [
			MPNowPlayingInfoPropertyPlaybackRate: 1,
			MPMediaItemPropertyTitle: self.title ?? "",
			MPMediaItemPropertyArtist: "zonble",
			MPMediaItemPropertyAlbumTitle: "zonble",
			MPNowPlayingInfoPropertyElapsedPlaybackTime: 0,
			MPMediaItemPropertyPlaybackDuration: 100,
			MPNowPlayingInfoPropertyPlaybackQueueCount: 1,
			MPNowPlayingInfoPropertyPlaybackQueueIndex: 0
		]
		callback(nil)
		return true
	}
}
