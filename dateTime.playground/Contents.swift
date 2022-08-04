import UIKit

var greeting = "Hello, playground"

extension String {
    func toDate() -> Date? {
        let formats = ["MM/dd/yyyy hh:mm:ss a",
                       "yyyy-MM-dd hh:mm:ss a",
                       "MMddyyyy",
                       "yyyyMMdd",
                       "yyyy-MM-dd'T'HH:mm:ss.SSS",
                       "MM/dd/yyyy",
                       "yyyy-MM-dd'T'HH:mm:ss'Z'"]
        // 2021-12-22T23:12:24Z
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
    }
    
    func toString(format: DateFormatType) -> String{
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

let test = "2022-02-04T17:08:22Z".toDate()?.toString(format: .monthDayYearWithTimestampForId) ?? ""
let testDate = "2022-02-04T17:08:22Z".toDate()
let testToLocal = dateTimeStatus(date: test)
let testDateToLocalFromDateExtension = testDate?.utcDateToLocalDateInString().toDate()
let testDateToLocalDate = testDate?.utcDateToLocalDateInDate()
let tolocal = "2022-02-04T18:02:16Z".toDate()?.utcDateToLocalDateInDate()
let tolocal1 = "0022-02-04T18:02:16Z".toDate()?.utcDateToLocalDateInDate()
let tolocal2 = " ".toDate()?.utcDateToLocalDateInDate()


