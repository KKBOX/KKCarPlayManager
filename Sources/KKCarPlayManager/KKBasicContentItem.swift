import Foundation
import MediaPlayer

/// KKBOX's own subclass of MPContentItem.
open class KKBasicContentItem: MPContentItem {

	/// Childten items of the item. We use this property to build a tree and
	/// feed item on each index path to MPPlayableContentManager.
	open var children: [KKBasicContentItem]?

	/// To load the children of the node.
	///
	/// - Parameters:
	///   - callback: the callback function. It contains an error object if it
	///     encounters any error while loading.
	open func loadChildren(callback: @escaping (Error?) -> Void) throws {
		if self.isContainer == false {
			fatalError("Not a container.")
		}
		fatalError("Not implemented.")
	}

	/// To play the media mapping to the item.
	open func play(callback: @escaping (Error?) -> Void) throws -> Bool {
		fatalError("Not implemented")
	}
}

extension KKBasicContentItem {

	/// Apply an image to the current item.
	public func apply(image: UIImage?) -> KKBasicContentItem {
		if let image = image {
			self.artwork = MPMediaItemArtwork(image: image)
		} else {
			self.artwork = nil
		}
		return self
	}

}
