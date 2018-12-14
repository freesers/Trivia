//
//  QuestionController.swift
//  Trivia
//
//  Created by Sander de Vries on 13/12/2018.
//  Copyright © 2018 Sander de Vries. All rights reserved.
//

import Foundation

class QuestionController {
    static let shared = QuestionController()
    
    // url linked to science & nature, meduium, multiple choice, 10 questions
    let url = URL(string: "https://opentdb.com/api.php?amount=10&category=17&difficulty=medium&type=multiple")!
    
    func fetchTriviaQuestions(completion: @escaping ([Question]?) -> Void) {
        
        let decoder = JSONDecoder()
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
                let questions = try? decoder.decode(Questions.self, from: data) {
                completion(questions.triviaQuestions)
            }
        }
        task.resume()
    }
}
