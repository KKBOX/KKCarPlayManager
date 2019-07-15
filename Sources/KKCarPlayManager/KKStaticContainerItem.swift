import Foundation

public class KKStaticContainerItem: KKBasicContentItem {

	public init(identifier: String, title: String, children:[KKBasicContentItem]) {
		super.init(identifier: identifier)
		self.title = title
		self.children = children
	}

	public convenience init(identifier: String, title: String, @KKCarPlayItemsBuilder builder:()->[KKBasicContentItem]) {
		self.init(identifier:identifier, title: title, children:builder())
	}
}

