//
//  InsulinTableViewController.swift
//  Pumped
//
//  Created by Jack White on 9/14/16.
//  Copyright © 2016 Jack White. All rights reserved.
//

import UIKit

class InsulinSettingsTableViewController: UITableViewController, NewInsulinPresetDelegate {

    // MARK: - Table view data source
    // The data source for this table is the User's Insulin Preset List (Stored in User Defaults)
    let userDefaults = UserDefaults.standard
    let insulinSettingsKey = "insulinPresetsList"
	
	var insulinSettingsDataSource = [[String: String]]() {
        didSet {
            //tableView.reloadData()
			userDefaults.set(insulinSettingsDataSource, forKey:insulinSettingsKey)
        }
    }
    
	
	/* NewInsulinPresetDelegate method called by the InsulinSettingsTableViewCell after a user completes the new cell */
	func addNewInsulinPreset(_ newPreset: [String: String]) {
		print(newPreset)
		insulinSettingsDataSource.append(newPreset)
		tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .top)
	}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get user default settings
		if let userInsulinSettings = userDefaults.array(forKey: insulinSettingsKey) as? [[String: String]] {
			insulinSettingsDataSource = userInsulinSettings
		}
		
        print(insulinSettingsDataSource)
        
        // need to add the 'add new insulin' row here...
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return insulinSettingsDataSource.count + 1  // Need +1 here for the 'add new insulin' row
    }

//	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//		return tableView.rowHeight;
//	}
	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
                withIdentifier: "InsulinSettingsCell",
                for: indexPath
            ) as! InsulinSettingsTableViewCell

		if indexPath.row == 0 {  // Trying to put the 'Add new insulin' cell first...
			cell.insulinData = nil
		} else {
			cell.insulinData = insulinSettingsDataSource[indexPath.row]
		}
		
		cell.newInsulinDelegate = self
		
        return cell
    }
	
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            insulinSettingsDataSource.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
		insulinSettingsDataSource.insert(insulinSettingsDataSource.remove(at: fromIndexPath.row), at: to.row)
    }
    

	
	//Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
		if indexPath.row == 0 {
			return false
		}
        return true
    }
	


}
