//
//  String+Extension.swift
//  Field Executive
//
//  Created by PHN MAC 1 on 23/11/23.
//

import Foundation

extension StringProtocol {
    var firstCapitalized: String { return prefix(1).capitalized + dropFirst() }
}

extension String {
    func formatDate(inputFormat: String, outputFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = outputFormat
            return dateFormatter.string(from: date)
        } else {
            return self
        }
    }
    
    func formatTime(inputFormat: String, outputFormat: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputFormat
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = outputFormat
        
        if let date = inputFormatter.date(from: self) {
            let outputTime = outputFormatter.string(from: date)
            return outputTime
        } else {
            return nil
        }
    }
    
    func extractYouTubeVideoID() -> String? {
        #if DEBUG
        print("URL ----> \(self)")
        #endif
        // Regular expression pattern for extracting YouTube video ID
        let pattern = "(?:(?:https?:\\/\\/)?(?:www\\.)?(?:youtube\\.com\\/\\S*?(?:\\/|\\b|\\?|&|=)|youtu\\.be\\/)([a-zA-Z0-9_-]{11}))"
        
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            let matches = regex.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
            
            if let match = matches.first {
                let range = match.range(at: 1)
                if let swiftRange = Range(range, in: self) {
                    return String(self[swiftRange])
                }
            }
        } catch {
            print("Error creating regular expression: \(error)")
        }
        
        return nil
    }
    
    func fileName() -> String {
        return URL(fileURLWithPath: self).deletingPathExtension().lastPathComponent
    }
    
    func fileExtension() -> String {
        return URL(fileURLWithPath: self).pathExtension
    }
    
    func isValidEmail() -> Bool {
        // Regular expression for email validation
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
    func isValidMobile() -> Bool{
        let phoneRegex = "^[6-9]\\d{9}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: self)
    }
    
    func isValidName() -> Bool{
        let name = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let set = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ")
        return (name.rangeOfCharacter(from: set.inverted) == nil )
    }
    
    func isValidNumber() -> Bool{
        let grade = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let set = CharacterSet(charactersIn: "0123456789").inverted
        return grade.rangeOfCharacter(from: set) == nil
    }
}


extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}

extension Double {
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}
