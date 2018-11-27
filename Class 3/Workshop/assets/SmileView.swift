/*
* SmileView.swift
* Created by Kajetan Dąbrowski on 27/11/2018.
*
* iOS 4 Beginners 2018
* Copyright 2018 DaftMobile Sp. z o. o.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*    http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or  * implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

import Foundation
import UIKit

protocol SmileDataSource: class {
	// TODO: Some function that will get the current smile level
}

class SmileView: UIView {

	// TODO: Add a data source reference. Remember about memory management!!!

	override func draw(_ rect: CGRect) {
		guard let context = UIGraphicsGetCurrentContext() else { return }
		guard bounds.size.width > 5, bounds.size.height > 5 else { return }

		// Step 1: Draw a face shape 😶
		drawFace(rect: bounds, in: context)

		// Step 2: Draw the eyes 👀
		let eyeVerticalOffset = bounds.height * 0.14
		let eyeHorizontalOffset = bounds.width * 0.13
		let eyesCenter = CGPoint(x: bounds.midX, y: bounds.midY - eyeVerticalOffset)
		let eyeWidth: CGFloat = bounds.width * 0.11
		let eyeHeight: CGFloat = eyeWidth * 1.05
		let eyeSize = CGSize(width: eyeWidth, height: eyeHeight)
		drawEye(at: CGPoint(x: eyesCenter.x - eyeHorizontalOffset, y: eyesCenter.y), size: eyeSize, in: context)
		drawEye(at: CGPoint(x: eyesCenter.x + eyeHorizontalOffset, y: eyesCenter.y), size: eyeSize, in: context)

		// Step 3: Ignore the nose 👃🚫

		// Step 4: Draw the smile itself 👄
		let smile: Float = 0.0 // TODO: Use the data source to get the smile level
		drawSmile(level: smile, in: context)
	}

	private func drawEye(at point: CGPoint, size: CGSize, in context: CGContext) {
		let eyeRect = CGRect(origin: point, size: .zero).insetBy(dx: -size.width * 0.5, dy: -size.height * 0.5)
		let irisRect = eyeRect
			.insetBy(dx: eyeRect.width * 0.25, dy: eyeRect.height * 0.25)
			.offsetBy(dx: 0, dy: eyeRect.height * 0.15)

		context.saveGState()
		context.setFillColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
		context.fillEllipse(in: eyeRect)
		context.setFillColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
		context.fillEllipse(in: irisRect)
		context.restoreGState()
	}

	private func drawFace(rect: CGRect, in context: CGContext) {
		let faceLineWidth: CGFloat = 3
		let faceRect = rect.insetBy(dx: faceLineWidth * 0.5, dy: faceLineWidth * 0.5)
		context.saveGState()
		context.setFillColor(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1))
		context.fillEllipse(in: faceRect)

		context.setStrokeColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))
		context.setLineWidth(faceLineWidth)
		context.strokeEllipse(in: faceRect)
		context.restoreGState()
	}

	private func drawSmile(level: Float, in context: CGContext) {
		let smileVerticalOffset = bounds.height * 0.18
		let smileHorizontalOffset = bounds.width * 0.21
		let maxSmileOffset: CGFloat = bounds.height * 0.14

		let smileOffset = CGFloat(level) * maxSmileOffset
		let smileCenter = CGPoint(x: bounds.midX, y: bounds.midY + smileVerticalOffset)
		let smileLeftPoint = CGPoint(x: smileCenter.x - smileHorizontalOffset, y: smileCenter.y - smileOffset * 0.21)
		let smileRightPoint = CGPoint(x: smileCenter.x + smileHorizontalOffset, y: smileCenter.y - smileOffset * 0.21)

		let smileControlPoint = CGPoint(x: smileCenter.x, y: smileCenter.y + smileOffset)

		context.saveGState()
		context.setLineCap(.round)
		context.setStrokeColor(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
		context.setLineWidth(8.0)

		context.move(to: smileLeftPoint)
		context.addQuadCurve(to: smileRightPoint, control: smileControlPoint)
		context.strokePath()
		context.restoreGState()
	}
}
