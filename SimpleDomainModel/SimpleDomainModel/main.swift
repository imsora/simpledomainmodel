//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
  return "I have been tested"
}

open class TestMe {
  open func Please() -> String {
    return "I have been tested"
  }
}

////////////////////////////////////
// Money
//
public struct Money {
  public var amount : Int
  public var currency : String
  
  public func convert(_ to: String) -> Money {
    return self
  }
  
  public func add(_ to: Money) -> Money {
    return self
  }
  public func subtract(_ from: Money) -> Money {
    return self
  }
}

////////////////////////////////////
// Job
//
open class Job {
  fileprivate var title : String
  fileprivate var type : JobType

  public enum JobType {
    case Hourly(Double)
    case Salary(Int)
  }
  
  public init(title : String, type : JobType) {
    self.title = title; self.type = type
  }
  
  open func calculateIncome(_ hours: Int) -> Int {
    return -1
  }
  
  /* raise(byAmount:) sets the new amount to the current rate + amt */
  open func raise(byAmount amt : Double) {
  }
  /* raise(byPercent:) sets the new amount to the current rate + (current * pcnt) */
  open func raise(byPercent pcnt : Double) {
  }
}

////////////////////////////////////
// Person
//
open class Person {
  open var firstName = ""
  open var lastName = ""
  open var age = 0

  fileprivate var _job : Job? = nil
  open var job : Job? {
    get { return _job }
    set(value) {
    }
  }
  
  fileprivate var _spouse : Person? = nil
  open var spouse : Person? {
    get { return _spouse }
    set(value) {
    }
  }
  
  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
  }
  
  open func toString() -> String {
    return ""
  }
}

////////////////////////////////////
// Family
//
open class Family {
  fileprivate var members : [Person] = []
  
  public init(spouse1: Person, spouse2: Person) {
  }
  
  open func haveChild(_ child: Person) -> Bool {
    return false
  }
  
  open func householdIncome() -> Int {
    return -1
  }
}





