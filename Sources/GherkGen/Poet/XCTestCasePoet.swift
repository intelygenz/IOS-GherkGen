import Foundation
import GherkParser

struct FileXCTest {
    var fileName: String
    var feature: FeatureXCTest
}

struct FeatureXCTest {
    var className: String
    var background: ScenarioXCTest?
    var scenarios: [ScenarioXCTest]
}

struct ScenarioXCTest {
    var testName: String
    var steps: [StepXCTest]
}

struct StepXCTest {
    var tag: String
    var name: String
}

class XCTestCasePoet {
    static func write(_ file: FileXCTest, _ folder: URL, _ skipIfExists: Bool, _ failAsDefault: Bool) -> Bool {
        let fileURL = folder.appending(file.fileName)
        if fileURL.fileExists && skipIfExists { return false }
        
        if fileURL.fileExists { fileURL.delete() }
        fileURL.dump(file.feature.contents(failAsDefault))
        return true
    }
}

extension Feature {
    func toFileXCTest() -> FileXCTest {
        FileXCTest(fileName: "\(featureDescription.camelCaseify).swift",
                   feature: toFeatureXCTest())
    }
    
    func toFeatureXCTest() -> FeatureXCTest {
        FeatureXCTest(className: featureDescription.camelCaseify,
                      background: background?.toScenarioXCTest(),
                      scenarios: scenarios.map { $0.toScenarioXCTest() })
    }
}

extension Scenario {
    func toScenarioXCTest() -> ScenarioXCTest {
        ScenarioXCTest(testName: "test\(scenarioDescription.camelCaseify)", steps: stepDescriptions.map { $0.toStepXCTest() })
    }

}

extension Step {
    func toStepXCTest() -> StepXCTest {
        StepXCTest(tag: tag.lowercased(), name: name.replacingOccurrences(of: "\"", with: "\\\""))
    }
}
