//
//  TimelineViewController.swift
//  Pumped
//
//  Created by Jack White on 5/24/16.
//  Copyright © 2016 Jack White. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {
    // timeline model
	var entryList = [Entry]()
    
    @IBAction func newEntryButtonPressed(_ sender: UIBarButtonItem) {
        
    }
	
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "newGlucoseSegue" {
			print("Segueing to new Glucose Entry View")
			if let glucoseEntryVC = segue.destination as? GlucoseEntryViewController {
				glucoseEntryVC.appendToEntryList = appendToEntryList			}
		}
    }
	
	@IBAction func dismissModal (_ segue: UIStoryboardSegue) {
		
	}
	
	func appendToEntryList(_ entry: Entry) {
		entryList.append(entry)
		print(entryList)
	}
	
    
}
