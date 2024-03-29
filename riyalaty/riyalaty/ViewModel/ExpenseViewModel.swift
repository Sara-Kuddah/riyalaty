//
//  ExpenseViewModel.swift
//  riyalaty
//
//  Created by Sara Khalid BIN kuddah on 16/06/1444 AH.
//

import SwiftUI

class ExpenseViewModel: ObservableObject{
    //for update cordata
    @State var showSheetView = false

    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "dateCreated", ascending: false)])
    private var allTasks: FetchedResults<Task>
    private func SysImage(_ value: String) -> Image{
        let priority = Priority(rawValue: value)
        
        switch priority {
        case .Transportation:
            return Image(systemName: "car")
        case .Home:
            return Image(systemName: "house")
        case .Bill:
            return Image(systemName: "list.bullet.rectangle.portrait")
        case .Entertainment:
            return Image(systemName: "gamecontroller")
        case .HealthCare:
            return Image(systemName: "cross.circle")
        case .Groceries:
            return Image(systemName: "cart")
        case .Shopping:
            return Image(systemName: "bag")
        case .Coffee:
            return Image(systemName: "cup.and.saucer")
        default:
            return Image(systemName: "plus")
        }
    }
    private func styleForPriority(_ value: String) -> String{
        let priority = Priority(rawValue: value)
        
        switch priority {
        case .Transportation:
            return "Transportation"
        case .Entertainment:
            return "Entertainment"
        case .HealthCare:
            return "Health & Care"
        case .Groceries:
            return "Groceries"
        case .Shopping:
            return "Shopping"
        case .Coffee:
            return "Coffee"
        case .Home:
            return "Home"
        case .Bill:
            return "Bill"
        default:
            return "Other"
        }
    }
    private func deleteTask(at offsets: IndexSet){
        offsets.forEach { index in
            let task = allTasks[index]
            viewContext.delete(task)
            
            do {
                try viewContext.save()
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }



    //=========================
    //1673169938
    // Sample expense
    @Published var storedExpense: [Expense] = [
        Expense(expenseCategory: "􀸩 Resturent" ,expenseAmount: 180 ,expenseDate: .init(timeIntervalSince1970: 1673256338)),
        Expense(expenseCategory: "􀙘 Transportion" ,expenseAmount: 290 ,expenseDate: .init(timeIntervalSince1970: 1673256338)),
        Expense(expenseCategory: "􀸘 Coffee" ,expenseAmount: 30 ,expenseDate: .init(timeIntervalSince1970: 1673256338)),
        Expense(expenseCategory: "􀸩 Resturent" ,expenseAmount: 180 ,expenseDate: .init(timeIntervalSince1970: 1673256338)),
        Expense(expenseCategory: "􀙘 Transportion" ,expenseAmount: 290 ,expenseDate: .init(timeIntervalSince1970: 1673256338)),
        Expense(expenseCategory: "􀸘 Coffee" ,expenseAmount: 30 ,expenseDate: .init(timeIntervalSince1970: 1673256338))
    ]
    
    // current week Days
    @Published var curreWeek: [Date] = []

    // current day
    @Published var currentDay: Date = Date()
    
    // filtering today tassks
    @Published var filterExpenses: [Expense]?
    @Published var filterTasks: [Task]?
    
    // intializing
    init(){
        fetchCurrenWeek()

    }

    func fetchCurrenWeek(){
        
        let today = Date()
        let calendar = Calendar.current
        
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
//        let mo = calendar.dateInterval(of: .month, for: today)
//        guard let firstMonthDay = week?.start else{
//            return
//        }
        guard let firstWeekDay = week?.start else{
            return
        }
        (-1...5).forEach{ day in
            if let weekday = calendar.date(byAdding: .day , value: day, to: firstWeekDay){
                curreWeek.append(weekday)
            }
        }
    }
    // Extraction date
    func extractDate(date: Date, format: String)->String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
    // checking if current Date is today
    func isToday(date: Date)->Bool{
        let calender = Calendar.current
        
        return calender.isDate(currentDay, inSameDayAs: date)
    }
    
    
    
    //current Months
 
    @Published var curreMonths: [Date] = []

    // current dany
    @Published var currentMonth: Date = Date()
//
//    // intializing
////    init(){
////        fetchCurrenWeek()
////    }
//    func fetchCurrenMonth(){
//        let thisMonth = Date()
//        let calendar = Calendar.current
//
//        let month = calendar.dateInterval(of: .month, for: thisMonth)
//        let currentDate = calendar.component(.day)
//        var valueToReduce = -1
//               if currentDate > 15 {
//                   valueToReduce = -2
//               }
//        guard let firstMonthDay = month?.start else{
//            return
//        }
//        (1...7).forEach{ month in
//            if let months = calendar.date(byAdding: .month ,value: valueToReduce, to: self){
//                curreMonths.append(months)
//            }
//        }
//    }
//    // Extraction date
//    func extractMonth(date: Date, format: String)->String{
//        let formatter = DateFormatter()
//        formatter.dateFormat = format
//
//        return formatter.string(from: date)
//    }
//    // checking if current Date is today
//    func isThisMonth(date: Date)->Bool{
//        let calender = Calendar.current
//
//        return calender.isDate(currentMonth, inSameDayAs: date)
//    }
    
    
}
//let date = Date()
//let dateFormatter = DateFormatter()
//dateFormatter.dateFormat = "llll"
//let monthString = dateFormatter.string(from: date)
//extension Date {
//    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
//        return calendar.dateComponents(Set(components), from: self)
//    }
//
//    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
//        return calendar.component(component, from: self)
//    }
//}
//let date = Date()
//let calendar = Calendar.current
//let components = calendar.dateComponents([.month], from: date)
//let month = components.month



