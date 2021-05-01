//
//  ViewController.swift
//  BookStore
//
//  Created by Sanjay Mali on 29/04/21.
//

import UIKit
import Alamofire
class BookStoreViewController: UIViewController{
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var searchBox:UITextField!
    var bookstore:BooksStore?
    var bookstoreResult = [Results]()
    var searchString:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = searchString
        self.getBookStore(api:API.init().endPoint + "\(searchString ?? "")")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        searchBox.font = UIFont.font_Regular16
        searchBox.delegate = self
    }
}
extension BookStoreViewController: UICollectionViewDataSource,UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (self.bookstoreResult.count == 0) {
            self.collectionView.setEmptyMessage("No viewable version available.")
        } else {
            self.collectionView.restore()
        }
        return self.bookstoreResult.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCell", for: indexPath) as! GenreCollectionCell
        cell.titleLbl.text = self.bookstoreResult[indexPath.row].title ?? ""
        if indexPath.row == (self.bookstoreResult.count) - 1{ // last cell
            if self.bookstore?.next != nil { // more items to fetch
                getBookStore(api:self.bookstore?.next ?? "")
            }
        }
        return cell
    }
    
//    All other options pdf,rdf,ebook,zip will be share the code later.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let indexPathhtml =  self.bookstoreResult[indexPath.row].formats?.txtHtml
        let indexPathPlainText =  self.bookstoreResult[indexPath.row].formats?.txtPlain
        showAlert.showAlerActionSheet(indexPathhtml:indexPathhtml, indexPathPlainText: indexPathPlainText, ref:self)
    }
    
    private func documentsReader(indexPathhtml:String?, indexPathPlainText:String?){
    }
}
extension BookStoreViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 3
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height:210)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0 )
    }
}
//MARK: Use this extension to get the genre/category books.
extension BookStoreViewController{
    private func getBookStore(api:String){
        print("Api:\(api)")
        AF.request(api)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    do{
                        let json = try JSONDecoder.init().decode(BooksStore.self, from:response.data!)
                        self.bookstore = json
                        self.bookstoreResult.append(contentsOf: json.results)
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    }catch{
                        print(error.localizedDescription)
                    }
                case let .failure(error):
                    print(error)
                }
            }
    }
}
//MARK: Delegate methods of textfield
extension BookStoreViewController:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
//       called when 'return' key pressed. return NO to ignore.
        func textFieldShouldReturn(textField: UITextField!) -> Bool{
            return true;
        }
        if textField == searchBox || textField.text!.count > 1{
            searchBox.layer.borderColor = UIColor(named:"PrimaryColor")?.cgColor
            searchBox.layer.borderWidth = 1
            searchBox.textColor = UIColor(named:"PrimaryColor")
        }
    }
//  Use this extension for search books by author, title, subjects and Bookshelves.
//    We can also implement search functionality in DidEndEditing and we can avoid multiple requests too.
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchBox.layer.borderColor = UIColor(named:"SecondaryColor")?.cgColor
        searchBox.textColor = UIColor(named:"SecondaryColor")
        searchBox.layer.borderWidth = 1
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == searchBox{
            if textField.text!.count > 3 {
                let group = DispatchGroup()
                let queueImage = DispatchQueue(label: "com.BookStoreSearch")
                group.enter()
                queueImage.async(group: group) {
                    sleep(2)
                    print("Search 1")
                    DispatchQueue.main.async {
                        self.userSearch(query:textField.text!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)
                        group.leave()
                    }
                }
                group.notify(queue: .main) {
                    print("all finished.")
                }
            }
            return true
        }
        return false
    }
}
//MARK: Use this extension for search books by author, title, subjects and Bookshelves.
//      Use this extension for the user search, Accepts param as string and string converted into urlHostAllowed
extension BookStoreViewController{
    private func userSearch(query:String){
        print("Search Query:\(API.init().endPoint + query)")
        AF.request(API.init().endPoint + query)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    self.bookstoreResult.removeAll()
                    do{
                        let json = try JSONDecoder.init().decode(BooksStore.self, from:response.data!)
                        self.bookstore = json
                        self.bookstoreResult.append(contentsOf: json.results)
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    }catch{
                        print(error.localizedDescription)
                    }
                case let .failure(error):
                    print(error)
                }
            }
    }
}
//MARK: Use this extension when the dataSource count is 0 and display the message.
extension UICollectionView {
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont.body_SemiBold_Font
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel;
    }
    func restore() {
        self.backgroundView = nil
    }
}
