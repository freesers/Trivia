//
//  ViewController.swift
//  Trivia
//
//  Created by Sander de Vries on 12/12/2018.
//  Copyright © 2018 Sander de Vries. All rights reserved.
//

import UIKit
import HTMLString

class QuestionViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answerAButton: UIButton!
    @IBOutlet weak var answerBButton: UIButton!
    @IBOutlet weak var answerCButton: UIButton!
    @IBOutlet weak var answerDButton: UIButton!
    
    @IBOutlet weak var triviaProgress: UIProgressView!
    var progress: Float = 0.0
    
    var questions: [Question]!
    var questionCounter = 0 {
        didSet {
            progress = Float(questionCounter) / Float(questions.count)
            print(questionCounter)
        }
    }
    
    var correctAnswers = 0
    var incorrectAnswers = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // update button's corners
        self.answerAButton.layer.cornerRadius = 7.0
        self.answerBButton.layer.cornerRadius = 7.0
        self.answerCButton.layer.cornerRadius = 7.0
        self.answerDButton.layer.cornerRadius = 7.0
        
        // setup view
        triviaProgress.setProgress(progress, animated: true)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        // load questions
        QuestionController.shared.fetchTriviaQuestions { (questions) in
            if let questions = questions {
                self.questions = questions
            }
            DispatchQueue.main.async {
                self.updateUI(with: self.questions) {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
        }
    }
    
    func updateUI(with questions: [Question], completion: @escaping () -> Void) {
        let index = self.questionCounter

        // update title and question
        self.title = "Question #\(index + 1)"
        self.questionLabel.text = questions[index].question.removingHTMLEntities
        
        // shuffle answers
        let answers = self.randomizeQuestions(correct: questions[index].correctAnswer, incorrect: questions[index].incorrectAnswers)
        
        // replace special html characters with correct text
        self.answerAButton.setTitle(answers[0].removingHTMLEntities, for: .normal)
        self.answerBButton.setTitle(answers[1].removingHTMLEntities, for: .normal)
        self.answerCButton.setTitle(answers[2].removingHTMLEntities, for: .normal)
        self.answerDButton.setTitle(answers[3].removingHTMLEntities, for: .normal)

        triviaProgress.setProgress(progress, animated: true)
        completion()
    }
    
    /// arranges questions in random order before setting buttons
    func randomizeQuestions(correct: String, incorrect: [String]) -> [String] {
        var questionsArray = [String]()
        questionsArray.append(correct)
        questionsArray += incorrect
        questionsArray.shuffle()
        return questionsArray
    }
    
    /// checks answer, animates the button and view
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        transformButton(button: sender)

        
        if questionCounter != questions.count - 1 {
            if sender.currentTitle == questions[questionCounter].correctAnswer {
                correctOrIncorrect()
                questionCounter += 1
                updateUI(with: questions) { () -> Void in
                    self.correctAnswers += 1
                }
            } else {
                correctOrIncorrect(color: .red)
                questionCounter += 1
                updateUI(with: questions) {
                    self.incorrectAnswers += 1
                }
            }
        }
        
        // last question
        else {
            if sender.currentTitle == questions[questionCounter].correctAnswer {
                correctOrIncorrect()
                correctAnswers += 1
            } else {
                correctOrIncorrect(color: .red)
            }
            performSegue(withIdentifier: "ScoreSegue", sender: nil)
        }
    }
    
    /// animates the backgroundview green or red
    func correctOrIncorrect(color: UIColor = .green) {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.backgroundColor = color
        }) { (_) in
            UIView.animate(withDuration: 0.3, animations: {
                self.view.backgroundColor = .white
            })
        }
    }
    
    /// animates the button to indicate pressed
    func transformButton(button: UIButton) {
        UIView.animate(withDuration: 0.3) {
            button.transform = CGAffineTransform(scaleX: 1.5, y: 3)
            button.transform = CGAffineTransform.identity
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ScoreSegue" {
            let tabBarController = segue.destination as! UITabBarController
            let scoreViewController = tabBarController.viewControllers?[0] as! ScoreViewController
            scoreViewController.correctAnswers = correctAnswers
            scoreViewController.totalQuestions = questions.count
        }
    }
    
    @IBAction func unwindToStart(segue: UIStoryboardSegue) {
        progress = 0
        questionCounter = 0
        correctAnswers = 0
        incorrectAnswers = 0
        
        
        triviaProgress.setProgress(progress, animated: true)
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        QuestionController.shared.fetchTriviaQuestions { (questions) in
            if let questions = questions {
                self.questions = questions
            }
            
            DispatchQueue.main.async {
                self.updateUI(with: self.questions) {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
        }
    }
}







