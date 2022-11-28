//
//  MyCreditService.swift
//  MyCreditManager
//
//  Created by 김태성 on 2022/11/18.
//

import Foundation

class MyCreditService{
    var studentDic: [String : Student] = [:]
    
    func isExistStudent(name: String) -> Bool {
        return studentDic.keys.contains(name)
    }
    
    func isExistSubject(name: String, subject: String) -> Bool {
        guard let student = studentDic[name] else {
            return false
        }
        return student.grades.keys.contains(subject)
    }
    
    func addStudent(name: String){
        let student = Student(name: name)
        studentDic.updateValue(student, forKey: name)
    }
    
    func removeStudent(name: String){
        studentDic.removeValue(forKey: name)
    }
    
    func addGrade(name: String, subject: String, score: GradeScore){
        let student = studentDic[name]
        student?.updateGrade(subject: subject, score: score)
    }
    
    func removeGrade(name: String, subject: String){
        let student = studentDic[name]
        student?.removeGrade(subject: subject)
    }
    
    func showGrade(name: String){
        let student = studentDic[name]
        student?.printStudentGradeInfo()
    }
    
    func printStudentInfo(){
        print("==================")
        let count = studentDic.values.count
        for index in 0..<count{
            let student = Array(studentDic.values)[index]
            student.printStudentInfo()
            if(index != count - 1){
                print()
            }
        }
        print("==================")

    }
}
