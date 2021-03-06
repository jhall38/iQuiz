//
//  QuizQuestionTableViewController.swift
//  iQuiz
//
//  Created by Joshua Hall on 5/15/16.
//  Copyright © 2016 Joshua Hall. All rights reserved.
//

import UIKit

class QuizQuestionTableViewController: UITableViewController {
    
    var thisQuestion : QuizQuestion = QuizQuestion(question: "no Question", answers: ["no answers"], correctAnswer: 1)
    var quiz : Quiz = Quiz(name: "No Quiz", desc: "error", image: UIImage(named: "math.png")!, questions: [QuizQuestion(question: "no Question", answers: ["no answers"], correctAnswer: 1)])
    var questionIndex : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        question.text = thisQuestion.question

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    @IBOutlet weak var question: UILabel!
    
    @IBAction func submit(sender: AnyObject) {
        if(tableView.indexPathForSelectedRow?.row != nil){
            var correct : Bool = false
            if(thisQuestion.answerQuestion((tableView.indexPathForSelectedRow?.row)!)){
                quiz.score += 1
                correct = true
            }
            let nextVC: QuizAnswerViewController = self.storyboard?.instantiateViewControllerWithIdentifier("QuizAnswer") as! QuizAnswerViewController
            nextVC.quiz = quiz
            nextVC.thisQuestion = thisQuestion
            nextVC.questionIndex = questionIndex
            nextVC.correct = correct
            
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Answer Cell", forIndexPath: indexPath)

        // Configure the cell...
        NSLog(String(indexPath.row))
        let thisAns = thisQuestion.answers[indexPath.row]
        cell.textLabel?.text = thisAns;
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
