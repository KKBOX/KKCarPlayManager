import UIKit
import KKCarPlayManager
import MediaPlayer

func appDelegate() -> AppDelegate {
	return UIApplication.shared.delegate as! AppDelegate
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?
	var manager: KKCarPlayManager?
	var player = AVPlayer()

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		let vc = ViewController()
		let nav = UINavigationController(rootViewController: vc)
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = nav
		window?.makeKeyAndVisible()

		MPRemoteCommandCenter.shared().playCommand.addTarget { event in
			return .success
		}

		let rooNode = KKStaticContainerItem(identifier: "root", title: "Root", children: [
			KKStaticContainerItem(identifier: "folder 1", title: "Folder 1", children: [
				PlayItem(identifier: "Song 1 1", title: "天狗", url: "https://zonble.net/MIDI/tiengo.mp3"),
				PlayItem(identifier: "Song 1 2", title: "回向", url: "https://zonble.net/MIDI/return.mp3")
				]),
			KKStaticContainerItem(identifier: "folder 2", title: "Folder 2", children: [
				PlayItem(identifier: "Song 2 1", title: "天狗", url: "https://zonble.net/MIDI/tiengo.mp3"),
				PlayItem(identifier: "Song 2 2", title: "回向", url: "https://zonble.net/MIDI/return.mp3")
				]),
//			KKStaticContainerItem(identifier: "folder 3", title: "Folder 3", children: [
//				PlayItem(identifier: "Song 3 1", title: "天狗", url: "https://zonble.net/MIDI/tiengo.mp3"),
//				PlayItem(identifier: "Song 3 2", title: "回向", url: "https://zonble.net/MIDI/return.mp3")
//				])
			]
		)
		manager = KKCarPlayManager(rootNode: rooNode)
		manager?.activate()
		return true
	}
}
