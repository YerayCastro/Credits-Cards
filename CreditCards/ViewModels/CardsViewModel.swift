//
//  CardsViewModel.swift
//  CreditCards
//
//  Created by Yery Castro on 8/3/23.
//

import Foundation
import CoreData

class CardsViewModel: ObservableObject {
    @Published var name = ""
    @Published var credit = ""
    @Published var type = ""
    @Published var addCardView = false
    @Published var showDelete = false
    @Published var updateItem : Cards!
    
    let limit : Int = 16
    
    @Published var number : String = "" {
        didSet{
            if number.count > limit {
                number = String(number.prefix(limit))
            }
        }
    }
    
    func saveCard(context: NSManagedObjectContext, completion: @escaping (_ done: Bool) -> Void){
        
        if name.isEmpty || number.isEmpty || credit.isEmpty {
            completion(false)
        } else {
            let newCard = Cards(context: context)
            newCard.id = UUID()
            newCard.name = name
            newCard.type = type
            newCard.credit = Int16(credit) ?? 0
            newCard.number = number
            
            do{
                try context.save()
                print("Guardó")
                completion(true)
            }catch let error as NSError{
                print("No guardó", error.localizedDescription)
                completion(false)
            }
        }
    }
    
    func sendItem(item: Cards, modal: String){
        updateItem = item
        name = item.name ?? ""
        number = item.number ?? ""
        credit = "\(item.credit)"
        type = item.type ?? ""
        if modal == "edit"{
            addCardView.toggle()
        }else{
            showDelete.toggle()
        }
        
    }
    
    func editCard(context: NSManagedObjectContext, completion: @escaping (_ done: Bool) -> Void){
        
        if name.isEmpty || number.isEmpty || credit.isEmpty {
            completion(false)
        } else {
           
            updateItem.name = name
            updateItem.number = number
            updateItem.credit = Int16(credit) ?? 0
            updateItem.type = type
            
            do{
                try context.save()
                print("Editó")
                completion(true)
            }catch let error as NSError{
                print("No editó", error.localizedDescription)
                completion(false)
            }
        }
    }
    
    func deleteCard(item: Cards, context: NSManagedObjectContext){
        context.delete(item)
        do{
            try context.save()
            showDelete.toggle()
            print("Eliminó")
            
        }catch let error as NSError{
            print("No eliminó", error.localizedDescription)
            
        }
    }
}
