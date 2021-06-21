import Foundation


class ArgumentsProcessor {
    private var currentPath: String { FileManager.default.currentDirectoryPath }
    let map: [String: [String]]
    
    init(_ arguments: [String]) {
        self.map = ArgumentsProcessor.toMap(Array(arguments.dropFirst()))
    }
    
    func getBool(_ command: Command) -> Bool { command.tags.first(where: { map.keys.contains($0) } ) != nil }
    
    func getURL(_ command: Command) -> URL? {
        guard let tag = command.tags.first(where: { map.keys.contains($0)}), let list = map[tag] else { return nil }
        guard let path = list.first, let url = URL.conform(currentPath, path) else { return nil }
        return url
    }
    
    private static func toMap(_ arguments: [String]) -> [String: [String]] {
        var map = [String: [String]]()
        var values = [String]()
        var key = ""
        var args = arguments
        while !args.isEmpty {
            let arg = args.removeFirst()
            if arg.starts(with: "-") {
                if !key.isEmpty {
                    map[key] = values
                    key = ""
                    values = [String]()
                }
                key = arg
            } else {
                values.append(arg)
            }
        }
        map[key] = values
        return map
    }
}



extension URL {
    static func conform(_ location: String, _ path: String) -> URL? {
        guard let url = (URL.filePath(path) ?? URL.filePath(location)?.appending(path)), url.fileExists else { return nil }
        return url
    }
    
    static func filePath(_ path: String) -> URL? {
        guard let url = URL(string: "file:///\(path)"), url.fileExists else { return nil }
        return url
    }
}
