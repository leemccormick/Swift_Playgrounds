import UIKit

var greeting = "Hello, playground"

let point: Float = 4800//750//6600// 750


let level = point/3000


let currentLevel = Int(level)
let nextLevel = currentLevel + 1

let currentPoint = 3000 * (currentLevel)
let nextPoint = 3000 * (nextLevel)

let progressPoint = point - Float(currentPoint)
let ttrdy =   Float(6000) - Float(4500)
let agfd = ttrdy / Float(3000)

let testPoint =   Float(nextPoint) - Float(point)
let final = testPoint / Float(3000)
let last = Float(1) - Float(final)
// / Float(6000)
//Float(100) /
