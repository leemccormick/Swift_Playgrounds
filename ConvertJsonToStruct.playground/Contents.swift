import UIKit

var greeting = "Hello, playground"

let jsonString = """
{"firstName":"Sergey","lastName":"Kargopolov","email":"test21@test.com","userId":"7fc0631b-7116-4d41-8d87-78f97b4dc543"}
"""
struct UserResponseModel: Decodable  {
    let firstName: String
    let lastName: String
    let email: String
    let userId: String
}
// Convert JSON String to Data
let data = Data(jsonString.utf8)
// Function to parse JSON
func parseJSON(data: Data) -> UserResponseModel? {
    
    var returnValue: UserResponseModel?
    do {
        returnValue = try JSONDecoder().decode(UserResponseModel.self, from: data)
    } catch {
        print("Error took place: \(error.localizedDescription).")
    }
    
    return returnValue
}
if let userModel = parseJSON(data: data) {
    print(" userId = \(userModel.userId)")
}

/*
 https://www.appsdeveloperblog.com/convert-json-to-swift-class-or-struct/
 */


extension Int {
    var toString: String {
        return String(self)
    }
}

0.toString
