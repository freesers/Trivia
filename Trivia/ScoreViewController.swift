//
//  ScoreViewController.swift
//  Trivia
//
//  Created by Sander de Vries on 14/12/2018.
//  Copyright © 2018 Sander de Vries. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    
    var correctAnswers: Int!
    var totalQuestions: Int!
    
    @IBOutlet weak var submitScoreButton: UIButton!
    
    //var delegate: SubmitScoreDelegate?
    
    var result: Result!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupDelegate()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        
        
        if let correct = correctAnswers,
            let total = totalQuestions {
            scoreLabel.text = "You scored a \(correct) out of \(total)!"
            result = Result(correct: correct, total: total, time: dateString)
        }
    }
    
//    func setupDelegate() {
//        if let navController = tabBarController?.viewControllers?.last as? UINavigationController,
//            let leaderboardViewController = navController.viewControllers.first as? LeaderboardTableViewController {
//           // delegate = leaderboardViewController
//        }
//        
//    }

    @IBAction func submitScoreButtonTapped(_ sender: Any) {
//        if let result = result {
//            delegate?.submit(result: result)
//        }
        ResultController.shared.submitScore(result: result)
        
        submitScoreButton.isEnabled = false
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
