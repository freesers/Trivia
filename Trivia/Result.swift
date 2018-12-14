//
//  Result.swift
//  Trivia
//
//  Created by Sander de Vries on 14/12/2018.
//  Copyright © 2018 Sander de Vries. All rights reserved.
//

import Foundation

struct Result: CustomStringConvertible{
    
    var correct: Int
    var total: Int
    var time: String
    
    var description: String {
        return "correct=\(correct)&total=\(total)&time=\(time)"
    }
    
    
}
