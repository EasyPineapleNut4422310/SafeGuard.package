import Foundation

public struct ScanResult {
public let suspiciousFiles: [String]
public let findings: [String]


public init(suspiciousFiles: [String], findings: [String]) {
    self.suspiciousFiles = suspiciousFiles
    self.findings = findings
}


}

public final class SafeGuardScanner {


public init() {}

public func scan(at path: String) -> ScanResult {
    let fileManager = FileManager.default
    
    guard let enumerator = fileManager.enumerator(atPath: path) else {
        return ScanResult(
            suspiciousFiles: [],
            findings: ["Failed to read directory"]
        )
    }
    
    var suspiciousFiles: [String] = []
    var findings: [String] = []
    
    let suspiciousExtensions = ["sh", "exe", "bat", "js"]
    let suspiciousKeywords = [
        "eval(",
        "base64",
        "exec(",
        "token",
        "password",
        "apikey"
    ]
    
    for case let file as String in enumerator {
        
        if suspiciousExtensions.contains(where: {
            file.lowercased().hasSuffix(".\($0)")
        }) {
            suspiciousFiles.append(file)
        }
        
        let fullPath = "\(path)/\(file)"
        
        if let content = try? String(contentsOfFile: fullPath) {
            let lower = content.lowercased()
            
            for keyword in suspiciousKeywords where lower.contains(keyword) {
                findings.append("'\(keyword)' found in \(file)")
            }
        }
    }
    
    return ScanResult(
        suspiciousFiles: suspiciousFiles,
        findings: findings
    )
}


}
