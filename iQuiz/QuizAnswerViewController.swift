//
//  QuizAnswerViewController.swift
//  iQuiz
//
//  Created by Joshua Hall on 5/15/16.
//  Copyright © 2016 Joshua Hall. All rights reserved.
//

import UIKit

class QuizAnswerViewController: UIViewController {
    
    var thisQuestion : QuizQuestion = QuizQuestion(question: "no Question", answers: ["no answers"], correctAnswer: 1)
    var quiz : Quiz = Quiz(name: "No Quiz", desc: "error", image: UIImage(named: "math.png")!, questions: [QuizQuestion(question: "no Question", answers: ["no answers"], correctAnswer: 1)])
    var questionIndex : Int = 0
    @IBOutlet weak var question: UILabel!
    var correct : Bool = false
    @IBOutlet weak var answer: UILabel!

    @IBOutlet weak var result: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        question.text = thisQuestion.question
        answer.text = "Correct Answer: " + thisQuestion.answers[thisQuestion.correctAnswer]
        if(correct){
            result.text = "Correct"
        }
        else{
            result.text = "Incorrect"
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextQuestion(sender: AnyObject) {
        if(questionIndex == quiz.questions.count - 1){
            let nextVC: ResultsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Results") as! ResultsViewController
            nextVC.quiz = quiz
            self.navigationController?.pushViewController(nextVC, animated: true)


        }
        else{
            let nextVC: QuizQuestionTableViewController = self.storyboard?.instantiateViewControllerWithIdentifier("QuizQuestion") as! QuizQuestionTableViewController
            nextVC.quiz = quiz
            nextVC.thisQuestion = quiz.questions[questionIndex+1]
            nextVC.questionIndex = questionIndex + 1
            self.navigationController?.pushViewController(nextVC, animated: true)


        }
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
