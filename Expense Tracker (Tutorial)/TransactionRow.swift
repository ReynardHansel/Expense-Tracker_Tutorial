//
//  TransactionRow.swift
//  Expense Tracker (Tutorial)
//
//  Created by Reynard Hansel on 01/04/25.
//

import SwiftUI
import SwiftUIFontIcon

struct TransactionRow: View {
    var transaction: Transaction

    var body: some View {
        HStack(spacing: 20) {
            // MARK: Category Icon
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.icon.opacity(0.3))
                .frame(width: 44, height: 44)
                .overlay(
                    FontIcon.text(
                        .awesome5Solid(code: .icons), fontsize: 24,
                        color: Color.icon)
                )

            VStack(alignment: .leading, spacing: 6) {
                // MARK: Transaction Merchant
                Text(transaction.merchant)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)

                // MARK: Transaction Category
                Text(transaction.category)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)

                // MARK: Transaction Date
                Text(
                    transaction.dateParsed,
                    format: .dateTime.year().month().day()
                )
                .font(.footnote)
                .foregroundStyle(.secondary)
            }

            Spacer()

            // MARK: Transaction Amount
            Text(transaction.signedAmount, format: .currency(code: "USD"))
                .bold()
                .foregroundStyle(
                    transaction.type == TransactionType.credit.rawValue
                        ? Color.text : .primary)
        }
        .padding([.top, .bottom], 8)
    }
}

#Preview {
    TransactionRow(transaction: transactionPreviewData)
}
