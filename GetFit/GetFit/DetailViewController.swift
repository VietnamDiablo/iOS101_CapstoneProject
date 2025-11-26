//
//  DetailViewController.swift
//  GetFit
//
//  Created by Enrique Camou Villa on 25/11/25.
//

import UIKit

class DetailViewController: UIViewController {

    var session: Session!

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var bioLabel: UILabel!
    
    @IBOutlet weak var category: UILabel!
    
    @IBOutlet weak var workoutOne: UILabel!
    
    @IBOutlet weak var workoutTwo: UILabel!
    
    @IBOutlet weak var workoutThree: UILabel!
    
    @IBOutlet weak var workoutFour: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = session.title
        bioLabel.text = session.description
        category.text = session.category
        workoutOne.text = session.workoutOne
        workoutTwo.text = session.workoutTwo
        workoutThree.text = session.workoutThree
        workoutFour.text = session.workoutFour
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
