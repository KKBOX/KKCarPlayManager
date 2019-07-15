import Foundation
import KKCarPlayManager

@_functionBuilder
public struct KKCarPlayItemsBuilder {
	public static func buildBlock(_ items: KKBasicContentItem...) -> [KKBasicContentItem] {
		return items
	}
}
