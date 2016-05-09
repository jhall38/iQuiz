//
//  Model.swift
//  iQuiz
//
//  Created by Joshua Hall on 5/8/16.
//  Copyright © 2016 Joshua Hall. All rights reserved.
//

import Foundation
import UIKit

struct QuizQuestion{
    var question : String
    var answers: [String] 
    var correctAnswer: Int
    
    init(question: String, answers: [String], correctAnswer: Int){
        self.question = question
        self.answers = answers
        self.correctAnswer = correctAnswer
    }
    
    func answerQuestion(answer : Int) -> Bool{
        return answer == correctAnswer
    }
}

class Quiz{
    var name : String
    var desc : String
    var image : UIImage
    var questions : [QuizQuestion]
    var score : Int
    
    init(name: String, desc: String, image: UIImage, questions: [QuizQuestion]){
        self.name = name
        self.desc = desc
        self.image = image
        self.questions = questions
        self.score = 0
    }
}

