//
//  Home.swift
//  CreditCards
//
//  Created by Yery Castro on 8/3/23.
//

import SwiftUI
import CoreData

struct Home: View {
    
    @FetchRequest(entity: Cards.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)],animation: .spring()) var results : FetchedResults<Cards>
    
    
    @StateObject var card = CardsViewModel()
    
    
    @State private var copyNumber = UIPasteboard.general
    
    var body: some View {
        NavigationStack{
            VStack{
                List{
                    ForEach(results){ item in
                        NavigationLink(value: item){
                            CardView(name: item.name, number: item.number, type: item.type)
                        }
                        .navigationDestination(for: Cards.self) { item in
                            PurchaseView(card: item)
                        }.contextMenu{
                            Button {
                                card.sendItem(item: item, modal: "edit")
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            
                            Button {
                                copyNumber.string = item.number
                            } label: {
                                Label("Copy", systemImage: "doc.on.doc")
                            }
                            
                            Button(role: .destructive) {
                                card.sendItem(item: item, modal: "delete")
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }



                        }
                    }
                }.listStyle(.plain)
            }
            .toolbar{
                Button {
                    card.addCardView.toggle()
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.orange)
                }

            }.sheet(isPresented: $card.addCardView) {
                AddCardView(cards: card)
            }.sheet(isPresented: $card.showDelete) {
                DeleteCardView(cards: card)
                    .presentationDetents([.medium])
            }
            .navigationTitle("Credit Cards")
        }
    }
}

struct CardView: View {
    
    var name : String?
    var number : String?
    var type : String?
    
    @State private var color1 : Color = .red
    @State private var color2 : Color = .orange
    @State private var creditNumber = ""
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Spacer()
                Text(type ?? "")
                    .foregroundColor(.white)
                    .font(.system(size: 24))
                    .bold()
            }
            Spacer()
            Text(creditNumber)
                .foregroundColor(.white)
                .font(.title2)
                .bold()
            Spacer()
            HStack{
                VStack(alignment: .leading){
                    Text(name ?? "")
                        .font(.title3)
                        .foregroundColor(.white)
                        .bold()
                }
                Spacer()
            }
        }.frame(width: 300, height: 200)
            .padding(.all)
            .background(LinearGradient(gradient: Gradient(colors: [color1, color2]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(10)
            .onAppear{
                if type == "VISA" {
                    color1 = .orange
                    color2 = .red
                } else if type == "MASTER CARD" {
                    color1 = .blue
                    color2 = .green
                }else {
                    color1 = .gray
                    color2 = .blue
                }
                
                creditNumber = number?.replacingOccurrences(of: "(\\d{4})(\\d{4})(\\d{4})(\\d{4})", with: "$1 $2 $3 $4" , options: .regularExpression, range: nil) ?? number ?? ""
                
            }
    }
}

