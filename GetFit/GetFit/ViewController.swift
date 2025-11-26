//
//  ViewController.swift
//  GetFit
//
//  Created by Enrique Camou Villa on 24/11/25.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var sessions: [Session] = [
        Session(
            title: "Monday Leg Workout",
            description: "Leg workout focusing on hamstrings and glutes.",
            category: "Leg",
            workoutOne: "Romanian Deadlift – 4x8",
            workoutTwo: "Leg Press – 4x12",
            workoutThree: "Hamstring Curls – 3x15",
            workoutFour: "Walking Lunges – 3x20 steps"
        ),

        Session(
            title: "Tuesday Chest & Triceps",
            description: "Push-day session focused on strength and upper-body size.",
            category: "Chest",
            workoutOne: "Bench Press – 4x6",
            workoutTwo: "Incline Dumbbell Press – 4x10",
            workoutThree: "Cable Flyes – 3x12",
            workoutFour: "Tricep Rope Pushdown – 3x15"
        ),

        Session(
            title: "Friday Back & Biceps",
            description: "Pull-day workout designed to improve back width and grip strength.",
            category: "Back",
            workoutOne: "Lat Pulldown – 4x10",
            workoutTwo: "Seated Row – 4x12",
            workoutThree: "Barbell Deadlift – 3x5",
            workoutFour: "EZ Bar Curls – 3x12"
        )
    ]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessions.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SessionCell", for: indexPath) as! SessionCell

        
        let session = sessions[indexPath.row]

        cell.cellTitle.text = session.title
        cell.cellBio.text = session.description
            
        return cell
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var emptyStateLabel: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
                        
        tableView.tableHeaderView = UIView()
        
        tableView.dataSource = self
        
        tableView.delegate = self
        
        navigationController?.navigationBar.prefersLargeTitles = true

    }
    
    private func refreshSessions(){
        var sessions = Session.getSessions()
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
           // This method enables the unwind segue
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ComposeSessionSegue"{
            if let composeVC = segue.destination as?  SessionComposeViewController {
                composeVC.onComposeSession = { [weak self] session in
                    
                    self?.sessions.append(session)
                    
                    self?.tableView.reloadData()
                    print("Session added: \(session.title)")
                    
                }
            }
            
        } else if segue.identifier == "toDetail" {
            let detailVC = segue.destination as! DetailViewController
                   
                   // however you're getting the selected item
                   if let index = tableView.indexPathForSelectedRow?.row {
                       detailVC.session = sessions[index]   
                   }
               
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("viewWillAppear called")

        
        // Set up the closure when returning to this view
        if let tabBarController = self.tabBarController,
           let viewControllers = tabBarController.viewControllers {
            
            for vc in viewControllers {
                if let composeVC = vc as? SessionComposeViewController {
                    composeVC.onComposeSession = { [weak self] session in
                        self?.sessions.append(session)
                        self?.tableView.reloadData()
                        print("Session added: \(session.title)")
                    }
                } else if let navVC = vc as? UINavigationController,
                         let composeVC = navVC.viewControllers.first as? SessionComposeViewController {
                    composeVC.onComposeSession = { [weak self] session in
                        self?.sessions.append(session)
                        self?.tableView.reloadData()
                        print("Session added: \(session.title)")
                    }
                }
            }
        }
    }
    
}

