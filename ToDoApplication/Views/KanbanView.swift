//
//  KanbanView.swift
//  ToDoApplication
//
//  Created by Roman Krusman on 01.03.2024.
//

import SwiftUI

enum TaskViewContext {
    case todo
    case done
}

struct KanbanView: View {
    let title: String
    let tasks: [SomeTask]
    let isTargeted: Bool
    let isTaskDone: (SomeTask) -> Bool
    let onTaskTapped: (SomeTask) -> Void
    let context: TaskViewContext
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title).font(.headline.bold())
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 12)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(isTargeted ? .teal.opacity(0.15) : Color(.secondarySystemFill))
                VStack {
                    if tasks.isEmpty {
                        Text(context == .todo ? "No to-do tasks yet" : "No completed tasks yet")
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding()
                    } else {
                        ForEach(tasks, id: \.id) { task in
                            HStack(spacing: 0) {
                                Button {
                                    withAnimation {
                                        onTaskTapped(task)
                                    }
                                } label: {
                                    Image(systemName: isTaskDone(task) ? "checkmark.circle.fill" : "circle")
                                        .imageScale(.large)
                                }
                                .padding(15)
                                .foregroundStyle(.primary)
                                
                                VStack(alignment: .leading) {
                                    Text(task.title)
                                        .strikethrough(isTaskDone(task))
                                    Text(task.category).font(.footnote)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(maxHeight: 70)
                            .padding(.vertical, 5)
                            .background(Color(uiColor: .secondarySystemGroupedBackground))
                            .cornerRadius(8)
                            .draggable(task)
                        }
                    }
                }
                .padding()
            }
            .frame(minHeight: 70)
        }
    }
}


#Preview {
    ContentView()
}
