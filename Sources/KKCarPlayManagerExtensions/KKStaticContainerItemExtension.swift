import Foundation
import KKCarPlayManager

extension KKStaticContainerItem {
	
	public convenience init(identifier: String, title: String, @KKCarPlayItemsBuilder builder:()->[KKBasicContentItem]) {
		self.init(identifier:identifier, title: title, children:builder())
	}
}

