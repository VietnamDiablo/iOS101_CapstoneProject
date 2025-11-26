//
//  SessionComposeViewController.swift
//  GetFit
//
//  Created by Enrique Camou Villa on 25/11/25.
//

import UIKit

class SessionComposeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var sessionName: UITextField!
    
    @IBOutlet weak var sessionDescription: UITextField!
    
    @IBOutlet weak var sessionCategory: UIPickerView!
    
    @IBOutlet weak var workoutOne: UITextField!
    @IBOutlet weak var workoutTwo: UITextField!
    @IBOutlet weak var workoutThree: UITextField!
    @IBOutlet weak var workoutFour: UITextField!
    
    let categories = ["Arm", "Leg", "Chest", "Back", "Shoulder"]
    var selectedCategory: String = "Arm"

    var sessionToEdit: Session?
    var onComposeSession: ((Session) -> Void)? = nil
        
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return categories[row]
        }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            selectedCategory = categories[row]
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sessionCategory.delegate = self
        sessionCategory.dataSource = self
                
                // If editing, populate fields
                if let session = sessionToEdit {
                    sessionName.text = session.title
                    sessionDescription.text = session.description
                    if let category = session.category,
                       let index = categories.firstIndex(of: category) {
                        sessionCategory.selectRow(index, inComponent: 0, animated: false)
                        selectedCategory = category
                    }
                    workoutOne.text = session.workoutOne
                    workoutTwo.text = session.workoutTwo
                    workoutThree.text = session.workoutThree
                    workoutFour.text = session.workoutFour
                }
        let doneButton = UIBarButtonItem(title: "Done",style: .done, target: self, action: #selector(didTapButton))
            navigationItem.rightBarButtonItem = doneButton    }


    
    // When a new task is created (or an existing task is edited), this closure is called
    // passing in the task as an argument so it can be used by whoever presented the TaskComposeViewController.

    
    @IBAction func didTapButton(_ sender: Any) {
        print("Done button tapped")
        guard let title = sessionName.text,
              !title.isEmpty
        else {
            // i.
            presentAlert(title: "Oops...", message: "Make sure to add a title!")
            // ii.
            return
        }

        var session: Session
                if let editSession = sessionToEdit {
                    // Update existing
                    session = editSession
                    session.title = title
                    session.description = sessionDescription.text ?? ""
                    session.category = selectedCategory
                    session.workoutOne = workoutOne.text ?? ""
                    session.workoutTwo = workoutTwo.text ?? ""
                    session.workoutThree = workoutThree.text ?? ""
                    session.workoutFour = workoutFour.text ?? ""
                } else {
                    // Create new (use minimal initializer you already had)
                    session = Session(title: title,
                                      description: sessionDescription.text ?? "",
                                      category: selectedCategory)
                    // Attach workouts (if Session stores them as optional strings)
                    session.workoutOne = workoutOne.text ?? ""
                    session.workoutTwo = workoutTwo.text ?? ""
                    session.workoutThree = workoutThree.text ?? ""
                    session.workoutFour = workoutFour.text ?? ""
                }

        onComposeSession?(session)
        session.addSession()
        performSegue(withIdentifier: "DoneSegue", sender: nil)
    }
    
    private func presentAlert(title: String, message: String) {
        // 1.
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        // 2.
        let okAction = UIAlertAction(title: "OK", style: .default)
        // 3.
        alertController.addAction(okAction)
        // 4.
        present(alertController, animated: true)
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func didTapCancel(_ sender: Any) {
        performSegue(withIdentifier: "DoneSegue", sender: nil)    }

}
