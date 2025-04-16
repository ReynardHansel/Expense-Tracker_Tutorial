//
//  TransactionListViewModel.swift
//  Expense Tracker (Tutorial)
//
//  Created by Reynard Hansel on 13/04/25.
//

// NOTE: LEARN WHAT DOES THIS CODE DO!!

import Foundation
import Combine

final class TransactionListViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getTransactions()
    }
    
    func getTransactions() {
        guard
            let url = URL(
                string: "https://designcode.io/data/transactions.json")
        else {
            print("Invalid URL")
            return
        }

        //* This function is to ensure it's an HTTP 200 OK response
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 // --> checking if the response is HTTP 200 OK(?)
                else {
                    dump(response)
                    throw URLError(.badServerResponse)

                }
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder()) // --> Turn raw JSON data into Swift models -> "Take the JSON Data you got, and decode it into an array of Transaction objects using the JSONDecoder."
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                    case .finished:
                        print("Finished fetching transactions")
                }
            } receiveValue: { [weak self] result in
                self?.transactions = result
                print("Transactions: \(result)")
                dump(self?.transactions)
            }
            .store(in: &cancellables)
    }
}


// NOTE:
// tryMap: does the same thing as map, but it can throw an error
// sink: subscribes to the publisher and receives the values emitted by it. This is where the data gets actually used and passed to your transactions array.

// What if I don’t use .receive(on: DispatchQueue.main)?
//  💥Then you’re trying to update the UI from a background thread, which SwiftUI won’t allow and will probably crash your app. Combine does work in background threads (especially for network calls), but UI updates must happen on the main thread.
//  So this line ensures:
//  → “From here on, run everything on the main thread.”

// 🔚 What does .sink do?
//    .sink is how you subscribe to the data emitted by the publisher. It gives you two closures:
//    .sink { completion in
        // Runs when finished or failed
//    } receiveValue: { value in
        // Runs when you get the data
//    }
//  Think of it like saying:
//  “I’m ready to receive this data. Tell me if something goes wrong, and let me handle the value when it arrives.” This is where the data gets actually used and passed to your transactions array.

// Concept | What It Does
// Publisher | Emits data over time (e.g. from URL)
// tryMap | Checks & transforms data, can throw errors
// decode | Converts JSON into Swift objects
// receive(on: .main) | Ensures UI updates happen on main thread
// sink | Subscribes to the data, handles it or errors
// cancellables | Holds subscriptions so they stay alive
