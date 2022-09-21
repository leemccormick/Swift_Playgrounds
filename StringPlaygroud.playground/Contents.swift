import UIKit

var greeting = "Hello, playground"


extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
    
    var toBool: Bool {
        if self.lowercased() == "true" {
            return true
        } else {
            return false
        }
    }
    
    var decodeBase64 : UIImage {
        if let decData = Data(base64Encoded: self, options: .ignoreUnknownCharacters), self.count > 0 {
            return UIImage(data: decData) ?? UIImage()
        }
        return UIImage()
    }
    
    private static var digitsPattern = UnicodeScalar("0")..."9"
    var digits: String {
        return unicodeScalars.filter { String.digitsPattern ~= $0 }.string
    }
    
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
    
    func currencyFormatting() -> String {
        if let value = Double(self) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.maximumFractionDigits = 2
            formatter.minimumFractionDigits = 2
            if let str = formatter.string(for: value) {
                return str
            }
        }
        return ""
    }
    
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
    
    func hideTextAndShowLastCharacters(_ numberOfLastCharToShow: Int) -> String {
        let start = self.startIndex
        let end = self.index(self.endIndex, offsetBy: -numberOfLastCharToShow)
        let result = self.replacingCharacters(in: start..<end, with: "******")
        return result
    }
}

extension Sequence where Iterator.Element == UnicodeScalar {
    var string: String { return String(String.UnicodeScalarView(self)) }
}



let at = " 62 --- OF application(_:didRegisterForRemoteNotificationsWithDeviceToken:) --- IN /Users/m3tsllc/Desktop/RMS/RMS Mobile iOS/RMSiOS/Resources/AppDelegate.swift"
let seperateAt = at.components(separatedBy: "--- IN")
let firstAt = seperateAt.first
let newAt = firstAt?.replacingOccurrences(of: "---", with: "|")

// MARK: - NOTE
/*
 let str = "Hello, playground"
 print(str.substring(from: 7))         // playground
 print(str.substring(to: 5))           // Hello
 print(str.substring(with: 7..<11))    // play
 */

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
let testDouble3 = 345.67
let testDouble4: Double = 1234
let testDouble5 = 1234.45
let testDouble6: Double = 2342
let testDouble7 = 134.343
let testDouble8: Double = 13431
testHundredDouble.toStringCurrentFormat
testDouble1.toStringCurrentFormat
testDouble2.toStringCurrentFormat

let testDouble1CentPosition = testDouble1.toStringCurrentFormat.count - 3
let testSubstringTo = testDouble1.toStringCurrentFormat.substring(to: testDouble1CentPosition)
let testSubstringTo2 = testDouble2.toStringCurrentFormat.substring(to: testDouble2.toStringCurrentFormat.count - 3)
let testSubstringFrom2 = testDouble2.toStringCurrentFormat.substring(from: testDouble2.toStringCurrentFormat.count - 3)
let testSubstringFrom = testDouble1.toStringCurrentFormat.substring(from: 2)

extension Double {
    var toDollarAmount: String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        let amount = formatter.string(from: NSNumber(value: self))
        return amount ?? "$0.00"
    }
    
    var dollarsAndCents: (dollar: String, cent: String) {
        var amount = ("$0",".00")
        let dollarInStringFormat = self.toDollarAmount
        let last3Postion = dollarInStringFormat.count - 3
        let dollars = dollarInStringFormat.substring(to: last3Postion)
        let cents = dollarInStringFormat.substring(from: last3Postion)
        amount = (dollars,cents)
        return amount
    }
}

testHundredDouble.dollarsAndCents
testDouble1.dollarsAndCents
testDouble2.dollarsAndCents
testDouble3.dollarsAndCents
testDouble4.dollarsAndCents
testDouble5.dollarsAndCents
testDouble6.dollarsAndCents
testDouble7.dollarsAndCents
testDouble8.dollarsAndCents

let testAmount0 = 90834.00.dollarsAndCents.dollar
let testAmount1 = 123.11.dollarsAndCents.dollar
let testAmount2 = 2345.67.dollarsAndCents.dollar
let testAmount3 = 678.90.dollarsAndCents.dollar

90834.00.dollarsAndCents.cent
123.11.dollarsAndCents.cent
2345.67.dollarsAndCents.cent
678.90.dollarsAndCents.cent

