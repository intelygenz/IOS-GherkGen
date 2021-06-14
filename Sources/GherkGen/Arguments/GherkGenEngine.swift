import Foundation
import GherkParser

class GherkGenEngine {
    
    static func printHelp() {
        print(GherkGen.appInfo)
        print()
        GherkGen.commands.forEach{ print("\(String(repeating: " ", count: 5))\($0.tags)\(String(repeating: " ", count: 5))\($0.description)") }
        print()
    }
    
    static func printError(_ arguments: [String: [String]], _ error: Error? = nil, _ message: String) {
        if let error = error { print(error) }
        print(message)
        print(arguments)
        print()
        printHelp()
    }
    
    static func generate(_ features: URL,_ output: URL, _ force: Bool, _ failAsDefault: Bool) {
        let parser = GherkParser()
        do {
            try parser.parse(features).forEach{
                let generated = XCTestCasePoet.write($0.toFileXCTest(), output, !force, failAsDefault)
                print("* Generating \($0.featureDescription) - \(generated ? "OK" : "SKIP")")
            }
            print("* All Done")
        } catch {
            printError([String:[String]](), error, "")
        }
    }
}
