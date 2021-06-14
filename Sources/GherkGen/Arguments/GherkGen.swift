import Foundation

struct Command { let tags: [String]; let description: String }
class GherkGen {

    static let appInfo = "GherkGen\nTool to generate FeatureXCTestCase stubs"
    static let help = Command(tags: ["-h", "--help"], description: "Show this help")
    static let input = Command(tags: ["-i", "--inputFeatures"], description: "Path to a single feature or a folder of features")
    static let output = Command(tags: ["-o", "--outputFolder"], description: "Path to a folder where the tests will be created")
    static let force = Command(tags: ["-f", "--force"], description: "Overwrite previously generated files")
    static let failAsDefault = Command(tags: ["-fd", "--failAsDefault"], description: "Implement steps with XCTFail(\"TODO\")")
    
    static let commands = [help, input, output, force, failAsDefault]
    
    static func launch(_ arguments: [String]) {
        let processor = ArgumentsProcessor(arguments)
        guard !processor.getBool(help) else { GherkGenEngine.printHelp(); return }
        guard let input = processor.getURL(input) else { GherkGenEngine.printError(processor.map,nil, "Couldn't find valid path for --inputFeatures"); return }
        guard let output = processor.getURL(output) else { GherkGenEngine.printError(processor.map,nil, "Couldn't find valid path for --outputFolder"); return }
        GherkGenEngine.generate(input, output, processor.getBool(force), processor.getBool(failAsDefault))
    }
    

    
}



