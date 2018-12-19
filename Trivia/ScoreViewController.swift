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

    @IBAction func submitScoreButtonTapped(_ sender: Any) {
        
        // submit score
        ResultController.shared.submitScore(result: result)
        submitScoreButton.isEnabled = false
    }
}
