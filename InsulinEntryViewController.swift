//
//  InsulinEntryViewController.swift
//  Pumped
//
//  Created by Jack White on 7/9/16.
//  Copyright © 2016 Jack White. All rights reserved.
//

import UIKit

class InsulinEntryViewController: UITableViewController {
	
	
	// model
	var insulinEntry = InsulinEntry()
	var appendToEntryList: ((Entry) -> Void)!

	
	override func viewDidLoad() {
		super.viewDidLoad()
    }
	
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
	
	// Save Entry Button Pressed (unwind back to TimelineVC)
	@IBAction override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		// Add the insulin entry (unless no insulin) to the entryList and then unwind.
		if segue.identifier == "dismissModal" {
			appendToEntryList(insulinEntry)
		}
	}

}

