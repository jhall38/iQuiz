//
//  QuizesTableViewController.swift
//  iQuiz
//
//  Created by Joshua Hall on 5/8/16.
//  Copyright © 2016 Joshua Hall. All rights reserved.
//

import UIKit

class QuizesTableViewController: UITableViewController {
    
    //var ScienceQuizQuestions : [QuizQuestion]  = [QuizQuestion(question: "What is fire?", answers: ["true", "false", "false", "false"], correctAnswer: 1)]
    //var MarvelQuizQuestions : [QuizQuestion] // = [QuizQuestion(question: "What is marvel?", answers: ["true", "false", "false", "false"], correctAnswer: 1), QuizQuestion(question: "What is marvel 2?", answers: ["true", "false", "false", "false"], correctAnswer: 1) ]
    //var MathQuizQuestions : [QuizQuestion]// = [QuizQuestion(question: "What is 2+2?", answers: ["1", "2", "3", "4"], correctAnswer: 4)]
    var quizes : [Quiz] = []// = [Quiz(name: "Science!", desc: "Because SCIENCE!", image: UIImage(named: "science.jpg")!, questions: [QuizQuestion(question: "What is fire?", answers: ["true", "false", "false", "false"], correctAnswer: 1)]), Quiz(name: "Marvel Super Heros", desc: "Avengers, Assemble!", image: UIImage(named: "marvel.jpg")!, questions: [QuizQuestion(question: "What is marvel?", answers: ["true", "false", "false", "false"], correctAnswer: 1), QuizQuestion(question: "What is marvel 2?", answers: ["true", "false", "false", "false"], correctAnswer: 1) ]), Quiz(name: "Mathematics", desc: "Did you pass the third grade?", image: UIImage(named: "math.png")!, questions: [QuizQuestion(question: "What is 2+2?", answers: ["1", "2", "3", "4"], correctAnswer: 3)])]
    let requestURL: NSURL = NSURL(string: "http://tednewardsandbox.site44.com/questions.json")!
    var images : [UIImage] = [UIImage(named: "science.jpg")!, UIImage(named: "marvel.jpg")!, UIImage(named: "math.png")!]
    
    @IBAction func settingsPress(sender: AnyObject) {
        let alertController : UIAlertController = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .Alert)
        let cancelAction : UIAlertAction = UIAlertAction(title: "OK", style: .Default){ action -> Void in
            //dismisses message, nothing here right now
        }
        
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
        
        
        
    }
    
    func JSONParseArray(string: String) -> [AnyObject]{
        if let data = string.dataUsingEncoding(NSUTF8StringEncoding){
            
            do{
                
                if let array = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)  as? [AnyObject] {
                    return array
                }
            }catch{
                
                print("error")
                //handle errors here
                
            }
        }
        return [AnyObject]()
    }
    
    func JSONStringify(value: AnyObject,prettyPrinted:Bool = false) -> String{
        
        let options = prettyPrinted ? NSJSONWritingOptions.PrettyPrinted : NSJSONWritingOptions(rawValue: 0)
        
        
        if NSJSONSerialization.isValidJSONObject(value) {
            
            do{
                let data = try NSJSONSerialization.dataWithJSONObject(value, options: options)
                if let string = NSString(data: data, encoding: NSUTF8StringEncoding) {
                    return string as String
                }
            }catch {
                
                print("error")
                //Access error here
            }
            
        }
        return ""
        
    }
    
    func pullData(){
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                do{
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments)
                    let file = "data.json" //this is the file. we will write to and read from it
                    
                    let text = self.JSONStringify(json) //just a text
                    
                    if let dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
                        let path = NSURL(fileURLWithPath: dir).URLByAppendingPathComponent(file)
                        
                        //writing
                        do {
                            try text.writeToURL(path, atomically: false, encoding: NSUTF8StringEncoding)
                        }
                        catch {
                            NSLog("error with writing")
                        }
                    }
                    if let qs = json as? [[String: AnyObject]] {
                        var count : Int = 0
                        for q in qs{
                            var title : String = (q["title"] as? String)!
                            var desc : String = (q["desc"] as? String)!
                            var questions : [QuizQuestion] = []
                            if let ques = q["questions"] as? [[String: AnyObject]]{
                            for que in ques{
                                var text = (que["text"] as? String)!
                                var answer = (que["answer"] as? String)!
                                var answers : [String] = (que["answers"] as? [String])!
                                var question : QuizQuestion = QuizQuestion(question: text, answers: answers, correctAnswer: Int(answer)!)
                                questions.append(question)
                            }
                            }
                            var quiz : Quiz = Quiz(name: title, desc: desc, image: self.images[count], questions: questions)
                            self.quizes.append(quiz)
                            count += 1
                        }
                    }
                    
                }catch {
                    print("Error with Json: \(error)")
                }
            }
            

        }
        task.resume()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let str = "Super long string here"
//        let filename = getDocumentsDirectory().stringByAppendingPathComponent("output.txt")
//        
//        do {
//            try str.writeToFile(filename, atomically: true, encoding: NSUTF8StringEncoding)
//        } catch {
//            NSLog("NO GO")
//            // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
//        }
        
        pullData()
        NSLog(String(quizes))
    


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let nextVC = segue.destinationViewController as! QuizQuestionTableViewController
        nextVC.quiz = quizes[(tableView.indexPathForSelectedRow?.row)!]
        nextVC.thisQuestion = quizes[(tableView.indexPathForSelectedRow?.row)!].questions[0]
        nextVC.questionIndex = 0
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
