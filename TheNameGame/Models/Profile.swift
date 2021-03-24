//
//  Profile.swift
//  TheNameGame
//
//  Created by Lynk on 3/23/21.
//

import Foundation


struct Profile: Codable {
    let firstName: String
    let lastName: String
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    let headshot: Headshot
}


struct Headshot: Codable {
    let url: URL?
}
