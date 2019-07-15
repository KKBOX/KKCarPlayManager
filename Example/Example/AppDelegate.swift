import UIKit
import MediaPlayer
import AVFoundation
import KKCarPlayManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	var carplayManager: KKCarPlayManager?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		MPRemoteCommandCenter.shared().playCommand.addTarget { _ in .success }
		MPRemoteCommandCenter.shared().pauseCommand.addTarget { _ in .success }
		MPRemoteCommandCenter.shared().stopCommand.addTarget { _ in .success }
		MPRemoteCommandCenter.shared().togglePlayPauseCommand.addTarget { _ in .success }
		let rootNode = KKStaticContainerItem(identifier: "root", title: "Root") {
			KKBasicContentItem(identifier: "item 1")
			KKBasicContentItem(identifier: "item 2")
			KKBasicContentItem(identifier: "item 3")
		}
		carplayManager = KKCarPlayManager(rootNode: rootNode)
		carplayManager?.activate()
		try? AVAudioSession.sharedInstance().setCategory(.playback)
		try? AVAudioSession.sharedInstance().setActive(true, options: [])
		return true
	}

	func applicationWillTerminate(_ application: UIApplication) {
	}

	// MARK: UISceneSession Lifecycle

	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
	}

}
