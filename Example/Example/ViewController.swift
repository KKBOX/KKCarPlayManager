import UIKit
import AVFoundation
import MediaPlayer

typealias PlayableItem = (String, String)

class ViewController: UITableViewController {
	var items:[[PlayableItem]] = [
		[
			("天狗", "https://zonble.net/MIDI/tiengo.mp3"),
			("回向", "https://zonble.net/MIDI/return.mp3")],
		[
			("orz", "https://zonble.net/MIDI/orz.mp3"),
			("藿香薊", "https://zonble.net/MIDI/ageratum_conyzoides.mp3")]
	]

	override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		self.title = "KKCarPlayManager Example"
	}

	override func numberOfSections(in tableView: UITableView) -> Int {
		return items.count
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items[section].count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		cell.textLabel?.text = items[indexPath.section][indexPath.row].0
		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		let urlString = items[indexPath.section][indexPath.row].1
		let name = items[indexPath.section][indexPath.row].0
		if let url = URL(string: urlString) {
			appDelegate().player.replaceCurrentItem(with: AVPlayerItem(url: url))
			appDelegate().player.play()
			MPNowPlayingInfoCenter.default().nowPlayingInfo = [
				MPNowPlayingInfoPropertyPlaybackRate: 1,
				MPMediaItemPropertyTitle: name,
				MPMediaItemPropertyArtist: "zonble",
				MPMediaItemPropertyAlbumTitle: "zonble",
				MPNowPlayingInfoPropertyElapsedPlaybackTime: 0,
				MPMediaItemPropertyPlaybackDuration: 100,
				MPNowPlayingInfoPropertyPlaybackQueueCount: 1,
				MPNowPlayingInfoPropertyPlaybackQueueIndex: 0
			]
		}
	}
}
