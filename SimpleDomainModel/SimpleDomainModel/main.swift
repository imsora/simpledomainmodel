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
    var convertedAmount : Int = amount
    switch currency {
    case "USD":
        switch to {
        case "GBP":
            convertedAmount = amount / 2
        case "EUR":
            convertedAmount = Int(Double(amount) * 1.5)
        case "CAN":
            convertedAmount = Int(Double(amount) * 1.25)
        default:
            print("Please ensure that the desired currency to convert to is valid.")
        }
    case "GBP":
        switch to {
        case "USD":
            convertedAmount = amount * 2
        case "EUR":
            return Money(amount: amount, currency: currency).convert("USD").convert("EUR")
        case "CAN":
            return Money(amount: amount, currency: currency).convert("USD").convert("CAN")
        default:
            print("Please ensure that the desired currency to convert to is valid.")
        }
    case "EUR":
        switch to {
        case "USD":
            convertedAmount = Int(Double(amount) / 1.5)
        case "GBT":
            return Money(amount: amount, currency: currency).convert("USD").convert("GBT")
        case "CAN":
            return Money(amount: amount, currency: currency).convert("USD").convert("CAN")
        default:
            print("Please ensure that the desired currency to convert to is valid.")
        }
    case "CAN":
        switch to {
        case "USD":
            convertedAmount = Int(Double(amount) / 1.25)
        case "EUR":
            return Money(amount: amount, currency: currency).convert("USD").convert("EUR")
        case "GBT":
            return Money(amount: amount, currency: currency).convert("USD").convert("GBT")
        default:
            print("Please ensure that the desired currency to convert to is valid.")
        }
    default:
        print("Please snure that the desired currency to convert from is valid")
    }
    return Money(amount: convertedAmount, currency: to)
  }
  
  public func add(_ to: Money) -> Money {
    return Money(amount: to.convert(currency).amount + amount, currency: currency).convert(to.currency)
  }
  public func subtract(_ from: Money) -> Money {
    return Money(amount: from.convert(currency).amount - amount, currency: currency).convert(from.currency)
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
    switch type {
    case JobType.Hourly(let hourly):
        return Int(hourly * Double(hours))
    case JobType.Salary(let salary):
        return salary
    }
  }
  
  /* raise(byAmount:) sets the new amount to the current rate + amt */
  open func raise(byAmount amt : Double) {
    switch type {
    case JobType.Hourly(let current):
        type = JobType.Hourly(current + amt)
    case JobType.Salary(let current):
        type = JobType.Salary(current + Int(amt))
    }
  }
  /* raise(byPercent:) sets the new amount to the current rate + (current * pcnt) */
  open func raise(byPercent pcnt : Double) {
    switch type {
    case JobType.Hourly(let current):
        type = JobType.Hourly(current + (current * pcnt))
    case JobType.Salary(let current):
        type = JobType.Salary(current + Int(Double(current) * pcnt))
    }
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
        if age > 15 {
            self._job = value
        } else {
            self._job = nil
        }
    }
  }
  
  fileprivate var _spouse : Person? = nil
  open var spouse : Person? {
    get { return _spouse }
    set(value) {
        if age > 17 {
            self._spouse = value
        } else {
            self._spouse = nil
        }
    }
  }
  
  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
  }
  
  open func toString() -> String {
    return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(job?.type) spouse:\(spouse?.firstName)]"
  }
}

////////////////////////////////////
// Family
//
open class Family {
  fileprivate var members : [Person] = []
  
  public init(spouse1: Person, spouse2: Person) {
    if spouse1.spouse == nil && spouse2.spouse == nil{
        members += [spouse1, spouse2]
        spouse1.spouse = spouse2
        spouse2.spouse = spouse1
    }
  }
  
  open func haveChild(_ child: Person) -> Bool {
    for mem in members {
        if mem.age > 20 {
            members.append(child)
            return true
        }
    }
    return false
  }
  
  open func householdIncome() -> Int {
    var income : Int = 0
    for mem in members {
        income += mem.job?.calculateIncome(2000) ?? 0
    }
    return income
  }
}





