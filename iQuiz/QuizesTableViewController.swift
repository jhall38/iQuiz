//
//  QuizesTableViewController.swift
//  iQuiz
//
//  Created by Joshua Hall on 5/8/16.
//  Copyright © 2016 Joshua Hall. All rights reserved.
//

import UIKit

class QuizesTableViewController: UITableViewController {
    var ScienceQuizQuestions : [QuizQuestion] = [QuizQuestion(question: "What is fire?", answers: ["true", "false", "false", "false"], correctAnswer: 1)]
    var MarvelQuizQuestions : [QuizQuestion] = [QuizQuestion(question: "What is marvel?", answers: ["true", "false", "false", "false"], correctAnswer: 1), QuizQuestion(question: "What is marvel 2?", answers: ["true", "false", "false", "false"], correctAnswer: 1) ]
    var MathQuizQuestions : [QuizQuestion] = [QuizQuestion(question: "What is 2+2?", answers: ["1", "2", "3", "4"], correctAnswer: 4)]
    var quizes : [Quiz] = [Quiz(name: "Science!", desc: "Because SCIENCE!", image: UIImage(named: "science.jpg")!, questions: [QuizQuestion(question: "What is fire?", answers: ["true", "false", "false", "false"], correctAnswer: 1)]), Quiz(name: "Marvel Super Heros", desc: "Avengers, Assemble!", image: UIImage(named: "marvel.jpg")!, questions: [QuizQuestion(question: "What is marvel?", answers: ["true", "false", "false", "false"], correctAnswer: 1), QuizQuestion(question: "What is marvel 2?", answers: ["true", "false", "false", "false"], correctAnswer: 1) ]), Quiz(name: "Mathematics", desc: "Did you pass the third grade?", image: UIImage(named: "math.png")!, questions: [QuizQuestion(question: "What is 2+2?", answers: ["1", "2", "3", "4"], correctAnswer: 4)]
)]
    
    @IBAction func settingsPress(sender: AnyObject) {
        let alertController : UIAlertController = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .Alert)
        let cancelAction : UIAlertAction = UIAlertAction(title: "OK", style: .Default){ action -> Void in
            //dismisses message, nothing here right now
        }
        
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return quizes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Quiz Cell", forIndexPath: indexPath)

        // Configure the cell...
        let quiz = quizes[indexPath.row]
        cell.textLabel?.text = quiz.name
        cell.detailTextLabel?.text = quiz.desc
        cell.imageView?.image = quiz.image

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
