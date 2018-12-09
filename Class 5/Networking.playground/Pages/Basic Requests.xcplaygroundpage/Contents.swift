//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport

//: # Basic network request

PlaygroundPage.current.needsIndefiniteExecution = true

let urlString = "https://user-images.githubusercontent.com/1230922/49699118-89965b80-fbcd-11e8-9d91-3c590de3df8f.png"

/*:
##	Task 1:

### Download this image and diplay a UIImage object in the simplest possible way

1. Create a URL

2. Use the `Data(contensOf: URL) throws` initializer - remember to use a background Queue!!!!

3. Use the `UIImage(data: Data)` initializer
*/

