//: [Previous](@previous)

import Foundation

/*:
## Zadanie 2
Napisz extension do typu Int takie, aby możliwe było wykonanie funkcji niżej
*/
extension Int {



	
}

//: Classic syntax
10.times({ () -> Void in
	print("Hello DaftCode!")
})

//: () -> Void is the type that can be inferred by the compiler
10.times({
	print("Hello DaftCode!")
})

//: Trailing closure syntax
10.times {
	print("Hello DaftCode!")
}


//: [Next](@next)
