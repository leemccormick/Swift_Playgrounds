import UIKit

var greeting = "Hello, playground"


// MARK: - Int Extension
extension Int {
    // 27.toStringByAddZeroToFront(numberOfDigits: 2) ==> "0027"
    func toStringByAddZeroToFront(numberOfDigits: Int) -> String? {
        var nReturnVal:  String?
        let strNum = String(self)
        if numberOfDigits > strNum.count {
        let addedDigits = numberOfDigits - strNum.count
            var jointStr = ""
            for _ in 0..<addedDigits {
              jointStr += "0"
            }
            nReturnVal = jointStr + strNum
            return nReturnVal
        } else if numberOfDigits == strNum.count {
            return strNum
        } else {
            print("Unable to convert \(strNum) to \(numberOfDigits) digit number with 0 in the front.")
            return nReturnVal
        }
    }
}


import CommonCrypto

extension Data {
    // MARK: - SHA256 ==> SHA-256 is a patented cryptographic hash function that outputs a value that is 256 bits long. What is hashing? In encryption, data is transformed into a secure format that is unreadable unless the recipient has a key. In its encrypted form, the data may be of unlimited size, often just as long as when unencrypted.
    public func sha256() -> String{
        return hexStringFromData(input: digest(input: self as NSData))
    }
    
    private func digest(input : NSData) -> NSData {
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        var hash = [UInt8](repeating: 0, count: digestLength)
        CC_SHA256(input.bytes, UInt32(input.length), &hash)
        return NSData(bytes: hash, length: digestLength)
    }
    
    private  func hexStringFromData(input: NSData) -> String {
        var bytes = [UInt8](repeating: 0, count: input.length)
        input.getBytes(&bytes, length: input.length)
        var hexString = ""
        for byte in bytes {
            hexString += String(format:"%02x", UInt8(byte))
        }
        return hexString
    }
}

extension String {
    // MARK: - SHA256 ==> SHA-256 is a patented cryptographic hash function that outputs a value that is 256 bits long. What is hashing? In encryption, data is transformed into a secure format that is unreadable unless the recipient has a key. In its encrypted form, the data may be of unlimited size, often just as long as when unencrypted.
    func sha256() -> String? {
        if let stringData = self.data(using: String.Encoding.utf8) {
            return stringData.sha256()
        } else {
            return nil
        }
    }
}

// MARK: - SHA256 ==> calculateHash(input: ["0001500270000027", "766052", "1234"])
func calculateHash(input: [String]) -> String {
    var nReturnVal: String = ""
    for i in input {
        if let str = i.sha256() {
            nReturnVal += str
        }
    }
    return nReturnVal
}

