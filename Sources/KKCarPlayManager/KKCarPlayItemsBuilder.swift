import Foundation

@_functionBuilder
public struct KKCarPlayItemsBuilder {
	public static func buildBlock(_ items: KKBasicContentItem...) -> [KKBasicContentItem] {
		return items
	}
}
