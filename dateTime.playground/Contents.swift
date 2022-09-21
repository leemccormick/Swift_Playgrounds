import UIKit

var greeting = "Hello, playground"

extension String {
    // This is about date formatter https://docs.oracle.com/javase/8/docs/api/java/time/format/DateTimeFormatter.html
    // https://www.datetimeformatter.com/how-to-format-date-time-in-swift/#:~:text=Date%20Time%20Formatting%20in%20Swift%20is%20based%20off,representations%20of%20dates%20and%20times%20into%20NSDate%20objects.
    func toDate() -> Date? {
        let formats = ["MM/dd/yyyy hh:mm:ss a",
                       "yyyy-MM-dd hh:mm:ss a",
                       "MMddyyyy",
                       "yyyyMMdd",
                       "yyyy-MM-dd'T'HH:mm:ss.SSS",
                       "MM/dd/yyyy",
                       "yyyy-MM-dd'T'HH:mm:ss'Z'",
                       "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"]
        
        var nReturnValDate: Date?
        for format in formats {
            nReturnValDate = getDateFromStringFormatter(format: format)
            if nReturnValDate != nil {
                return nReturnValDate
            }
        }
        return nReturnValDate
    }
    
    private func getDateFromStringFormatter(format: String) -> Date? {
        let format = format
        let date: String = self
        let isoDate = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: isoDate) else { return nil}
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour,.minute,.second], from: date)
        guard let finalDate = calendar.date(from:components) else  { return nil}
        return finalDate
    }
}

extension Date {
    enum DateFormatType: String {
        case fullNumericMDYNoTimestamp = "MM/dd/yyyy"
        case fullNumericTimestamp = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        case timestampWithAMorPM = "hh:mm:ss a"
        case monthDayYearWithTimestampForId = "MM/dd/yyyy hh:mm:ss a"
        case utcFormatterFromAPI = "yyyy-MM-ddTHH:mm:ssZ"
        case fullName = "MMMM dd',' yyyy"
        case year = "yyyy"
        case shortNameNoYear = "d MMM"
    }
    
    enum DateFormatTypeTest: String {
        case fullNameMonthDayYear = "MMMM dd',' yyyy"
        case numericMonthDayYear = "MM/dd/yyyy"
        case numericMonthDayYearWithTimestamp = "MM/dd/yyyy hh:mm:ss a"
        case numericYearMonthDayWithTimestamp = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        case timestampWithAMorPM = "hh:mm:ss a"
    }
    
    func toString(format: DateFormatType) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter.string(from: self)
    }
    
    func toString(format: DateFormatTypeTest) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter.string(from: self)
    }
    
    func localToUTC() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm:ss a"
        dateFormatter.calendar = Calendar.current
        dateFormatter.timeZone = TimeZone.current
        
        let  dateStr = self.toString(format: .utcFormatterFromAPI)
        if let date = dateFormatter.date(from: dateStr) {
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            dateFormatter.dateFormat = "yyyy-MM-ddTHH:mm:ssZ"
            
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    func utcDateToLocalDateInString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy hh:mm:ss a"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let date = self.toString(format: .monthDayYearWithTimestampForId)
        if let dt = dateFormatter.date(from: date) {
            dateFormatter.locale = Locale.current
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = "MM/dd/yy hh:mm:ss a"
            return dateFormatter.string(from: dt)
        } else {
            return "Unknown date"
        }
    }
    
    func utcDateToLocalDateInDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy hh:mm:ss a"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let date = self.toString(format: .monthDayYearWithTimestampForId)
        if let dt = dateFormatter.date(from: date) {
            dateFormatter.locale = Locale.current
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = "MM/dd/yy hh:mm:ss a"
            
            let strDate =  dateFormatter.string(from: dt)
            return strDate.toDate()
        } else {
            return nil
        }
    }
}

func dateTimeStatus(date: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yy hh:mm:ss a"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    if let dt = dateFormatter.date(from: date) {
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "MM/dd/yy hh:mm:ss a"
        
        return dateFormatter.string(from: dt)
    } else {
        return "Unknown date"
    }
}

extension Date {
    var toStringWithFullMonthNameDateAndYear : String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd',' yyyy"
        return formatter.string(from: self)
    }
}

let test = "2022-02-04T17:08:22Z".toDate()?.toString(format: .monthDayYearWithTimestampForId) ?? ""
let testDate = "2022-02-04T17:08:22Z".toDate()
let testToLocal = dateTimeStatus(date: test)
let testDateToLocalFromDateExtension = testDate?.utcDateToLocalDateInString().toDate()
let testDateToLocalDate = testDate?.utcDateToLocalDateInDate()
let tolocal = "2022-02-04T18:02:16Z".toDate()?.utcDateToLocalDateInDate()
let tolocal1 = "0022-02-04T18:02:16Z".toDate()?.utcDateToLocalDateInDate()
let tolocal2 = " ".toDate()?.utcDateToLocalDateInDate()

let datePurchased = "2022-09-13T15:53:44.580Z"
datePurchased.toDate()?.toString(format: .fullName)
datePurchased.toDate()?.toStringWithFullMonthNameDateAndYear
datePurchased.toDate()?.toString(format: .fullNumericMDYNoTimestamp)
datePurchased.toDate()?.toString(format: .fullNumericTimestamp)
datePurchased.toDate()?.toString(format: .monthDayYearWithTimestampForId)
datePurchased.toDate()?.toString(format: .utcFormatterFromAPI)
datePurchased.toDate()?.toString(format: .fullName)
datePurchased.toDate()?.toString(format: .fullNumericTimestamp)
datePurchased.toDate()?.toString(format: .fullName)
datePurchased.toDate()?.toString(format: .year)
datePurchased.toDate()?.toString(format: .shortNameNoYear)

let dateForTransaction = "2022-01-13T15:53:44.580Z"
let dateForTransaction2 = "2027-06-13T15:53:44.580Z"
dateForTransaction.toDate()?.toString(format: .year)
dateForTransaction.toDate()?.toString(format: .shortNameNoYear)
dateForTransaction2.toDate()?.toString(format: .year)
dateForTransaction2.toDate()?.toString(format: .shortNameNoYear)


let testDate0 = "2022-01-01T15:53:44.580Z".toDate()?.toString(format: .shortNameNoYear)
let testDate1 = "2022-02-04T15:53:44.580Z".toDate()?.toString(format: .shortNameNoYear)
let testDate2 = "2022-06-11T15:53:44.580Z".toDate()?.toString(format: .shortNameNoYear)
let testDate3 = "2022-12-31T15:53:44.580Z".toDate()?.toString(format: .shortNameNoYear)

"2022-05-13T15:53:44.580Z".toDate()?.toString(format: .shortNameNoYear)
"2022-06-13T15:53:44.580Z".toDate()?.toString(format: .shortNameNoYear)
"2022-07-13T15:53:44.580Z".toDate()?.toString(format: .shortNameNoYear)
"2022-08-13T15:53:44.580Z".toDate()?.toString(format: .shortNameNoYear)
"2022-09-13T15:53:44.580Z".toDate()?.toString(format: .shortNameNoYear)
"2022-10-13T15:53:44.580Z".toDate()?.toString(format: .shortNameNoYear)
"2022-11-13T15:53:44.580Z".toDate()?.toString(format: .shortNameNoYear)
"2022-12-13T15:53:44.580Z".toDate()?.toString(format: .shortNameNoYear)

// MARK: - Double Playground
extension Double {
    var toStringCurrentFormat: String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        let amount = formatter.string(from: NSNumber(value: self))
        return amount ?? "$0.00"
    }
}

let testHundredDouble = 100.0
let testDouble1 = 22.333
let testDouble2: Double = 224
testHundredDouble.toStringCurrentFormat
testDouble1.toStringCurrentFormat
testDouble2.toStringCurrentFormat

