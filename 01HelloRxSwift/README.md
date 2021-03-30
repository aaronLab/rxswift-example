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

# Foundation of RxSwift

Observables, operators, schedulers.

## Observables

`Observable<Element>`

The ability to asynchronously produce a sequence of events that can "carry" an immutable snapshot of generic data of type `Element`.

- A `next` event

- A `completed` event

- An `error` event

### Finite observable sequences

When you download a file from the Internet...

- Start the download and start observing for incoming data.

- Repeatedly receive chunks of data as parts of the file arrive.

- Bad connection: the download will stop and the connection will time out + error.

- When the all the file's data, it'll be completed.

```Swift
API.download(file: "http://www...")
   .subscribe(
     onNext: { data in
      // Append data to temporary file
     },
     onError: { error in
       // Display error to user
     },
     onCompleted: {
       // Use downloaded file
     }
    )
```

### Infinite observable sequences

When you need to react to device orientation changes...

```Swift
UIDevice.rx.orientation
  .subscribe(onNext: { current in
    switch current {
    case .landscape:
      // Re-arrange UI for landscape
    case .portrait:
      // Re-arrange UI for portrait
    }
  })
```

## Operators

Abstract discrete pieces of asynchronous work and event manipulations.

- filter, map, and so on...

```Swift
UIDevice.rx.orientation
  .filter { $0 != .landscape }
  .map { _ in "Portrait is the best!" }
  .subscribe(onNext: { string in
    showAlert(text: string)
  })
```

## Schedulers

The Rx equivalent of dispatch queus or operation queus.

- Network
  1. fetch JSON: Custom NSOperation Scheduler
  2. process JSON: Background Concurrent Scheduler
  3. display to UI: Main Thread Serial Scheduler
- Data Bindings
  1. data update: Background Concurrent Scheduler
  2. display to UI: Main Thread Serial Scheduler

# RxCocoa

for UIKit
