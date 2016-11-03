//  Copyright (c) 2016 Shiba Praveen. All rights reserved.

import Foundation

private enum Constants {
    enum Regex {
        static let mentions = "@\\w+"
        static let emoticons = "\\([a-zA-Z0-9]{1,15}\\)"
    }
}

extension String {

    var length: Int {
        return self.characters.count
    }

    /**
     Finds matches for the passed regex and can manipulates output depending on output range.
     
     - parameter regex: A regex string.
     
     - parameter outputRange: A tupple containing trim left and trim right params to indicate characters to be trimmed from left and right in output match.
     
     - returns: An array of strings that matches the regex pattern.
     */
    func matches(forRegex regex: String, outputRange: (trimLeft: Int, trimRight: Int)) -> [String] {
        if let mentionsRegex = try? NSRegularExpression(pattern: regex, options: .CaseInsensitive) {
            let matches = mentionsRegex.matchesInString(self, options: [], range: NSRange(location: 0, length: self.length))
            return matches.map { (self as NSString).substringWithRange(NSMakeRange($0.range.location + outputRange.trimLeft, $0.range.length - (outputRange.trimLeft + outputRange.trimRight))) }
        }
        return []
    }

    /// Returns a string array of emoticons in the string (excluding the round braces)
    func filterEmoticons() -> [String] {
        return self.matches(forRegex: Constants.Regex.emoticons, outputRange: (1,1))
    }

    /// Returns a string array of mentions in the string
    func filterMentions() -> [String]  {
        return self.matches(forRegex: Constants.Regex.mentions, outputRange: (1,0))
    }

    /// Returns a string array of links in the string
    func filterLinks() -> [String] {
        if let detector = try? NSDataDetector(types: NSTextCheckingType.Link.rawValue) {
            let matches = detector.matchesInString(self, options: [], range: NSRange(location: 0, length: self.length))
            return matches.map { (self as NSString).substringWithRange($0.range) }
        }
        return []
    }
}
