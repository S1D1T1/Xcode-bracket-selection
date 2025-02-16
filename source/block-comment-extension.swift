import Foundation
import XcodeKit

class BlockCommentCommand: NSObject, XCSourceEditorCommand {
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void) {
        guard let buffer = invocation.buffer else {
            completionHandler(nil)
            return
        }
        
        // Get the current selection
        guard let selections = buffer.selections as? [XCSourceTextRange],
              let selection = selections.first else {
            completionHandler(nil)
            return
        }
        
        // Expand selection to entire lines
        let startLine = selection.start.line
        let endLine = selection.end.line
        
        // Function to comment a line
        func commentLine(_ lineIndex: Int) {
            if lineIndex < buffer.lines.count {
                let line = buffer.lines[lineIndex] as! String
                buffer.lines[lineIndex] = "//" + line
            }
        }
        
        // Comment the first and last lines
        commentLine(startLine)
        if startLine != endLine {
            commentLine(endLine)
        }
        
        completionHandler(nil)
    }
}
