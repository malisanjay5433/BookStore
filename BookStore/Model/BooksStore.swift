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
    let previous:String?
    let results:[Results]
}
struct Results:Decodable {
    let id:Int?
    let download_count:Int?
    let title:String?
    let media_type:String?
    let authors:[Authors]
    let bookshelves:[String]
    let formats:Formats?
}
struct Authors:Decodable{
    let birth_year: Int?
    let death_year:Int?
    let name:String?
}
struct Formats:Codable{
    let pdf: String?
    let zip: String?
    let ebook: String?
    let rdf: String?
    let txtPlain: String?
    let txtHtml:String?
    enum CodingKeys: String, CodingKey {
        case pdf = "application/pdf"
        case zip = "application/epub+zip"
        case txtPlain = "text/plain; charset=utf-8"
        case rdf = "application/rdf+xml"
        case txtHtml = "text/html; charset=utf-8"
        case ebook = "application/x-mobipocket-ebook"
    }
}
//application/epub+zip
//"http://www.gutenberg.org/ebooks/1342.epub.images"
//application/pdf
//"http://www.gutenberg.org/files/1342/1342-pdf.zip"
//application/rdf+xml
//"http://www.gutenberg.org/ebooks/1342.rdf"
//application/x-mobipocket-ebook
//"http://www.gutenberg.org/ebooks/1342.kindle.images"
//application/zip
//"http://www.gutenberg.org/files/1342/1342-0.zip"
//text/html; charset=utf-8
//"http://www.gutenberg.org/files/1342/1342-h.zip"
//text/plain; charset=us-ascii
//"http://www.gutenberg.org/files/1342/1342.zip"
