//
//  Font.swift
//  BookStore
//
//  Created by Sanjay Mali on 30/04/21.
//

import Foundation
import UIKit
let MontserratRegular = "Montserrat-Regular"
let MontserratBold = "Montserrat-Bold"
let MontserratMedium = "Montserrat-Medium"
let MontserratSemiBold = "Montserrat-SemiBold"

//let MontserratSemiBold = "Open Sans SemiBold"

extension UIFont {
    static var navigation_title_Font: UIFont {
        return UIFont.init(name:MontserratBold, size: 20.0)!
    }
    static var title_Font: UIFont {
        return UIFont.init(name:MontserratRegular, size: 17.0)!
    }
    static var title_bold_Font: UIFont {
        return UIFont.init(name:MontserratBold, size: 17.0)!
    }
    static var subtitle_Font: UIFont {
        return UIFont.init(name:MontserratRegular, size: 16.0)!
    }
    static var subtitle_bold_Font: UIFont {
        return UIFont.init(name:MontserratBold, size: 16.0)!
    }
    static var font_Regular16: UIFont {
        return UIFont.init(name:MontserratBold, size: 16.0)!
    }
    static var body_bold_Font: UIFont {
        return UIFont.init(name:MontserratBold, size: 14.0)!
    }
    static var book_Name_Font12: UIFont {
        return UIFont.init(name:MontserratRegular, size: 12.0)!
    }
    static var caption_bold_Font: UIFont {
        return UIFont.init(name:MontserratBold, size: 12.0)!
    }
    static var text_link_Font: UIFont {
        return UIFont.init(name:MontserratRegular, size: 12.0)!
    }
    static var big_title_Font: UIFont {
        return UIFont.init(name:MontserratRegular, size: 30.0)!
    }
    static var body_small_Font: UIFont {
        return UIFont.init(name:MontserratRegular, size: 10.0)!
    }
    static var body_tinyl_Font: UIFont {
        return UIFont.init(name:MontserratRegular, size: 8.0)!
    }
    static var body_SemiBold_Font: UIFont {
        return UIFont.init(name:MontserratRegular, size: 30.0)!
    }
    
}
