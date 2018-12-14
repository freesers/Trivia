//
//  Question.swift
//  Trivia
//
//  Created by Sander de Vries on 13/12/2018.
//  Copyright © 2018 Sander de Vries. All rights reserved.
//

import Foundation

struct Question: Codable {
    
    let category: String
    let type: String
    let difficulty: String
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    
    enum CodingKeys: String, CodingKey {
        case category
        case type
        case difficulty
        case question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}

struct Questions: Codable {
    let responseCode: Int
    let triviaQuestions: [Question]
    
    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case triviaQuestions = "results"
    }
}
