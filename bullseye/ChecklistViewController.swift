import UIKit

protocol ChecklistViewControllerDelegate: class {
//    func checklistViewControllerDidCancel(_ controller: ChecklistViewController);
    func checklistViewController(_ controller: ChecklistViewController, didFinishEditing items: [ChecklistItem])
}

class ChecklistViewController: UITableViewController {
    
var items = [ChecklistItem]()
    var itemlist:[String] = [""]
    
     weak var delegate: ChecklistViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
            let item1 = ChecklistItem()
            item1.text = "Addition (+)"
            item1.symbol = "+"
            item1.checked = true
            items.append(item1)
            
            let item2 = ChecklistItem()
            item2.text = "Subtraction (-)"
            item2.symbol = "-"
            item2.checked = true
            items.append(item2)
            
            let item3 = ChecklistItem()
            item3.text = "Multiplication (*)"
            item3.symbol = "*"
            item3.checked = true
            items.append(item3)
            
            let item4 = ChecklistItem()
            item4.text = "Division (/)"
            item4.symbol = "/"
            item4.checked = true
            items.append(item4)
    }
    
    @IBAction func done() {
        for item in items{
            if(item.checked == true)
            {
                delegate?.checklistViewController(self, didFinishEditing: items)
            }
        }
    }
    
    func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
        if item.checked
        {
            cell.accessoryType = .checkmark
        }
        else
        {
            cell.accessoryType = .none
        }
    }
    
    func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
    
    // MARK:- Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
            
            let item = items[indexPath.row]
            
            configureText(for: cell, with: item)
            configureCheckmark(for: cell, with: item)
            return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    // MARK:- Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath)
        {
            items[indexPath.row].toggleChecked()
            let item = items[indexPath.row]
            
            configureCheckmark(for: cell, with: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

