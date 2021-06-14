# GherkGen

GherkGen is a command line tool that is able to generate a set of FeatureXCTestCase for a given set of .feature.
The tool is not including the files inside the Xcode project. This should be done manually or by using another tool to generate the Xcode project like [Tuist](https://tuist.io/).

## How to use
```
GherkGen
Tool to generate FeatureXCTestCase stubs

     ["-h", "--help"]             Show this help
     ["-i", "--inputFeatures"]    Path to a single feature or a folder of features
     ["-o", "--outputFolder"]     Path to a folder where the tests will be created
     ["-f", "--force"]            Overwrite previously generated files
     ["-fd", "--failAsDefault"]   Implements steps with XCTFail("TODO")

```
Example: `GherkGen --inputFeatures {PATH_FEATURE_FOLDER|FILE} --outputFolder {PATH_OUTPUT_FOLDER} --force --failAsDefault`


