//
// KKArrayExtensions.swift
//
// Copyright (c) 2008-2017 KKBOX Taiwan Co., Ltd. All Rights Reserved.
//

import Foundation

extension Array {
	func element(at index: Int) -> Iterator.Element? {
		switch index {
		case 0..<self.count:
			return self[index]
		default:
			return nil
		}
	}

	func lastIndex() -> Int {
		return self.count > 0 ? self.count - 1 : 0
	}
}
