//
//  StartTip.swift
//  ToDoApplication
//
//  Created by Roman Krusman on 02.03.2024.
//

import Foundation
import TipKit

struct StartTip: Tip {
    var title: Text {
        Text("New Task")
    }
    var message: Text? {
        Text("Press this button to add new task.")
    }
    var image: Image? {
        Image(systemName: "square.and.pencil")
    }
}
