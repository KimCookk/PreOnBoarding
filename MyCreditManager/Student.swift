//
//  Student.swift
//  MyCreditManager
//
//  Created by 김태성 on 2022/11/16.
//

import Foundation

class Student{
    let name: String
    var grades: [String: Grade]
    
    init(name: String){
        self.name = name
        self.grades = [:]
    }
    
    func updateGrade(subject: String, score: GradeScore){
        grades.updateValue(Grade(subject: subject, score: score), forKey: subject)
    }
    
    func removeGrade(subject: String){
        grades.removeValue(forKey: subject)
    }
    
    func printStudentGradeInfo(){
        let subjectCount = grades.count
        var sum: Float = 0
        var average: Float = 0
        print("Name : \(name)")
        grades.forEach{ (key, value) in
            print("\(value.subject) : \(value.gardeScore.rawValue)")
            sum += value.gardeScore.score
        }
        
        if(subjectCount != 0){
            average = sum / Float(subjectCount)
        }
        
        print("평점 : \(String(format: "%.2f", average))")
    }
    
    func printStudentInfo(){
        print("Name : \(name)")
        grades.forEach{ (key, value) in
            print("\(value.subject) : \(value.gardeScore.rawValue)")
        }
    }
}

struct Grade{
    let subject: String
    let gardeScore: GradeScore
    
    init(subject: String, score: GradeScore){
        self.subject = subject
        self.gardeScore = score
    }
}

enum GradeScore: String{
    case APlus = "A+", A = "A", BPlus = "B+", B = "B", CPlus = "C+", C = "C", DPlus = "D+", D = "D", F = "F"
    
    var score: Float {
        get {
            switch self {
                case .APlus:
                    return 4.5
                case .A:
                    return 4
                case .BPlus:
                    return 3.5
                case .B:
                    return 3
                case .CPlus:
                    return 2.5
                case .C:
                    return 2
                case .DPlus:
                    return 1.5
                case .D:
                    return 1
                case .F:
                    return 0
            }
        }
    }
}
