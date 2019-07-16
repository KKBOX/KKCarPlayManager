import Foundation
import KKCarPlayManager

/// :nodoc:
extension KKStaticContainerItem {
	/// :nodoc:
	public convenience init(identifier: String, title: String, @KKCarPlayItemsBuilder builder:()->[KKBasicContentItem]) {
		self.init(identifier:identifier, title: title, children:builder())
	}
}

