//
//  conveniences.swift
//  Pumped
//
//  Created by Jack White on 5/24/16.
//  Copyright © 2016 Jack White. All rights reserved.
//

import UIKit

extension UIColor{
	
	convenience init(redComponent: Int, greenComponent: Int, blueComponent: Int){
		self.init(redComponent: redComponent, greenComponent: greenComponent, blueComponent: blueComponent, alphaComponent: 100)
	}
	
	convenience init(redComponent: Int, greenComponent: Int, blueComponent: Int, alphaComponent: Int){
		assert(0 <= redComponent && redComponent <= 255, "Invalid red component")
		assert(0 <= greenComponent && greenComponent <= 255, "Invalid green component")
		assert(0 <= blueComponent && blueComponent <= 255, "Invalid blue component")
		assert(0 <= alphaComponent && alphaComponent <= 100, "Invalid alpha component")
		
		self.init(red: CGFloat(redComponent)/255.0,
		          green: CGFloat(greenComponent)/255.0,
		          blue: CGFloat(blueComponent)/255.0,
		          alpha: CGFloat(alphaComponent)/100.0)
	}
}
