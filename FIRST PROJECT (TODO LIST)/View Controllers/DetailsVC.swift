

import UIKit

class DeatailsVC: UIViewController {
    
    var todo :ToDo!
    var index : Int!
    
    
    @IBOutlet weak var detailsLabel: UILabel!
    
    
    @IBOutlet weak var todoImage: UIImageView!
    
    
    @IBOutlet weak var todoLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        setupUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(CurrentTodoEdited), name: NSNotification.Name ("CurrentTodoEdited"), object: nil)
        
        
    }
    
    @objc  func CurrentTodoEdited (notification : Notification){
        if let todo = notification.userInfo?["EditedTodo"] as? ToDo{
            self.todo = todo
            setupUI()
            
            
        }
        
    }
    func setupUI() {
        detailsLabel.text = todo.details
        todoLabel.text = todo.title
        todoImage.image = todo.image
        
    }
    
    
    
    @IBAction func editButtonClicked(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        
        if let vc = storyboard.instantiateViewController(withIdentifier: "NewTodoVC") as? NewTodoVC {
            
            vc.isCreationScreen = false
            vc.editTodo = todo
            vc.editTodoIndex = index
            
            
            
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    
    
    @IBAction func deletButtonClicked(_ sender: Any) {
        
        
        let confirmAlrt = UIAlertController(title: "Alrt", message: "are you sure you want to delet Todo", preferredStyle: UIAlertController.Style.alert )
        
        let confirmAction = UIAlertAction(title: "Delet it", style: UIAlertAction.Style.destructive) { alrt in
            
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "TodoDeleted"), object: nil ,userInfo: ["TodoDeletedIndex" : self.index! ])
            
            
            
            let alert = UIAlertController(title: "Todo deleted", message:"Todo is deleted successfully", preferredStyle: UIAlertController.Style.alert)
            
            let closeAction = UIAlertAction(title: "Close", style: UIAlertAction.Style.default) { _ in
                self.navigationController?.popViewController(animated: true)
            }
            
            
            
            alert.addAction(closeAction)
            self.present(alert, animated: true)
            
            
        }
        
        confirmAlrt.addAction(confirmAction)
        
        
        let cancleAction = UIAlertAction(title: "Cancle", style: UIAlertAction.Style.default , handler: nil)
        
        confirmAlrt.addAction(cancleAction)
        
        present(confirmAlrt, animated: true)
    }
        
        
        
        
        
    
}
