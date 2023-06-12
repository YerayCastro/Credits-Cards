//
//  DeleteCardView.swift
//  CreditCards
//
//  Created by Yery Castro on 8/3/23.
//

import SwiftUI

struct DeleteCardView: View {
    
    @Environment(\.managedObjectContext) private var context
    @StateObject var cards : CardsViewModel
    
    var body: some View {
        ZStack{
            Color.red.edgesIgnoringSafeArea(.all)
            VStack{
                Text("Are you sure want to delete the card?")
                    .font(.title)
                    .foregroundColor(.white)
                    .bold()
                
                Button {
                    cards.deleteCard(item: cards.updateItem, context: context)
                } label: {
                    Text("Delete")
                        .font(.title3)
                        .foregroundColor(.black)
                        .bold()
                }.buttonStyle(.borderedProminent)
                    .tint(.white)

            }
        }.onDisappear{
            cards.updateItem = nil
        }
    }
}



