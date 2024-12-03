

import UIKit

class NewTodoVC: UIViewController {
    
    var isCreationScreen = true
    var editTodo:ToDo?
    var editTodoIndex : Int?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var addButtonClicked: UIButton!
    @IBOutlet weak var descrptionTextView: UITextView!
    @IBOutlet weak var todoImageView: UIImageView!
    


    override func viewDidLoad() {
        super.viewDidLoad()
         
        if !isCreationScreen  {
            addButtonClicked.setTitle("Edit", for: .normal)
            navigationItem.title = "Edit Todo"
            if let todo = editTodo {
                
                titleTextField.text = todo.title
                descrptionTextView.text = todo.details
                todoImageView.image = todo.image
            }
            
        }
        

    }
    
    
    
    
    
    @IBAction func changeButtonClicked(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        present(imagePicker, animated: true )
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .savedPhotosAlbum
       
        present(imagePicker, animated: true)
    }
    

    @IBAction func addButtonCliked(_ sender: Any) {
        if isCreationScreen{
            let todo = ToDo(title: titleTextField.text!, image: todoImageView.image, details: descrptionTextView.text)
            NotificationCenter.default.post(name: NSNotification.Name("addNewTodo"), object: nil , userInfo: ["addedTodo": todo] )
            
            let alert = UIAlertController(title: "Todo Added", message:"Todo is Added successfully", preferredStyle: UIAlertController.Style.alert)
            
            let closeAction = UIAlertAction(title: "Close", style: UIAlertAction.Style.default) { _ in
                self.tabBarController?.selectedIndex = 0
                self.titleTextField.text = ""
                   self.descrptionTextView.text = ""
            }
            
            
            alert.addAction(closeAction)
            present(alert, animated: true)
            
        }else{ // VC is opened for Edit (not for creat)
            
            let todo = ToDo(title: titleTextField.text!, image: todoImageView.image, details: descrptionTextView.text)
            
            NotificationCenter.default.post(name: NSNotification.Name("CurrentTodoEdited"), object: nil ,userInfo: ["EditedTodo" : todo ,"editTodoIndex" : editTodoIndex!])
            
            
            
            let alert = UIAlertController(title: "Todo Edited", message:"Todo is Edited successfully", preferredStyle: UIAlertController.Style.alert)
            
            let closeAction = UIAlertAction(title: "Close", style: UIAlertAction.Style.default) { _ in
                self.navigationController?.popViewController(animated: true)
              
                
            }
            
            
            alert.addAction(closeAction)
            present(alert, animated: true)
            
            
        }
        
    }
}

extension NewTodoVC:  UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    

        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
     
        // i will ask why originalImage work and editedImage doesnot work
      // todoImageView.image = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        
        dismiss(animated: true)
        todoImageView.image = image
    }
}
