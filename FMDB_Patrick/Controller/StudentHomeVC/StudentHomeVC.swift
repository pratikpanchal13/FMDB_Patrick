//
//  StudentHomeVC.swift
//  FMDB_Patrick
//
//  Created by indianic on 22/05/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit

class StudentHomeVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    //MARK: Variable Declare
    @IBOutlet var tblViewStudent: UITableView!
    var mutArrayStudentData : NSMutableArray!
    
    //MARK: View Lify Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.getStudentData()

    }

    @IBAction func btnAddClicked(_ sender: Any) {
        
        let viewController: StudentInsertVC = self.storyboard?.instantiateViewController(withIdentifier: "StudentInsertVC") as! StudentInsertVC
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    //MARK: Other methods
    
    func getStudentData()
    {
        mutArrayStudentData = NSMutableArray()
        mutArrayStudentData = ModelManager.getInstance().getAllStudentData()
        tblViewStudent.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mutArrayStudentData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  : CellStudent = tableView.dequeueReusableCell(withIdentifier: "CellStudent") as! CellStudent
        let student:StudentInfo = mutArrayStudentData[indexPath.row] as! StudentInfo
        cell.lblStudentName.text = "Name : \(student.Name) \n Marks : \(student.Marks)"
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // action one
        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
            print("Edit tapped")
            let viewController: StudentInsertVC = self.storyboard?.instantiateViewController(withIdentifier: "StudentInsertVC") as! StudentInsertVC
            viewController.isEdit = true
            viewController.studentData = self.mutArrayStudentData[indexPath.row] as! StudentInfo
            self.navigationController?.pushViewController(viewController, animated: true)
            
            self.tblViewStudent.reloadData()
        })
        editAction.backgroundColor = UIColor.blue
        
        // action two
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            print("Delete tapped")
            
            let studentInfo: StudentInfo = self.mutArrayStudentData[indexPath.row] as! StudentInfo
            let isDeleted = ModelManager.getInstance().deleteStudentData(studentInfo)
            if isDeleted {
                
                UIAlertController.showAlertWithOkButton(self, aStrMessage: "Record deleted successfully.", completion: nil)
            } else {
                UIAlertController.showAlertWithOkButton(self, aStrMessage: "Error in deleting record.", completion: nil)
            }
            self.getStudentData()

            
            
            self.tblViewStudent.reloadData()
          
        })
        deleteAction.backgroundColor = UIColor.red
        
        return [editAction, deleteAction]
    }
    
    
}



class CellStudent : UITableViewCell {
    
    @IBOutlet var lblStudentName: UILabel!
}


