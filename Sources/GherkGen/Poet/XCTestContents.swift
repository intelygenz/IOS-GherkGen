import Foundation

private class FeatureFile {
    static let CLASS_NAME = "[CLASS_NAME]"
    static let BACKGROUND = "[BACKGROUND]"
    static let SCENARIOS = "[SCENARIOS]"
    
    class Scenario {
        static let TEST_NAME = "[TEST_NAME]"
        static let STEPS = "[STEPS]"
        
        class Step {
            static let TAG = "[TEST_NAME]"
            static let STEP_NAME = "[STEP_NAME]"
            static let IMPLEMENTATION = "[IMPLEMENTATION]"
        }
    }

}


private let classCode = """
//Automatically generated file by GherkGen
import Foundation
import UITestRunner
import XCTest

class \(FeatureFile.CLASS_NAME): FeatureXCTestCase {

\(FeatureFile.BACKGROUND)

\(FeatureFile.SCENARIOS)

}

"""

private let backgroundCode = """
    override func background(_ builder: ScenarioBuilder) {
\(FeatureFile.Scenario.STEPS)
    }
"""

private let scenarioCode = """

    func \(FeatureFile.Scenario.TEST_NAME)() throws {
        try scenario {
\(FeatureFile.Scenario.STEPS)
        }
    }
"""
private let stepCode = """
            $0.\(FeatureFile.Scenario.Step.TAG)(\"\(FeatureFile.Scenario.Step.STEP_NAME)\") { \(FeatureFile.Scenario.Step.IMPLEMENTATION) }
"""

private let backgroundStepCode = """
        builder.\(FeatureFile.Scenario.Step.TAG)(\"\(FeatureFile.Scenario.Step.STEP_NAME)\") { \(FeatureFile.Scenario.Step.IMPLEMENTATION) }
"""

private let failImplementation = "XCTFail(\"TODO\")"

extension FeatureXCTest {
    func contents(_ failAsDefault: Bool) -> String {
        classCode.replacingOccurrences(of: FeatureFile.CLASS_NAME, with: className)
            .replacingOccurrences(of: FeatureFile.BACKGROUND, with: background?.backgroundContents(failAsDefault) ?? "")
            .replacingOccurrences(of: FeatureFile.SCENARIOS, with: scenarios.map{ $0.contents(failAsDefault) }.joined(separator: "\n"))
    }
}

extension ScenarioXCTest {

    func contents(_ failAsDefault: Bool) -> String {
        scenarioCode.replacingOccurrences(of: FeatureFile.Scenario.TEST_NAME, with: testName)
            .replacingOccurrences(of: FeatureFile.Scenario.STEPS, with: steps.map{ $0.contents(failAsDefault) }.joined(separator: "\n"))
    }
    
    func backgroundContents(_ failAsDefault: Bool) -> String {
        backgroundCode.replacingOccurrences(of: FeatureFile.Scenario.STEPS, with: steps.map{ $0.backgroundContents(failAsDefault) }.joined(separator: "\n"))
    }
    
}

extension StepXCTest {
    
    func contents(_ failAsDefault: Bool) -> String {
        stepCode.replacingOccurrences(of: FeatureFile.Scenario.Step.TAG, with: tag)
            .replacingOccurrences(of: FeatureFile.Scenario.Step.STEP_NAME, with: name)
            .replacingOccurrences(of: FeatureFile.Scenario.Step.IMPLEMENTATION, with: failAsDefault ? failImplementation : "")
    }
    
    func backgroundContents(_ failAsDefault: Bool) -> String {
        backgroundStepCode.replacingOccurrences(of: FeatureFile.Scenario.Step.TAG, with: tag)
            .replacingOccurrences(of: FeatureFile.Scenario.Step.STEP_NAME, with: name)
            .replacingOccurrences(of: FeatureFile.Scenario.Step.IMPLEMENTATION, with: failAsDefault ? failImplementation : "")
    }
    
}
