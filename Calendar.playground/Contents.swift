import UIKit

var greeting = "Hello, Calender"

let date = Date()
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "yyyy"
let yearString = dateFormatter.string(from: date)

dateFormatter.dateFormat = "LLLL"
let monthString = dateFormatter.string(from: date)

let calendar = Calendar.current
let components = calendar.dateComponents([.month], from: date)
let month = components.month

var dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: date)
dateComponents.day = 8
dateComponents.month = 8
dateComponents.year = 1989

let newDate = Calendar.current.date(from: dateComponents) ?? Date()

let componentsDayOfMonth = Calendar.current.dateComponents([.day], from: newDate)
let dayInt = componentsDayOfMonth.day ?? 0
let componentsMonth = Calendar.current.dateComponents([.month], from: newDate)
let monthInt = componentsMonth.month ?? 0
let componentsYear = Calendar.current.dateComponents([.year], from: newDate)
let yearInt = componentsYear.year ?? 0

print("dayInt : \(dayInt) | monthInt : \(monthInt) | yearInt : \(yearInt)")


let currentMonth = Calendar.current.date(byAdding: .month, value: 1, to: Date())

print(currentMonth)

let dateRange: ClosedRange<Date> = {
    let today = Date()
    let aHunderdYearsAgoFromToday = Calendar.current.date(byAdding: .year, value: -100, to: Date()) ?? Date()
    return aHunderdYearsAgoFromToday...today
}()
print("dateRange  upperBound: \(dateRange.upperBound)")
print("dateRange lowerBound : \(dateRange.lowerBound)")

let yearRange: [Int] = {
    let today = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy"
    var currentYear = Int(dateFormatter.string(from: today)) ?? 0
    var years: [Int] = [currentYear]
    for _ in 0..<100 {
        currentYear -= 1
        years.append(currentYear)
    }
    return years
}()

print("yearRange : \(yearRange)")


func datesRange(from: Date, to: Date) -> [Date] {
    print("from : \(from) | to : \(to)")
    if from > to { return [Date]() }
    var tempDate = from
    var array = [tempDate]
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy"
    var tempYearInt = Int(dateFormatter.string(from: from)) ?? 0
    var arrayOfYears: [Int] = [tempYearInt]
    while tempDate < to {
        tempDate = Calendar.current.date(byAdding: .year, value: 1, to: tempDate)!
        print("tampDate : \(tempDate)")
        tempYearInt += 1
        array.append(tempDate)
        arrayOfYears.append(tempYearInt)
    }
    return array
}

let dates = datesRange(from: dateRange.lowerBound, to: dateRange.upperBound)

func yearsFrom(datesRange: ClosedRange<Date>) -> [Int] {
    print("from : \(datesRange.lowerBound) | to : \(datesRange.upperBound)")
    if datesRange.lowerBound > datesRange.upperBound { return [] }
    var tempDate = datesRange.lowerBound
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy"
    var tempYearInt = Int(dateFormatter.string(from: tempDate)) ?? 0
    var arrayOfYears: [Int] = [tempYearInt]
    
    while tempDate <= datesRange.upperBound {
        tempYearInt += 1
        arrayOfYears.append(tempYearInt)
        tempDate = Calendar.current.date(byAdding: .year, value: 1, to: tempDate)!
        print("tampDate : \(tempDate)")
    }
    print("--------------------- arrray Of year ------------ arrayOfYears : \(arrayOfYears.count)")
    return arrayOfYears.reversed()
}


let yearsArray = yearsFrom(datesRange: dateRange)
print("yearsArray : \(yearsArray) | yearsArray : \(yearsArray.count)")

extension Date {
    func getAllDates() -> [Date] {
        let calender = Calendar.current
        // geting start date....
        let startDate = calender.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
        let range = calender.range(of: .day, in: .month, for: startDate)!
        // range.removeLast()
        // getting date...
        return range.compactMap { day  in
            return calender.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}

// MARK: - DateValue
struct DateValue: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
}

func getCurrentMount() -> Date {
    let calender = Calendar.current
    // Getting Current Month Date...
    guard let currentMonth = calender.date(byAdding: .month, value: 1, to: Date()) else { return Date()}
    
    return currentMonth
}

func extractDate() -> [DateValue]{
    let calender = Calendar.current
    // Getting Current Month Date...
    var dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: date)
    dateComponents.day = 10
    dateComponents.month = 12
    dateComponents.year = 1989
    
    let newDate = Calendar.current.date(from: dateComponents)
    let currentMonth = newDate ?? Date()//getCurrentMount()
    var days =  currentMonth.getAllDates().compactMap { date -> DateValue in
        // getting day...
        let day = calender.component(.day, from: date)
        return DateValue(day: day, date: date)
    }
    
    // adding offset days to get exact week day...
    let firstWeekday = calender.component(.weekday, from: days.first?.date ?? Date())
    
    for _ in 0..<firstWeekday - 1 {
        days.insert(DateValue(day: -1, date: Date()), at: 0)
    }
    
    print(days)
    return days
}


extractDate()
/* Source :
 - https://www.zerotoappstore.com/get-year-month-day-from-date-swift.html
 
 */
