
import UIKit
import CoreData

class todoStorage {
    
   static func storeTodo(todo: ToDo){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate  else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        guard let todtEntity = NSEntityDescription.entity(forEntityName: "Todo", in: managedContext) else { return }
        
        let todoRecord = NSManagedObject.init(entity: todtEntity , insertInto: managedContext)
        todoRecord.setValue(todo.title, forKey: "title")
        todoRecord.setValue(todo.details, forKey: "details")
        
        if let image = todo.image{
            let imagData = image.pngData()
            todoRecord.setValue(imagData, forKey: "image")
        }
        
        
        do {
            try managedContext.save()
        }catch{
            print("=======Erorr=======")
        }
    }
    static  func updateTodo(todo: ToDo, index: Int){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate  else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Todo")
        
        do{
            let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            
            result[index].setValue(todo.title, forKey: "title")
            result[index].setValue(todo.details, forKey: "details")
            if let image = todo.image{
                 let storedImageData = image.pngData()
                result[index].setValue(storedImageData, forKey: "image")
            }
            try managedContext.save()
        
        
    }catch{
            print("=====Error====: \(error.localizedDescription)")
        }
       
        
    }
    
    static  func deletTodoFromDatabase(index: Int){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate  else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Todo")
        
        do{
            let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            let todoToDelet = result[index]
            managedContext.delete(todoToDelet)
            try managedContext.save()
        
        
    }catch{
            print("=====Error====")
        }
       
        
    }
    
    static func getTodos() -> [ToDo]{
        var todos: [ToDo] = []
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate  else {return []}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Todo")
        
        do{
            let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            
            for managedTodo in result {
                let _ = managedTodo.value(forKey: "title") as? String
                let _ = managedTodo.value(forKey: "details")as? String
                
                var todoImage: UIImage? = nil
                if let storedImageData = managedTodo.value(forKey: "image") as? Data{
                    todoImage = UIImage(data: storedImageData)
                }
                let todo = ToDo(title: "title" ,image:  todoImage, details: "details" )
                    todos.append(todo)
                    
            }
            
        }catch{
            print("=====Error====")
        }
        return todos
    }
    
    
}
