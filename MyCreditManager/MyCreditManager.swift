//
//  MyCreditManager.swift
//  MyCreditManager
//
//  Created by 김태성 on 2022/11/16.
//

import Foundation

class MyCreditManager{
    let myCreditService = MyCreditService()
    
    func start(){
        var command: String?
        while(command != "X"){
            print(
            """
            원하는 기능을 입력해주세요
            1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료
            """
            )
            command = readLine()
            command = command == nil ? "" : command?.trimmingCharacters(in: .whitespaces).uppercased()
            print(command!)
            
            switch(command){
                case "1":
                    addStudent()
                case "2":
                    removeStudent()
                case "3":
                    addGrade()
                case "4":
                    removeGrade()
                case "5":
                    showGrade()
                case "6":
                    studentsAllInfo()
                case "X":
                    print("종료")
                default :
                    print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
            }
        }
    }
    
    func addStudent(){
        var command: String?
        
        print("추가할 학생의 이름을 입력해주세요.")
        command = readLine()
        guard var command = command else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
            return
        }
        command = command.trimmingCharacters(in: .whitespaces)
        
        if(command.isEmpty){
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
            return
        }
        
        let name = command
        let isExist = myCreditService.isExistStudent(name: name)
        if(isExist){
            print("\(name)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
        }
        else{
            myCreditService.addStudent(name: name)
            print("\(name) 학생을 추가하였습니다.")
        }
    }
    
    func removeStudent(){
        var command: String?
        
        print("삭제할 학생의 이름을 입력해주세요.")
        command = readLine()
        guard var command = command else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
            return
        }
        command = command.trimmingCharacters(in: .whitespaces)
        
        if(command.isEmpty){
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        }
        else
        {
            let name = command
            let isExist = myCreditService.isExistStudent(name: name)
            if(isExist){
                myCreditService.removeStudent(name: name)
                print("\(name) 학생을 삭제하였습니다.")
            }
            else{
                print("\(name) 학생을 찾지 못했습니다.")
            }
        }
        
        
    }
    
    func addGrade(){
        var command: String?
        let inputCount = 3
        var inputName: String
        var inputSubject: String
        var inputScore: String
        
        print(
        """
        성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.
        입력예) Mickey Swift A+
        만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.
        """)
        command = readLine()
        guard let command = command else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
            return
        }
        
        let subCommnad = command.split(separator: " ")
        if(subCommnad.count != inputCount){
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
            return
        }
       
        inputName = String(subCommnad[0])
        inputSubject = String(subCommnad[1])
        inputScore = String(subCommnad[2])
        let isExist = myCreditService.isExistStudent(name: inputName)
        
        if(!isExist){
            print("\(inputName) 학생을 찾지 못햇습니다.")
            return
        }
        
        guard let convertScore = GradeScore(rawValue: inputScore.uppercased()) else {
            print("\(inputScore) 성적 점수는 존재하지 않습니다.")
            return
        }
        
        myCreditService.addGrade(name: inputName, subject: inputSubject, score: convertScore)
        print("\(inputName) 학생의 \(inputSubject) 과목 \(inputScore) 성적이 추가 되었습니다.")
    }
    
    func removeGrade(){
        var command: String?
        let inputCount = 2
        var inputName: String
        var inputSubject: String

        print(
        """
        성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.
        입력예) Mickey Swift
        """)
        
        command = readLine()
        guard let command = command else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
            return
        }
        
        let subCommnad = command.split(separator: " ")
        if(subCommnad.count != inputCount){
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
            return
        }
        
        inputName = String(subCommnad[0])
        inputSubject = String(subCommnad[1])
        
        let isStudentExist = myCreditService.isExistStudent(name: inputName)
        if(!isStudentExist){
            print("\(inputName) 학생을 찾지 못햇습니다.")
            return
        }
        
        let isSubjectExist = myCreditService.isExistSubject(name: inputName, subject: inputSubject)
        if(!isSubjectExist){
            print("\(inputName) 학생의 \(inputSubject) 과목 성적은 존재하지 않습니다.")
            return
        }
        
        myCreditService.removeGrade(name: inputName, subject: inputSubject)
        print("\(inputName) 학생의 \(inputSubject) 과목의 성적이 삭제 되었습니다.")
    }
    
    func showGrade(){
        var command: String?
        var inputName: String

        print("평점을 알고싶은 학생의 이름을 입력해주세요.")
        
        command = readLine()
        guard let command = command else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
            return
        }
        
        inputName = command
        let isStudentExist = myCreditService.isExistStudent(name: inputName)
        if(!isStudentExist){
            print("\(inputName) 학생을 찾지 못햇습니다.")
            return
        }
        myCreditService.showGrade(name: inputName)
    }
    
    func studentsAllInfo(){
        myCreditService.printStudentInfo()
    }
    
    
}
