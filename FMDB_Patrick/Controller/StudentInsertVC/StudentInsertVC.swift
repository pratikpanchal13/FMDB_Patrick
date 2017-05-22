//
//  StudentInsertVC.swift
//  FMDB_Patrick
//
//  Created by indianic on 22/05/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit

class StudentInsertVC: UIViewController {

    // MARK: - Variable Declartion
    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtMarks: UITextField!
    
    var isEdit : Bool = false
    var studentData : StudentInfo!

    
    // MARK: - View Lify Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if(isEdit)
        {
            txtName.text = studentData.Name;
            txtMarks.text = studentData.Marks;
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Button Click Action
    
    @IBAction func btnHomeClicked(_ sender: Any) {

        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func btnSaveClicked(_ sender: Any) {

        
        if(isEdit)
        {
            let studentInfo: StudentInfo = StudentInfo()
            studentInfo.RollNo = studentData.RollNo
            studentInfo.Name = txtName.text!
            studentInfo.Marks = txtMarks.text!
            let isUpdated = ModelManager.getInstance().updateStudentData(studentInfo)
            if isUpdated {
                UIAlertController.showAlertWithOkButton(self, aStrMessage: "Record updated successfully.", completion: nil)

            } else {
                UIAlertController.showAlertWithOkButton(self, aStrMessage: "Error in updating record.", completion: nil)

            }
        }
        else{
         
            let studentInfo: StudentInfo = StudentInfo()
            studentInfo.Name = txtName.text!
            studentInfo.Marks = txtMarks.text!
            
            
            let isInserted = ModelManager.getInstance().addStudentData(studentInfo)
            if isInserted {
                UIAlertController.showAlertWithOkButton(self, aStrMessage: "Record Inserted successfully", completion:{(indexes , value) -> () in
                    print("Index is \(indexes)")
                    self.navigationController?.popViewController(animated: true)
                })
                
            } else {
                UIAlertController.showAlertWithOkButton(self, aStrMessage: "Error in inserting record.", completion: nil)
            }

        }
        
        
    }
}


extension StudentInsertVC{
    
}
