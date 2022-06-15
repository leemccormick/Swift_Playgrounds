import Combine
import UIKit

let greeting = "Hello, Combine"

// MARK: - WeatherError
enum WeatherError: Error {
    case thingsJustHappen
}

// MARK: - weatherPublisher
let weatherPublisher = PassthroughSubject<Int, WeatherError>() // PassthroughSubject<Int, Never>() || PassthroughSubject<Void, Never>()

// MARK: - subscriber
let subscriber = weatherPublisher
    .filter { $0 > 25 }
    .sink { completion in
        switch completion {
        case .finished:
            print("Finished sinking")
        case .failure(let error):
            print("Error : \(error)")
        }
    } receiveValue: { value in
        print("A summer day of \(value) C")
    }

// MARK: - anotherSubscriber
let anotherSubscriber = weatherPublisher.handleEvents(receiveSubscription: { subscription in
    print("New Subscription \(subscription)")
}, receiveOutput: { output in
    print("New Value Output : \(output)")
}, receiveCompletion:  { error in
    print("Subscription Completed with potential error \(error)")
} , receiveCancel: {
    print("Subscription Cancelled")
}).sink { completion in
    switch completion {
    case .finished:
        print("Finished sinking")
    case .failure(let error):
        print("Error : \(error)")
    }
} receiveValue: { value in
    print("Subscription receieved value of \(value) C")
}

// MARK: - Called weatherPublisher
weatherPublisher.send(10)
weatherPublisher.send(18)
weatherPublisher.send(20)
weatherPublisher.send(24)
weatherPublisher.send(26)
weatherPublisher.send(completion: Subscribers.Completion<WeatherError>.failure(.thingsJustHappen)) // To Send Error
weatherPublisher.send(28)
weatherPublisher.send(30)

// https://www.youtube.com/watch?v=RysM_XPNMTw
