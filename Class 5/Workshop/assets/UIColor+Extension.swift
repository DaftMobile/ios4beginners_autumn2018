//
//  UIColor+Extension.swift
//  Pokedex
//
//	Created by Oscar Duran on 17/7/16
//	Beerware license
//  As long as you retain this notice you can do whatever you want with this stuff. If we meet some day, and you think this stuff is worth it, you can buy me a beer in return.

import Foundation
import UIKit

extension UIColor {

	/**
	Initialize UIColor with an hex value @Source: http://stackoverflow.com/a/27270584

	- parameter hex: color hex value
	*/
	convenience init(hex: Int) {

		let components = (
			R: CGFloat((hex >> 16) & 0xff) / 255,
			G: CGFloat((hex >> 08) & 0xff) / 255,
			B: CGFloat((hex >> 00) & 0xff) / 255
		)
		self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
	}

	/*
	Creates and returns a color object that has the same color space and component values as the receiver, but has the specified alpha component

	- parameter alpha: The opacity value of the new UIColor object

	- returns: The new UIColor object.
	*/
	func alpha(alpha: CGFloat) -> UIColor {
		return withAlphaComponent(alpha)
	}

	func darkenColor() -> UIColor {

		var h: CGFloat = 0.0
		var s: CGFloat = 0.0
		var b: CGFloat = 0.0
		var a: CGFloat = 0.0

		if self.getHue(&h, saturation: &s, brightness: &b, alpha: &a) {
			return UIColor(hue: h, saturation: s, brightness: b * 0.75, alpha: a)
		}

		return self
	}
}
