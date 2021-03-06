import UIKit
import KKCarPlayManager
import MediaPlayer
import AVFoundation

func appDelegate() -> AppDelegate {
	return UIApplication.shared.delegate as! AppDelegate
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?
	var manager: KKCarPlayManager?
	var player = AVPlayer()

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		MPRemoteCommandCenter.shared().playCommand.addTarget { event in
			return .success
		}
		MPRemoteCommandCenter.shared().pauseCommand.addTarget { event in
			return .success
		}
		MPRemoteCommandCenter.shared().stopCommand.addTarget { event in
			return .success
		}
		MPRemoteCommandCenter.shared().togglePlayPauseCommand.addTarget { event in
			return .success
		}
		MPRemoteCommandCenter.shared().previousTrackCommand.addTarget { event in
			return .success
		}
		MPRemoteCommandCenter.shared().nextTrackCommand.addTarget { event in
			return .success
		}
		application.beginReceivingRemoteControlEvents()


		let rooNode = KKStaticContainerItem(identifier: "root", title: "Root", children: [
			KKStaticContainerItem(identifier: "folder1", title: "Folder 1", children: [
				PlayItem(identifier: "Song_1_1", title: "天狗", url: "https://zonble.net/MIDI/tiengo.mp3"),
				PlayItem(identifier: "Song_1_2", title: "回向", url: "https://zonble.net/MIDI/return.mp3"),
				]),
			KKStaticContainerItem(identifier: "folder_2", title: "Folder 2", children: [
				PlayItem(identifier: "Song_2_1", title: "orz", url: "https://zonble.net/MIDI/orz.mp3"),
				PlayItem(identifier: "Song_2_2", title: "藿香薊", url: "https://zonble.net/MIDI/ageratum_conyzoides.mp3")
				]),
			]
		)
		manager = KKCarPlayManager(rootNode: rooNode)
		manager?.activate()

		try? AVAudioSession.sharedInstance().setCategory(.playback)
		try? AVAudioSession.sharedInstance().setActive(true, options: [])

		let vc = ViewController(style: .grouped)
		let nav = UINavigationController(rootViewController: vc)
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = nav
		window?.makeKeyAndVisible()

		return true
	}
}
