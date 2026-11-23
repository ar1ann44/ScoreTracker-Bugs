//
//  ScoreManager.swift
//  ScoreTracker(Bugs)
//
//  Created by Arturo Martinez on 5/22/26.
//


import Foundation
import Combine
// ScoreManager handles loading and persisting student data.

// BUGS INSIDE THIS FILE
// TOTAL: 3
class ScoreManager:ObservableObject{

    var onChange: (() -> Void)?

    
    // FIX: weak so the object can be released (no retain cycle)
    weak var owner: ScoreManager?

    @Published private(set) var students: [StudentModel] = []

    func addStudent(_ student: StudentModel) {
        students.append(student)
        onChange?()
    }

    func removeStudent(at index: Int) {
     
        // FIX: check that the index exists before removing
        if index >= 0 && index < students.count {
            students.remove(at: index)
            onChange?()
        }
    }

    // FIX: return an optional, if the list is empty it returns nil and does not crash
    func topStudent() -> StudentModel? {

        return students.max(by: { $0.average < $1.average })
    }

    func loadSampleData() {
        let sample = [
            StudentModel(name: "Alice",   scores: [92, 88, 95, 90]),
            StudentModel(name: "Bob",     scores: [70, 65, 72, 68]),
            StudentModel(name: "Charlie", scores: [55, 60, 58, 50]),
            StudentModel(name: "Diana",   scores: [100, 98, 97, 99]),
            StudentModel(name: "Eve",     scores: [])
            // edge case: no scores
        ]
        sample.forEach { addStudent($0) }

        // FIX: removed the object that pointed to itself (retain cycle)
    }
}
