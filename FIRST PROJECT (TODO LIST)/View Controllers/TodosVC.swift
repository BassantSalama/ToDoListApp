

import UIKit
import CoreData

class TodosVC: UIViewController {
    
    
    var todosArray:[ToDo] = []
    
        
        
    @IBOutlet weak var todosTabelView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.todosArray = todoStorage.getTodos()
        todosTabelView.dataSource = self
        todosTabelView.delegate = self
        
        // New Todo Notification
        NotificationCenter.default.addObserver(self, selector: #selector(addNewTodo), name: NSNotification.Name("addNewTodo"), object: nil)
        // Edit Todo Notificatio
        NotificationCenter.default.addObserver(self, selector: #selector(CurrentTodoEdited), name: NSNotification.Name ("CurrentTodoEdited"), object: nil)
        
        // Delet Todo Notification
        NotificationCenter.default.addObserver(self, selector: #selector(deletTodo), name: NSNotification.Name ("TodoDeleted"), object: nil)
    }
    
    @objc func addNewTodo(notification : Notification){
        if let myTodo = notification.userInfo?["addedTodo"] as?  ToDo {
            
            todosArray.append(myTodo)
            todosTabelView.reloadData()
            todoStorage.storeTodo(todo: myTodo)
            
        }
        
    }
    
    @objc  func CurrentTodoEdited (notification : Notification){
        if let todo = notification.userInfo?["EditedTodo"] as? ToDo{
            if let index = notification.userInfo?["editTodoIndex"] as? Int{
                
                
                todosArray[index] = todo
                todosTabelView.reloadData()
                todoStorage.updateTodo(todo: todo, index: index)
            }
        }
        
    }
    
    @objc  func deletTodo (notification : Notification){
        
        if let index = notification.userInfo?["TodoDeletedIndex"] as? Int{
            
            todosArray.remove(at: index)
            todosTabelView.reloadData()
            todoStorage.deletTodoFromDatabase(index: index)
        }
    }
    
    
    
    
    
    
    
    
    
    
   
    
    
    
    
    
}
    
    


extension TodosVC : UITableViewDataSource ,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todosArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell") as! TodoCell
        
        let todoArr = todosArray[indexPath.row]
        cell.todoTitleLabel.text = todoArr.title
        cell.todoImageView.image = todoArr.image
        cell.todoImageView.layer.cornerRadius = cell.todoImageView.frame.width/2
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let todo = todosArray[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "detailsVc") as? DeatailsVC
        
        if  let viwecontroller = vc {
            viwecontroller.todo = todo
            viwecontroller.index = indexPath.row
            
            navigationController?.pushViewController(viwecontroller, animated: true)
        }
    }
}
