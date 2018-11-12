import Foundation
//: [Previous](@previous)

//: # Functions

//: ### Basic difinition
func sayHello() -> Void {
	print("Hello")
}

sayHello()
// Hello


//: ### Functions with arguments
func sayHello(to name: String) {
	print("Hello \(name)!")
}
sayHello(to: "Marcin")
// Hello Marcin!

//: ### Functions returning values
func buildGreeting(for name: String) -> String {
	return "Hello \(name)!"
}
let greeting = buildGreeting(for: "Krystyna")	//type of greeting inferred as String
print(greeting)
// Hello Krystyna!

//: ### Closures

//: Functions are first-class citizen in Swift
let greetingPrinter: (String) -> Void = { (name: String) -> Void in
	print(buildGreeting(for: name))
}

greetingPrinter("Michał")
// Hello Michał!

let helloWorldPrinter = {
	print("Hello World")
}

func repeatAction(times: Int, action: () -> Void) -> Void {
	for _ in 0..<times {
		action()
	}
}

/// You can pass a function
repeatAction(times: 3, action: helloWorldPrinter)
// Hello World
// Hello World
// Hello World

/// You can define a closure inline
repeatAction(times: 2, action: {
	print("Cześć")
})
// Cześć
// Cześć

//: Trailing closure syntax
repeatAction(times: 2) {
	print("Swift is awesome! 🎉")
}
// Swift is awesome! 🎉
// Swift is awesome! 🎉

//: [Next](@next)
