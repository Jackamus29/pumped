//
//  Entry.swift
//  Pumped
//
//  Created by Jack White on 5/24/16.
//  Copyright © 2016 Jack White. All rights reserved.
//

import UIKit

protocol Entry {
	var timeCreated: Date { get }
	var colorCode: UIColor?  { get set }
	
	func isCompleted() -> Bool
}

struct InsulinEntry: Entry {
	let timeCreated = Date()
	var colorCode: UIColor?
	
	var type: String?
	var amount: Int?
	
	func isCompleted() -> Bool {
		if self.type != nil && self.amount != nil{
			return true
		}
		return false
	}
}

struct GlucoseEntry: Entry {
	let timeCreated = Date()
	var colorCode: UIColor?
	
	var measurement: Int?
	var feeling: Feeling?
	var snack: Bool?
	var notes: String?
	
	func isCompleted() -> Bool {
		if self.measurement != nil && self.feeling != nil && self.snack != nil {
			return true
		}
		return false
	}
}

enum Feeling: Character {
	case 😔 = "😔"
	case 😕 = "😕"
	case 😃 = "😃"
	
	var color: UIColor {
		switch (self){
		case .😔: return UIColor(redComponent: 253, greenComponent: 94, blueComponent: 94)
		case .😕: return UIColor(redComponent: 255, greenComponent: 143, blueComponent: 16)
		case .😃: return UIColor(redComponent: 56, greenComponent: 204, blueComponent: 144)
		}
	}
	
}
