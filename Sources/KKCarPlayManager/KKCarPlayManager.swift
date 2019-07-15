import Foundation
import MediaPlayer

/// The error used in `KKCarPlayManager`.
public enum KKCarPlayManagerError : Error, LocalizedError {
	/// The item does not exist.
	case itemNotExist
	/// An error with a message.
	case message(String)

	/// :nodoc:
	public var errorDescription: String? {
		switch self {
		case .itemNotExist:
			return "The item does not exist."
		case .message(let message):
			return message
		}
	}
}

public class KKCarPlayManager: NSObject {

	/// Set the data source and delegate of MPPlayableContentManager to
	/// the current instance of KKCarPlayManager.
	public func activate() {
		MPPlayableContentManager.shared().dataSource = self
		MPPlayableContentManager.shared().delegate = self
		MPPlayableContentManager.shared().beginUpdates()
		MPPlayableContentManager.shared().endUpdates()
	}

	/// Set the data source and delegate of MPPlayableContentManager to nil.
	public func deactivate() {
		MPPlayableContentManager.shared().dataSource = nil
		MPPlayableContentManager.shared().delegate = nil
	}

	/// The root node of KKCarPlayManager.
	final var rootNode: KKBasicContentItem {
		didSet {
			MPPlayableContentManager.shared().beginUpdates()
			MPPlayableContentManager.shared().endUpdates()
		}
	}
	final var currentPlaybackCallback: ((Error?) -> Void)?

	/// Creates a new instance.
	/// - Parameter rootNode: The root node.
	public init(rootNode: KKBasicContentItem) {
		self.rootNode = rootNode
		super.init()
	}


	/// Travel through the tree to find a specific node by giving the
	/// index path of the node.
	///
	/// - parameter indexPath: Index path of the node.
	/// - returns: The node found in the tree.
	fileprivate func travel(_ indexPath: IndexPath) -> KKBasicContentItem? {
		if indexPath.count == 0 {
			return self.rootNode
		}
		var node: KKBasicContentItem? = self.rootNode
		for i in 0..<indexPath.count {
			let index = (indexPath as NSIndexPath).index(atPosition: i)
			node = node?.children?.element(at: index)
		}
		return node
	}

	public func commitCurrentPlaybackCallbackWithMessage(_ message: String) -> Bool {
		let error = KKCarPlayManagerError.message(message)
		return self.commitCurrentPlaybackCallback(error)
	}

	@objc public final func commitCurrentPlaybackCallback(_ error: Error?) -> Bool {
		NSObject.cancelPreviousPerformRequests(withTarget: self)
		if let callback = currentPlaybackCallback {
			DispatchQueue.global(qos: .default).async {
				callback(error)
			}
			currentPlaybackCallback = nil
			return true
		}
		return false
	}

	public final func delayedCommitCurrentPlaybackCallbackWithourError() {
		NSObject.cancelPreviousPerformRequests(withTarget: self)
		self.perform(#selector(KKCarPlayManager.commitCurrentPlaybackCallback(_:)), with: nil, afterDelay: 0.5)
	}

}

extension KKCarPlayManager: MPPlayableContentDataSource {
	/// :nodoc:
	public final func numberOfChildItems(at indexPath: IndexPath) -> Int {
		let node = self.travel(indexPath)
		return node?.children?.count ?? 0
	}

	/// :nodoc:
	public final func contentItem(at indexPath: IndexPath) -> MPContentItem? {
		let node = self.travel(indexPath)
		return node
	}

	/// :nodoc:
	@objc(beginLoadingChildItemsAtIndexPath:completionHandler:)
	public final func beginLoadingChildItems(at indexPath: IndexPath, completionHandler: @escaping (Error?) -> ()) {
		func continueLoadingChildren() {
			guard let node = self.travel(indexPath) else {
				completionHandler(KKCarPlayManagerError.itemNotExist)
				return
			}
			if node.children != nil {
				for item in node.children! {
					item.children = nil
				}
				completionHandler(nil)
				return
			}

			do {
				try node.loadChildren { error in
					if let error = error {
						completionHandler(error)
						return
					}
					completionHandler(nil)
				}
			} catch {
				completionHandler(node.children != nil ? nil : error)
			}
		}

		continueLoadingChildren()
	}

}

extension KKCarPlayManager: MPPlayableContentDelegate {
	/// :nodoc:
	public final func playableContentManager(_ contentManager: MPPlayableContentManager, initiatePlaybackOfContentItemAt indexPath: IndexPath, completionHandler: @escaping (Error?) -> Void) {
		DispatchQueue.main.async { [weak self] in
			if let strongSelf = self {
				NSObject.cancelPreviousPerformRequests(withTarget: strongSelf)
			}
			guard let currentNode = self?.travel(indexPath) else {
				completionHandler(KKCarPlayManagerError.itemNotExist)
				return
			}

			self?.currentPlaybackCallback?(nil)
			self?.currentPlaybackCallback = completionHandler
			do {
				let shouldCleanCachedCallback = try currentNode.play(completionHandler: completionHandler)
				if shouldCleanCachedCallback {
					self?.currentPlaybackCallback = nil
				}
			} catch {
				self?.currentPlaybackCallback?(error as NSError)
				self?.currentPlaybackCallback = nil
			}
		}
	}
}
