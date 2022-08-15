//
//  UniversalCheckList.swift
//  CheckListTest
//
//  Created by Jesus++ on 16.08.2022.
//

import Foundation

struct UniversalCheckList<T: Hashable&CaseIterable>
{
	private var didChangeBlock: ((Bool) -> Void)?
	private var dict: [T: Bool]
	{
		didSet
		{
			self.didChangeBlock?(self.isReady)
		}
	}

	public var isReady: Bool
	{
		self.dict.reduce(true) { $0 && $1.value }
	}

	public init(_ didChangeBlock: ((Bool) -> Void)? = nil)
	{
		self.dict = [T: Bool]()
		self.didChangeBlock = didChangeBlock
		T.self.allCases.forEach { self.dict[$0] = false }
	}

	public subscript(key: T) -> Bool
	{
		get { self.dict[key] ?? false }
		set { self.dict[key] = newValue }
	}

	public subscript(keys: [T]) -> Bool
	{
		get { keys.reduce(true) { $0 && self.dict[$1] ?? false } }
		set { keys.forEach { self.dict[$0] = newValue } }
	}
}
