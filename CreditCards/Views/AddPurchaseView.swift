//
//  AddPurchaseView.swift
//  CreditCards
//
//  Created by Yery Castro on 8/3/23.
//

import SwiftUI

struct AddPurchaseView: View {
    
    @Environment(\.managedObjectContext) private var context
    @Environment(\.dismiss) var dismiss
    var card : Cards
    @StateObject var purchase = PurchasesViewModel()
    
    var body: some View {
        Form{
            Section("Add purchase") {
                TextField("Name", text: $purchase.name)
                TextField("Price", text: $purchase.price)
                    .keyboardType(.decimalPad)
                Button {
                    purchase.savePurchase(context: context, card: card) { done in
                        if done {
                            dismiss()
                        }
                    }
                } label: {
                    Text("Save purchase")
                }

                
            }
        }.navigationTitle("Add purchase")
    }
}


