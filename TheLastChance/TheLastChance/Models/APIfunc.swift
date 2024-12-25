//
//  APIfunc.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 12.10.2024.
//

import Foundation

enum APIfunc: String {
    case test = "pet_info/5"
    case login = "login"
    case registrate = "register"
    case addPet = "add_pet"
    case deletePet = "delete_pet"
    case updatePet = "update_pet"
    case getUserInfo = "get_user_info"
    case getPetInfo = "pet_info"
    case getPets = "get_pet_list"
    case getServices = "get_all_services"
    case addService = "add_service"
    case deleteService = "delete_service"
    case updateUser = "update_user"
    case getAdvice = "get_advice"
    case getWordsForFilter = "get_top_animals"
}
