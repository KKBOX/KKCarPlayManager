import Foundation

@_functionBuilder
struct KKCarPlayItemsBuilder {
	static func buildBlock(_ items: KKBasicContentItem...) -> [KKBasicContentItem] {
		return items
	}
}
