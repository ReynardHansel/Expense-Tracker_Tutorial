//
//  Extensions.swift
//  Expense Tracker (Tutorial)
//
//  Created by Reynard Hansel on 16/03/25.
//

import Foundation
import SwiftUI

extension Color {
    static let customBackground = Color("Background")
    static let customIcon = Color("Icon")
    static let customText = Color("Text")
    static let customSystemBackground = Color(uiColor: .systemBackground)
}

//* --> Lazy formatter, only created once and not every time it is called
extension DateFormatter {
    static let allNumericUSA: DateFormatter = {
        print("Initializing DateFormatter...")
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        return formatter
    }()
}


extension String {
    func dateParsed() -> Date {
        guard let parseDate = DateFormatter.allNumericUSA.date(from: self) else { return Date() }
        
        return parseDate
    }
}
