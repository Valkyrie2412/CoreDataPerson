//
//  DataService.swift
//  CoreDataPerson
//
//  Created by Hiếu Nguyễn on 9/25/18.
//  Copyright © 2018 Hiếu Nguyễn. All rights reserved.
//

import UIKit


class DataService {
    static let sharedInstance: DataService = DataService()
    
    private var _mocEntity: [Person]?
    var mocEntity: [Person] {
        get {
            if _mocEntity == nil {
                loadDataEntity()
            }
            return _mocEntity ?? []
        }
        set {
            _mocEntity = newValue
        }
    }


 func loadDataEntity() {
    _mocEntity = []
    do {
        _mocEntity = try AppDelegate.context.fetch(Person.fetchRequest()) as? [Person]
    } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
    }
}
    func addData(person: Person)  {
        _mocEntity?.append(person)
        saveData()
    }
    func edit(at index: Int, and person: Person) {
        _mocEntity?[index] = person
        saveData()
    }
    
    func remove(at indexPath: IndexPath)  {
        guard let person = _mocEntity else { return}
        AppDelegate.context.delete(person[indexPath.row])
        loadDataEntity()
        saveData()
    }
    
    private func saveData()  {
        AppDelegate.saveContext()
    }

    
}
