# Hello RxSwift

RxSwift is library for composing asynchronoous and event-based code by using observable sequences and functional style operators, allowing for parameterized excution via schedulers.

RxSwift, in its essence, simplifies developing asynchronous programs by allowing your code to react to new data and process it in a sequential, isolated mannger.

## Asynchronous Programming

What happens at the same time is...

- Reacting to button taps
- Animating the keyboard as a text field loses focus
- Downloading a large photo from the Internet
- Saving bits of data to dis
- Playing audio

## Cocoa and UIKit asynchronous APIs

- NotificationCenter
- The delegate pattern
- GCD
- Closures
- Combine

## Synchronous code

- e.g. for loop from an array

```Swift
var array = [1, 2, 3]
for number in array {
    print(number)
    array = [4, 5, 6]
}
print(array)
```

## Asynchronous code

When you run the code below, it might cause an error.
Becuase the currentIndex can be changed from another function.

```Swift
var array = [1, 2, 3]
var currentIndex = 0

/// Connected to a button
@objc private func printNext() {
    print(array[currentIndex])

    if currentIndex != array.count - 1 {
        currentIndex += 1
    }
}
```

## Asynchronous programming glossary

1. State, and specifically, shared mutable state

   - Managing the state of your app...

2. Imperative programming

   - To tell the app exactly when and how to do things...

3. Side effects

   - Which simply process and output data...

4. Declarative code

   - Let you define pieces of behaviour...

5. Reactive systems
   - Responsive
   - Resilient
   - Elastic
   - Message-driven
