//
//  PreviewData.swift
//  Expense Tracker (Tutorial)
//
//  Created by Reynard Hansel on 20/03/25.
//

import Foundation

var transactionPreviewData = Transaction(
    id: 1,
    date: "01/24/2025",
    institution: "Bank of America",
    account: "Checking",
    merchant: "Amazon",
    amount: 150.75,
    type: TransactionType.debit.rawValue,
    categoryId: 1,
    category: "Shopping",
    isPending: false,
    isTransfer: false,
    isExpense: true,
    isEdited: false
)

var transactionListPreviewData = [Transaction](repeating: transactionPreviewData, count: 10)
