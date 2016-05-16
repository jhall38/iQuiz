//
//  ResultsViewController.swift
//  iQuiz
//
//  Created by Joshua Hall on 5/15/16.
//  Copyright © 2016 Joshua Hall. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var quiz : Quiz = Quiz(name: "No Quiz", desc: "error", image: UIImage(named: "math.png")!, questions: [QuizQuestion(question: "no Question", answers: ["no answers"], correctAnswer: 1)])

    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var score: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        score.text = "Score: " + String(quiz.score) + " out of " + String(quiz.questions.count)
        if(quiz.score == quiz.questions.count){
            desc.text = "Perfect!"
        }
        else if(quiz.score == 0){
            desc.text = "You are Horrible!"
        }
        else{
            desc.text = "Almost!"
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func takeAnother(sender: AnyObject) {
        let nextVC: QuizesTableViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Quizes") as! QuizesTableViewController
        self.navigationController?.pushViewController(nextVC, animated: true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
