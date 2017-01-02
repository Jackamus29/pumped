//
//  InsulinTableViewCell.swift
//  Pumped
//
//  Created by Jack White on 9/14/16.
//  Copyright © 2016 Jack White. All rights reserved.
//

import UIKit

class InsulinSettingsTableViewCell: UITableViewCell, UITextFieldDelegate {

	@IBOutlet weak var insulinNameTextField: UITextField!
	@IBOutlet weak var insulinAmountTextField: UITextField!
	
	var newInsulinDelegate: InsulinSettingsTableViewController?
	
	var insulinData: [String: String]? {
        didSet {
			if (insulinData != nil) {
				insulinNameTextField.text = insulinData!["insulinName"]
				insulinAmountTextField.text = insulinData!["insulinAmount"]
				insulinNameTextField.isUserInteractionEnabled = false
				insulinAmountTextField.isUserInteractionEnabled = false
			} else {
				insulinNameTextField.placeholder = "Add insulin"
				insulinAmountTextField.placeholder = "3u"
			}
			insulinNameTextField.delegate = self
			insulinAmountTextField.delegate = self
		}
    }
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder();
		
		if textField == insulinNameTextField {
			insulinAmountTextField.becomeFirstResponder()
		} else if textField == insulinAmountTextField {
			newInsulinDelegate?.addNewInsulinPreset([
					"insulinName": insulinNameTextField.text!,
					"insulinAmount": insulinAmountTextField.text!
				])
		}
		
		return true;
	}
	
	

}

/* Protocol for the TableView that allows a callback for 
adding a new insulin preset to the table view datasource */
protocol NewInsulinPresetDelegate {
	func addNewInsulinPreset(_ newPreset: [String: String])
}
