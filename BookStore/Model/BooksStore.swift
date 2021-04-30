//
//  BooksStore.swift
//  BookStore
//
//  Created by Sanjay Mali on 29/04/21.
//

import Foundation
struct BooksStore:Decodable{
    let count:Int?
    let next:String?
    let previous:Int?
    let results:[Results]
}
struct Results:Decodable {
    let id:Int?
    let download_count:Int?
    let title:String?
    let media_type:String?
    let authors:[Authors]
    let bookshelves:[String]
//    let formats:[Formates]
}
struct Authors:Decodable{
    let birth_year: Int?
    let death_year:Int?
    let name:String?
}
struct Formates:Decodable{
//    let `application/epub+zip`:String?
//    let `application/epub+zip`:String?
}
