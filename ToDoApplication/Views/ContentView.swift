//
//  ContentView.swift
//  ToDoApplication
//
//  Created by Roman Krusman on 01.03.2024.
//

import SwiftUI
import Algorithms
import UniformTypeIdentifiers

struct ContentView: View {
    @State private var toDoTasks: [SomeTask] = [MockData.taskOne, MockData.taskTwo, MockData.taskThree, MockData.taskFour]
    @State private var doneTasks: [SomeTask] = []
    @State private var isToDoProgressTargeted = false
    @State private var isDoneProgressTargeted = false
    @State private var draggingItem: SomeTask?
    @State private var sheetPresent = false
    let startToDoTip = StartTip()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20){
                    KanbanView(title: "To Do", tasks: toDoTasks, isTargeted: isToDoProgressTargeted, isTaskDone: { task in
                        doneTasks.contains(task)
                    }, onTaskTapped: { task in
                        if !doneTasks.contains(task) {
                            doneTasks.append(task)
                            toDoTasks.removeAll { $0.id == task.id }
                        }
                    }, context: .todo)
                    .dropDestination(for: SomeTask.self) { droppedTasks, location in
                        for task in droppedTasks {
                            doneTasks.removeAll{ $0.id == task.id }
                        }
                        let totalTasks = toDoTasks + droppedTasks
                        toDoTasks = Array(totalTasks.uniqued())
                        return true
                    } isTargeted: { isTargeted in
                        isToDoProgressTargeted = isTargeted
                    }
                    KanbanView(title: "Done", tasks: doneTasks, isTargeted: isDoneProgressTargeted, isTaskDone: { _ in true }, onTaskTapped: { task in
                        if !toDoTasks.contains(task) {
                            toDoTasks.append(task)
                            doneTasks.removeAll { $0.id == task.id }
                        }
                    }, context: .done)
                    .dropDestination(for: SomeTask.self) { droppedTasks, location in
                        for task in droppedTasks {
                            toDoTasks.removeAll{ $0.id == task.id}
                        }
                        let totalTasks = doneTasks + droppedTasks
                        doneTasks = Array(totalTasks.uniqued())
                        return true
                    } isTargeted: { isTargeted in
                        isDoneProgressTargeted = isTargeted
                    }
                }
                .padding()
            }
            .scrollIndicators(.hidden)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button {
                        sheetPresent.toggle()
                    }label: {
                        Image(systemName: "plus")
                            .imageScale(.large)
                            .fontWeight(.bold)
                    }
                    .popoverTip(startToDoTip, arrowEdge: .top)
                    .sheet(isPresented: $sheetPresent, content: {
                        SheetContentView(toDoTasks: $toDoTasks)
                    })
                })
            }
            .navigationTitle("My Day")
        }
    }
}

#Preview {
    ContentView()
}

struct SomeTask: Codable, Hashable, Transferable {
    let id: UUID
    let title: String
    let category: String
    
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .someTask)
    }
}

extension UTType {
    static let someTask = UTType(exportedAs: "com.eventide.ToDoApplication")
}

struct MockData {
    static let taskOne = SomeTask(id: UUID(), title: "Gym", category: "Sport")
    static let taskTwo = SomeTask(id: UUID(), title: "Cinema", category: "Free time")
    static let taskThree = SomeTask(id: UUID(), title: "Breakfast", category: "Home")
    static let taskFour = SomeTask(id: UUID(), title: "Dinner", category: "Home")
}
