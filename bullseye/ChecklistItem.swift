import Foundation

class ChecklistItem {
    var text = ""
    var checked = false
    var symbol = ""
    
    func toggleChecked() {
        checked = !checked
    }
}
