import UIKit
import PlaygroundSupport
var greeting = "Hello, Multithreading in Swift"

/* Multithreading in Swift
 https://medium.com/@randhirkushwaha3130/multithreading-in-swift-fb64f7922fd0
 Every program will have one thread, which is called as a main thread. Main thread starts it execution when application starts, and it is responsible for executing the application logic unless we explicitly create another thread.
 *** Different ways to create multiple threads  ***
 1. Using Thread object
 2. Using GCD (Grand Central Dispatch) -> GCD is tightly coupled with closure. This means you can build code dynamically, pass a block object to a method as a parameter, and return a block object from a method.
 3. Operation Queues -> Operation Queue are high level abstraction of the queue model and is built on top of GCD. That means you can execute tasks concurrently just like GCD, but in an object-oriented fashion.
 */

// MARK: - 2.1. DispatchGroup -> With dispatch groups we can group together multiple tasks and either wait for them to be completed or be notified once they are complete. Tasks can be asynchronous or synchronous and can even run-on different queues. Dispatch groups are managed by DispatchGroup object.
PlaygroundPage.current.needsIndefiniteExecution = true

let concurrentQueueDispatchGroup = DispatchQueue(label: "com.queue.ConcurrentDispatchGroup", attributes: .concurrent)
func performAsyncTaskIntoConcurrentQueueDispatchGroup(with completion: @escaping () -> ()) {
    let group = DispatchGroup()
    for i in 1...5 {
        group.enter()
        concurrentQueueDispatchGroup.async {
            let imageURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")!
            let _ = try! Data(contentsOf: imageURL)
            print("###### Image \(i) Downloaded -> DispatchGroup at \(#line) ######")
            group.leave()
        }
    }
    /* Either write below code or group.notify() to execute completion block
     group.wait()
     DispatchQueue.main.async {
     completion()
     }
     */
    group.notify(queue: DispatchQueue.main) {
        completion()
    }
}
print("###### Download all images asynchronously and notify on completion -> DispatchGroup at \(#line)  ######")
print("############ -> DispatchGroup at \(#line)")
print("############ -> DispatchGroup  at \(#line)\n")
performAsyncTaskIntoConcurrentQueueDispatchGroup(with: {
    print("\n############ -> DispatchGroup at \(#line) ")
    print("############ -> DispatchGroup at \(#line) ")
    print("###### All images are downloaded -> DispatchGroup at \(#line)")
})

// MARK: - 2.2. DispatchWorkItem -> A DispatchWorkItem encapsulates block of code that can be dispatched to any queue. A DispatchWorkItem can also be set as a DispatchSource event, registration, or cancel handler. A dispatch work item has a cancel flag. If it is cancelled before running, the dispatch queue won’t execute it and will skip it. If it is cancelled during its execution, the cancel property returns true. In that case, we can abort the execution. Also work items can notify a queue when their task is completed.

let concurrentQueueDispatchWorkItem = DispatchQueue(label: "com.queue.ConcurrentDispatchWorkItem", attributes: .concurrent)
func performAsyncTaskInConcurrentQueueDispatchWorkItem() {
    var task:DispatchWorkItem?
    task = DispatchWorkItem {
        for i in 1...5 {
            if Thread.isMainThread {
                print("task running in main thread -> DispatchWorkItem at \(#line)")
            } else{
                print("task running in other thread -> DispatchWorkItem at \(#line)")
            }
            if (task?.isCancelled)! {
                break
            }
            let imageURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")!
            let _ = try! Data(contentsOf: imageURL)
            print("\(i) finished downloading -> DispatchWorkItem at \(#line)")
        }
        task = nil
    }
    /*
     There are two ways to execute task on queue. Either by providing task to execute parameter or
     within async block call perform() on task. perform() executes task on current queue.
     */
    // concurrentQueue.async(execute: task!)
    concurrentQueueDispatchWorkItem.async {
        task?.wait(wallTimeout: .now() + .seconds(2))
        // task?.wait(timeout: .now() + .seconds(2))
        task?.perform()
    }
    concurrentQueueDispatchWorkItem.asyncAfter(deadline: .now() + .seconds(2), execute: {
        task?.cancel()
    })
    task?.notify(queue: concurrentQueueDispatchWorkItem) {
        print("\n############ -> DispatchWorkItem at \(#line)")
        print("############ -> DispatchWorkItem at \(#line)")
        print("###### Work Item Completed -> DispatchWorkItem at \(#line)")
    }
}
performAsyncTaskInConcurrentQueueDispatchWorkItem()
print("###### Download all images asynchronously and notify on completion -> DispatchWorkItem at \(#line) ######")
print("############ -> DispatchWorkItem at \(#line)")


// MARK: - 2.3. DispatchBarrier -> If the queue is a serial queue or one of the global concurrent queues, the barrier would not work. Using barriers in a custom concurrent queue is a good choice for handling thread safety in critical areas of code.
var valueDispatchBarrier: Int = 2
let concurrentQueueDispatchBarrier = DispatchQueue(label: "queueDispatchBarrier", attributes: .concurrent)
concurrentQueueDispatchBarrier.async(flags: .barrier) {
    for i in 0...3 {
        valueDispatchBarrier = i
        print("valueDispatchBarrier : \(valueDispatchBarrier)  ✴️ -> DispatchBarrier at \(#line)")
    }
}
concurrentQueueDispatchBarrier.async {
    print("valueDispatchBarrier : \(valueDispatchBarrier) -> DispatchBarrier at \(#line)")
}
concurrentQueueDispatchBarrier.async(flags: .barrier) {
    for j in 4...6 {
        valueDispatchBarrier = j
        print("valueDispatchBarrier : \(valueDispatchBarrier) ✡️  -> DispatchBarrier at \(#line)")
    }
}
concurrentQueueDispatchBarrier.async {
    valueDispatchBarrier = 14
    print("valueDispatchBarrier : \(valueDispatchBarrier)  -> DispatchBarrier at \(#line)")
}

// MARK: - 2.4. DispatchSemaphore -> Semaphores gives us the ability to control access to a shared resource by multiple threads. A semaphore consists of a threads queue and a counter value (of type Int). Threads queue is used by the semaphore to keep track on waiting threads in FIFO order. Counter value is used by the semaphore to decide if a thread should get access to a shared resource or not. The counter value changes when we call signal() or wait() functions. Threads queue is used by the semaphore to keep track on waiting threads in FIFO order.

var valueDispatchSemaphore: Int = 2
let concurrentQueueDispatchSemaphore = DispatchQueue(label: "queueDispatchSemaphore", attributes: .concurrent)
let semaphore = DispatchSemaphore(value: 1)
for j in 0...4 {
    concurrentQueueDispatchSemaphore.async {
        print("j : \(j) waiting -> DispatchSemaphore at \(#line)")
        semaphore.wait()
        print("j : \(j) wait finished -> DispatchSemaphore at \(#line)")
        valueDispatchSemaphore = j
        print("valueDispatchSemaphore : \(valueDispatchSemaphore) ✡️ -> valueDispatchSemaphore at \(#line)")
        print("j : \(j) Done with assignment -> DispatchSemaphore at \(#line)")
        semaphore.signal()
    }
}

