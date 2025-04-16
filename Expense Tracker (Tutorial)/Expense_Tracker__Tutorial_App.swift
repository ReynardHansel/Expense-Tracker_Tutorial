//
//  Expense_Tracker__Tutorial_App.swift
//  Expense Tracker (Tutorial)
//
//  Created by Reynard Hansel on 16/03/25.
//

import SwiftUI

@main
struct Expense_Tracker__Tutorial_App: App {
    @State var transacrionListVM = TransactionListViewModel() //! This one is not the same as the tutorial (39:23)
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transacrionListVM) // Pass the transaction list view model to the environment
        }
    }
}
