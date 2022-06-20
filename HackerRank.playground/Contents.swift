import UIKit
import Foundation

func greeting(_ date: String)  {
    print("\n")
    print("--------------------- Hello, Hacker on \(date) : You can do this challeges --------------------- ")
    print("\n")
}

func endOfDay(_ date: String) {
    print("\n")
    print("--------------------- End Of \(date) : Keep Going Hacker --------------------- ")
    print("\n")
}

func challengeOf(_ info: String) {
    print("\n------------------------------------------ Hacker Rank ------------------------------------------")
    print(info)
    print("-------------------------------------------------------------------------------------------------\n")
}

greeting("May 18 2022")

// ---------------------------------------------------------------------------------------------------------------
challengeOf("""
 Given an array of integers, calculate the ratios of its elements that are positive, negative, and zero. Print the decimal value of each fraction on a new line with  places after the decimal.
 Note: This challenge introduces precision problems. The test cases are scaled to six decimal places, though answers with absolute error of up to  are acceptable.
""")

func plusMinus(arr: [Int]) -> Void {
    let count = Double(arr.count)
    let countOfPositive = Double(arr.filter {$0 > 0}.count)
    let countOfNavgative = Double(arr.filter {$0 < 0}.count)
    let countOfZero = Double(arr.filter {$0 == 0}.count)
    print(String(format: "%.6f", countOfPositive / count))
    print(String(format: "%.6f", countOfNavgative / count))
    print(String(format: "%.6f", countOfZero / count))
}

plusMinus(arr: [1,2,3,-1,-2,-3,0,0])
plusMinus(arr: [-4,3,-9,0,4,1])

func plusMinus2(arr: [Int]) -> Void {
    let count = Double(arr.count)
    var countOfPositive = 0.0
    var countOfNavgative = 0.0
    var countOfZero = 0.0
    for num in arr {
        if num > 0 {
            countOfPositive += 1.0
        } else if num < 0 {
            countOfNavgative += 1.0
        } else if num == 0 {
            countOfZero += 1.0
        }
    }
    print(String(format: "%.6f", countOfPositive / count))
    print(String(format: "%.6f", countOfNavgative / count))
    print(String(format: "%.6f", countOfZero / count))
}

plusMinus2(arr: [1,2,3,-1,-2,-3,0,0])
plusMinus2(arr: [-4,3,-9,0,4,1])

// ---------------------------------------------------------------------------------------------------------------
challengeOf("""
 Given five positive integers, find the minimum and maximum values that can be calculated by summing exactly four of the five integers. Then print the respective minimum and maximum values as a single line of two space-separated long integers.
""")

func miniMaxSum(arr: [Int]) -> Void {
    var sums :[Int] = []
    sums.append(arr[1] + arr[2] + arr[3] + arr[4])
    sums.append(arr[0] + arr[2] + arr[3] + arr[4])
    sums.append(arr[0] + arr[1] + arr[3] + arr[4])
    sums.append(arr[0] + arr[1] + arr[2] + arr[4])
    sums.append(arr[0] + arr[1] + arr[2] + arr[3])
    var max : Int = 0
    var min : Int = 0
    for v in sums {
        if sums[0] == v {
            max = v
            min = v
        }
        if v > max {
            max = v
        }
        if v < min {
            min = v
        }
    }
    print("\(min) \(max)")
}

miniMaxSum(arr: [1,2,3,4,5])
miniMaxSum(arr: [7,69,2,221,8974])

func miniMaxSum2(arr: [Int]) -> Void {
    var sums :[Int] = []
    for i in 0...arr.count - 1 {
        var newArray = arr
        newArray.remove(at: i)
        sums.append(newArray.reduce(0, +))
    }
    if let max = sums.max(),
       let min = sums.min() {
        print("\(min) \(max)")
    }
}

miniMaxSum2(arr: [1,2,3,4,5])
miniMaxSum2(arr: [7,69,2,221,8974])

func miniMaxSum3(arr: [Int]) -> Void {
    var sums :[Int] = []
    for i in 0...arr.count - 1 {
        var newArray : [Int]  = []
        for num in arr {
            if num != arr[i] {
                newArray.append(num)
            }
        }
        var valueForSumsArray = 0
        for v in newArray {
            valueForSumsArray += v
        }
        sums.append(valueForSumsArray)
    }
    if let max = sums.max(),
       let min = sums.min() {
        print("\(min) \(max)")
    }
}

miniMaxSum3(arr: [1,2,3,4,5])
miniMaxSum3(arr: [7,69,2,221,8974])

// ---------------------------------------------------------------------------------------------------------------
challengeOf("""
 Given a time in -hour AM/PM format, convert it to military (24-hour) time.
 Note: - 12:00:00AM on a 12-hour clock is 00:00:00 on a 24-hour clock.
 - 12:00:00PM on a 12-hour clock is 12:00:00 on a 24-hour clock.
""")

func timeConversion(s: String) -> String {
    let dateAsString = s
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "hh:mm:ssa"
    if let dateInput = dateFormatter.date(from: dateAsString) {
        dateFormatter.dateFormat = "HH:mm:ss"
        return  dateFormatter.string(from: dateInput)
    }
    return ""
}

let testDate24Military = timeConversion(s: "07:05:45PM")
print("testDate24Military : \(testDate24Military)")

// ---------------------------------------------------------------------------------------------------------------
challengeOf("""
The median of a list of numbers is essentailly is its middle element after sorting. The same number of elements occur after it as before. Given a list of numbers with an odd number of elements, find the median.
""")

func findMedian(arr: [Int]) -> Int {
    if arr.count % 2 == 0 {
        let twoMiddleValue = arr.sorted()[(arr.count / 2) + 1] + arr.sorted()[arr.count / 2]
        let twoMiddleValueDevideByTwo =  (Double(twoMiddleValue) / 2.0).rounded()
        return Int(twoMiddleValueDevideByTwo)
    } else {
        return arr.sorted()[(arr.count / 2) - 1]
    }
}

let testOddArray = [1,3,3,6,7,8,9]
let testEvenArray = [1,2,3,4,5,6,8,9]

let testOddArrayFindMedian = findMedian(arr: testOddArray)
let testEvenArrayFindMedian = findMedian(arr: testEvenArray)
print("testOddArrayFindMedian : \(testOddArrayFindMedian)")
print("testEvenArrayFindMedian : \(testEvenArrayFindMedian)")

endOfDay("May 18 2022")

// ---------------------------------------------------------------------------------------------------------------

greeting("May 19 2022")

challengeOf("""
Given an array of integers, where all elements but one occur twice, find the unique element.
Function Description
Complete the lonelyinteger function in the editor below.
lonelyinteger has the following parameter(s):
int a[n]: an array of integers
Returns
int: the element that occurs only once
""")

// TEST USING DICTIONARY
var capitalCity = ["Nepal": "Kathmandu", "England": "London"]
print("Initial Dictionary: ",capitalCity)
capitalCity["Japan"] = "Tokyo"
capitalCity["Thailand"] = "Bangkok"
print("Updated Dictionary: ",capitalCity)
print(capitalCity["Japan"] ?? "")
for (key, value) in capitalCity {
    print("(\(key),\(value))")
}

func lonelyinteger(a: [Int]) -> Int {
    var dictOfAandCount = [Int : Int]()
    for num in a {
        if let count = dictOfAandCount[num] {
            dictOfAandCount[num] = count + 1
        } else {
            dictOfAandCount[num] = 1
        }
    }
    var nReturnUniqueElement = a[0]
    for (key, value) in dictOfAandCount {
        if value == 1 {
            nReturnUniqueElement = key
        }
    }
    return nReturnUniqueElement
}

let testArrayLonelyInteger = [1, 2, 3, 4, 3, 2, 1]
let lonely = lonelyinteger(a: testArrayLonelyInteger)
print("\nLonely : \(lonely)")

// ---------------------------------------------------------------------------------------------------------------

challengeOf("""
Given a square matrix, calculate the absolute difference between the sums of its diagonals.
For example, the square matrix  is shown below:
1 2 3
4 5 6
9 8 9
The left-to-right diagonal = . The right to left diagonal = . Their absolute difference is .
Function description
Complete the  function in the editor below.
diagonalDifference takes the following parameter:
int arr[n][m]: an array of integers
Return
int: the absolute diagonal difference
Input Format
The first line contains a single integer, , the number of rows and columns in the square matrix .
Each of the next  lines describes a row, , and consists of  space-separated integers .
Constraints
Output Format
Return the absolute difference between the sums of the matrix's two diagonals as a single integer.
""")

let matrix = [[1,2,3], [4,5,6], [7,8,9]]
let testMatrix = matrix[0][1]
let testDiagonalDifferenceArray = [[11,2,4], [4,5,6], [10,8,-12]]

// This first function is not correct if the array have more than 3 arrays
func diagonalDifference(arr: [[Int]]) -> Int {
    let sumOfLeftToRight = arr[0][0] + arr[1][1] + arr[2][2]
    let sumOfRightToLeft = arr[0][2] + arr[1][1] + arr[2][0]
    if sumOfLeftToRight > sumOfRightToLeft {
        return sumOfLeftToRight - sumOfRightToLeft
    } else {
        return sumOfRightToLeft - sumOfLeftToRight
    }
}

func diagonalDifference2(arr: [[Int]]) -> Int {
    var sumOfLeftToRight = 0
    var sumOfRightToLeft = 0
    for i in 0...arr.count - 1 {
        sumOfLeftToRight += arr[i][i]
        sumOfRightToLeft += arr[i][(arr.count - 1 - i)]
    }
    if sumOfLeftToRight > sumOfRightToLeft {
        return sumOfLeftToRight - sumOfRightToLeft
    } else {
        return sumOfRightToLeft - sumOfLeftToRight
    }
}

let resultOfDiagonalDifference = diagonalDifference(arr: testDiagonalDifferenceArray)
let resultOfDiagonalDifference2  = diagonalDifference2(arr: testDiagonalDifferenceArray)
print("resultOfDiagonalDifference : \(resultOfDiagonalDifference)")
print("resultOfDiagonalDifference2 : \(resultOfDiagonalDifference2)")


// ---------------------------------------------------------------------------------------------------------------

challengeOf("""
Comparison Sorting
Quicksort usually has a running time of , but is there an algorithm that can sort even faster? In general, this is not possible. Most sorting algorithms are comparison sorts, i.e. they sort a list just by comparing the elements to one another. A comparison sort algorithm cannot beat  (worst-case) running time, since  represents the minimum number of comparisons needed to know where to place each element. For more details, you can see these notes (PDF).
Alternative Sorting
Another sorting method, the counting sort, does not require comparison. Instead, you create an integer array whose index range covers the entire range of values in your array to sort. Each time a value occurs in the original array, you increment the counter at that index. At the end, run through your counting array, printing the value of each non-zero valued index that number of times.
Example

All of the values are in the range , so create an array of zeros, . The results of each iteration follow:
i    arr[i]    result
0    1    [0, 1, 0, 0]
1    1    [0, 2, 0, 0]
2    3    [0, 2, 0, 1]
3    2    [0, 2, 1, 1]
4    1    [0, 3, 1, 1]
The frequency array is . These values can be used to create the sorted array as well: .
Note
For this exercise, always return a frequency array with 100 elements. The example above shows only the first 4 elements, the remainder being zeros.
Challenge
Given a list of integers, count and return the number of times each value appears as an array of integers.
Function Description
Complete the countingSort function in the editor below.
countingSort has the following parameter(s):
arr[n]: an array of integers
Returns
int[100]: a frequency array
Sample Input
100
63 25 73 1 98 73 56 84 86 57 16 83 8 25 81 56 9 53 98 67 99 12 83 89 80 91 39 86 76 85 74 39 25 90 59 10 94 32 44 3 89 30 27 79 46 96 27 32 18 21 92 69 81 40 40 34 68 78 24 87 42 69 23 41 78 22 6 90 99 89 50 30 20 1 43 3 70 95 33 46 44 9 69 48 33 60 65 16 82 67 61 32 21 79 75 75 13 87 70 33
Sample Output
0 2 0 2 0 0 1 0 1 2 1 0 1 1 0 0 2 0 1 0 1 2 1 1 1 3 0 2 0 0 2 0 3 3 1 0 0 0 0 2 2 1 1 1 2 0 2 0 1 0 1 0 0 1 0 0 2 1 0 1 1 1 0 1 0 1 0 2 1 3 2 0 0 2 1 2 1 0 2 2 1 2 1 2 1 1 2 2 0 3 2 1 1 0 1 1 1 0 2 2
Explanation
Each of the resulting values  represents the number of times  appeared in .
""")

let testArrayCountingSort = [1,1,3,2,1]

let testGetNewArrayString = "63 25 73 1 98 73 56 84 86 57 16 83 8 25 81 56 9 53 98 67 99 12 83 89 80 91 39 86 76 85 74 39 25 90 59 10 94 32 44 3 89 30 27 79 46 96 27 32 18 21 92 69 81 40 40 34 68 78 24 87 42 69 23 41 78 22 6 90 99 89 50 30 20 1 43 3 70 95 33 46 44 9 69 48 33 60 65 16 82 67 61 32 21 79 75 75 13 87 70 33"
let toArray = testGetNewArrayString.components(separatedBy: " ")
print("toArray : \(toArray)")
var intArray: [Int] = []
for e in toArray {
    //let intE = Int(e) ?? 0
    intArray.append(Int(e) ?? 0)
}

func countingSort(arr: [Int]) -> [Int] {
    let newArr = arr.sorted()
    var nReturnArray : [Int] = []
    if let last = newArr.last {
        for _ in 0...last {
            nReturnArray.append(0)
        }
        print(last)
        for i in 0...last {
            for n in newArr {
                if n == i {
                    nReturnArray[i] = nReturnArray[i] + 1
                } else {
                    
                    nReturnArray[i] = nReturnArray[i]
                }
            }
        }
    }
    return nReturnArray
}

let testCountingSort = countingSort(arr: testArrayCountingSort)
let testLongCountingSort = countingSort(arr: intArray)


// ---------------------------------------------------------------------------------------------------------------

challengeOf("""

""")
