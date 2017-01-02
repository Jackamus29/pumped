//
//  GlucoseEntryViewController.swift
//  Pumped
//
//  Created by Jack White on 5/8/16.
//  Copyright © 2016 Jack White. All rights reserved.
//

import UIKit

class GlucoseEntryViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var glucoseLevelTextField: UITextField!
    @IBOutlet weak var feelingBadButton: UIButton!
    @IBOutlet weak var feelingMehButton: UIButton!
    @IBOutlet weak var feelingGoodButton: UIButton!
    @IBOutlet weak var snackSegmentedControl: UISegmentedControl!
    @IBOutlet weak var otherNotesTextField: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()

        // Need to add 'Done' button to Number Keyboard for the Glucose Measurement Text Field
		//used to align the Done button on the left
		let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
		//Done button
		let done = UIBarButtonItem(
			title: "Done",
			style: UIBarButtonItemStyle.done,
			target: self,
			action: #selector(resign)
		)
		let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
		doneToolbar.items = [spacer, done]
		doneToolbar.sizeToFit()
		glucoseLevelTextField.inputAccessoryView = doneToolbar
		
        glucoseLevelTextField.delegate = self
        otherNotesTextField.delegate = self
    }
	// action of Done button
	func resign(){
		glucoseLevelTextField.resignFirstResponder()
	}
	// Text Field Delegate function that closes the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: Model
	// model
	var appendToEntryList: ((Entry) -> Void)!
	var glucoseEntry = GlucoseEntry()
	
	// MARK: Form Interaction Functions
    
    // Fired when 'Add' button is tapped
	@IBAction func addEntry(_ sender: UIBarButtonItem) {
        // need to add color code here based on user props
		print(glucoseEntry)
	}
    
    // Fired when glucose text field changes
    @IBAction func glucoseFieldDidChange(_ sender: UITextField) {
        if let measure = Int((sender.text)!){
            glucoseEntry.measurement = measure
        }
        
        enableAdd()
    }
    
    // Fired when a Feeling is tapped
	@IBAction func feelSelected(_ sender: UIButton) {
		//should activate the selected button and deactivate the others.
		glucoseEntry.feeling = Feeling(rawValue: Character(sender.titleLabel!.text!))
		
		enableAdd()
	}
	
    // Fired when snack segmented control is tapped
    @IBAction func snackSelected(_ sender: UISegmentedControl) {
        glucoseEntry.snack = Bool(sender.selectedSegmentIndex == 0)  // yes is 0, and no is 1
		
		enableAdd()
    }
    
    // Fired when 'Done' is tapped on the notes text field
    @IBAction func noteAdded(_ sender: UITextField) {
        glucoseEntry.notes = sender.text
    }
    
    // Called whenever a data point in this entry is added so that we can enable the 'Add' button if needed
    func enableAdd() {
        if glucoseEntry.isCompleted() {
            addButton.isEnabled = true
        }
    }
	
	
	// MARK: Navigation
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		// Before we segue, need to add the completed glucose entry to the timelineVC entryList
		if segue.identifier == "newInsulinSegue" {
			appendToEntryList(glucoseEntry)
			// Then pass the entryList along so that the InsulinEntryVC can use it.
			if let insulinEntryVC = segue.destination as? InsulinEntryViewController {
				insulinEntryVC.appendToEntryList = appendToEntryList
			}
		}
	}
	
	// dismiss Entry modal without entry data
	@IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
		presentingViewController?.dismiss(animated: true, completion: nil)
	}
	
}

