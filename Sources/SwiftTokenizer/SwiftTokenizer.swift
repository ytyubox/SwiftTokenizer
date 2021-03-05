import Foundation
struct SwiftTokenizer {
    let sourceString:String
    
    func wordTokens() -> [String] {
        let cfString = sourceString as CFString
        let locale = CFLocaleCopyCurrent()
        let range = CFRangeMake(0, CFStringGetLength(cfString))
        let tokenizer = CFStringTokenizerCreate(
            kCFAllocatorDefault,
            cfString, range,
                kCFStringTokenizerUnitWordBoundary
//                kCFStringTokenizerUnitSentence
            ,
            locale)
        
        var tokens = [String]()
        var tokenType = CFStringTokenizerAdvanceToNextToken(tokenizer)
        dump(tokenType)
        while true {
            if tokenType.isEmpty {break}
            let range = CFStringTokenizerGetCurrentTokenRange(tokenizer)
            let token = CFStringCreateWithSubstring(kCFAllocatorDefault, cfString, range)
            tokens.append(token! as String)
            tokenType = CFStringTokenizerAdvanceToNextToken(tokenizer)
        }
        
        return tokens
    }
    
    func separatedStringWithSeparator(separator: String) -> String {
        return (self.wordTokens() as NSArray).componentsJoined(by: separator)
    }
}
