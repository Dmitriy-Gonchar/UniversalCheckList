//
//  ViewController.swift
//  CheckListTest
//
//  Created by Jesus++ on 16.08.2022.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate
{
	private enum Source: CaseIterable
	{
		case login
		case password
		case other
		case switcher
	}

	private var checkList: UniversalCheckList<Source>!

	@IBOutlet private weak var login: UITextField!
	@IBOutlet private weak var password: UITextField!
	@IBOutlet private weak var other: UITextField!
	@IBOutlet private weak var nextBtn: UIButton!

	override func viewDidLoad()
	{
		super.viewDidLoad()
		self.checkList = UniversalCheckList<Source>({ self.nextBtn.isEnabled = $0 })
	}

	func textField(_ textField: UITextField,
				   shouldChangeCharactersIn range: NSRange,
				   replacementString string: String) -> Bool
	{
		let newString = (textField.text as? NSString)?.replacingCharacters(in: range, with: string)
		let isValid = !(newString?.isEmpty ?? true)

		switch textField
		{
		case self.login: self.checkList[.login] = isValid
		case self.password: self.checkList[.password] = isValid
		case self.other: self.checkList[.other] = isValid
		default: break
		}
		return true
	}

	@IBAction private func change(_ sender: UISwitch)
	{
		self.checkList[.switcher] = sender.isOn
	}

	private func changeNextAwailable(_ bool:Bool)
	{
		self.nextBtn.isEnabled = bool
	}
}
