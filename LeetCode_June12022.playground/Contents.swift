import UIKit

func greeting(_ date: String)  {
    print("\n")
    print("--------------------- Hello, LeetCode on \(date) : You can do this challeges --------------------- ")
    print("\n")
}

func endOfDay(_ date: String) {
    print("\n")
    print("--------------------- End Of \(date) : Keep Going Animal Coder --------------------- ")
    print("\n")
}

func challengeOf(_ info: String) {
    print("\n------------------------------------------ LeetCode ------------------------------------------")
    print(info)
    print("-------------------------------------------------------------------------------------------------\n")
}


greeting("June 1 2022")

// ---------------------------------------------------------------------------------------------------------------
challengeOf("""
Given an integer array nums sorted in non-decreasing order, remove the duplicates in-place such that each unique element appears only once. The relative order of the elements should be kept the same.

Since it is impossible to change the length of the array in some languages, you must instead have the result be placed in the first part of the array nums. More formally, if there are k elements after removing the duplicates, then the first k elements of nums should hold the final result. It does not matter what you leave beyond the first k elements.

Return k after placing the final result in the first k slots of nums.

Do not allocate extra space for another array. You must do this by modifying the input array in-place with O(1) extra memory.

Custom Judge:

The judge will test your solution with the following code:

int[] nums = [...]; // Input array
int[] expectedNums = [...]; // The expected answer with correct length

int k = removeDuplicates(nums); // Calls your implementation

assert k == expectedNums.length;
for (int i = 0; i < k; i++) {
    assert nums[i] == expectedNums[i];
}
If all assertions pass, then your solution will be accepted.

 

Example 1:

Input: nums = [1,1,2]
Output: 2, nums = [1,2,_]
Explanation: Your function should return k = 2, with the first two elements of nums being 1 and 2 respectively.
It does not matter what you leave beyond the returned k (hence they are underscores).
Example 2:

Input: nums = [0,0,1,1,1,2,2,3,3,4]
Output: 5, nums = [0,1,2,3,4,_,_,_,_,_]
Explanation: Your function should return k = 5, with the first five elements of nums being 0, 1, 2, 3, and 4 respectively.
It does not matter what you leave beyond the returned k (hence they are underscores).
""")


// ---------------------------------------------------------------------------------------------------------------
challengeOf("""
Implement strStr().

Given two strings needle and haystack, return the index of the first occurrence of needle in haystack, or -1 if needle is not part of haystack.

Clarification:

What should we return when needle is an empty string? This is a great question to ask during an interview.

For the purpose of this problem, we will return 0 when needle is an empty string. This is consistent to C's strstr() and Java's indexOf().

 

Example 1:

Input: haystack = "hello", needle = "ll"
Output: 2
Example 2:

Input: haystack = "aaaaa", needle = "bba"
Output: -1
""")


// ---------------------------------------------------------------------------------------------------------------
challengeOf("""
Search Insert Position
Given a sorted array of distinct integers and a target value, return the index if the target is found. If not, return the index where it would be if it were inserted in order.

You must write an algorithm with O(log n) runtime complexity.

Example 1:

Input: nums = [1,3,5,6], target = 5
Output: 2
Example 2:

Input: nums = [1,3,5,6], target = 2
Output: 1
Example 3:

Input: nums = [1,3,5,6], target = 7
Output: 4
""")

func searchInsert(_ nums: [Int], _ target: Int) -> Int {
    var nReturn: Int = 0
    var lastNum = nums[0]
    for i in 0...nums.count - 1 {
        if nums[i] == target {
            nReturn =  i
            break
        } else if lastNum > target {
            nReturn =  i
            break
        } else if lastNum < target && target <= nums[i] {
            nReturn =  i
            break
        } else if i == nums.count - 1{
            nReturn = i + 1
            break
        } else {
            lastNum = nums[i]
        }
    }
    return nReturn
}

searchInsert([1,3,5,6],  5)
searchInsert([1,3,5,6],  2)
searchInsert([1,3,5,6],  7)
searchInsert([1,3,5,6],  0)

// ---------------------------------------------------------------------------------------------------------------
challengeOf("""
Given an array of integers nums sorted in non-decreasing order, find the starting and ending position of a given target value.

If target is not found in the array, return [-1, -1].

You must write an algorithm with O(log n) runtime complexity.

Example 1:

Input: nums = [5,7,7,8,8,10], target = 8
Output: [3,4]
Example 2:

Input: nums = [5,7,7,8,8,10], target = 6
Output: [-1,-1]
Example 3:

Input: nums = [], target = 0
Output: [-1,-1]
""")


func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
    var nReturnArray: [Int] = []
    if nums.isEmpty {
        nReturnArray = [-1,-1]
    } else {
        for i in 0...nums.count - 1 {
            if nums[i] == target {
                nReturnArray.append(i)
            }
        }
        
        if nReturnArray.count == 0 {
            nReturnArray = [-1,-1]
        }
        if nReturnArray.count == 1 {
            nReturnArray.append(nReturnArray[0])
        }
    }
    return nReturnArray
}

searchRange([], 0)
searchRange([5,7,7,8,8,10], 8)
searchRange([5,7,7,8,8,10], 6)
searchRange([1], 1)
