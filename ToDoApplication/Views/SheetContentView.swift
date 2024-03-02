//
//  SheetContentView.swift
//  ToDoApplication
//
//  Created by Roman Krusman on 02.03.2024.
//

import SwiftUI

struct SheetContentView: View {
    
    @Binding var toDoTasks: [SomeTask]
    @Environment(\.dismiss) var dismiss
    @State private var taskTitle: String = ""
    @State private var taskCategory: String = "Sport"
    let categories = ["Sport", "Free time", "Home"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Details")) {
                    TextField("Task Name", text: $taskTitle)
                    Picker("Category", selection: $taskCategory) {
                        ForEach(categories, id: \.self) {
                            Text($0)
                        }
                    }
                }
            }
            .navigationBarTitle("New Task", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button("Add") {
                        let newTask = SomeTask(id: UUID(), title: taskTitle, category: taskCategory)
                        toDoTasks.append(newTask)
                        dismiss()
                    }
                    .disabled(taskTitle.isEmpty)
                })
            }
        }
    }
}
