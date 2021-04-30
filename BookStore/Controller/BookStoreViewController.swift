//
//  ViewController.swift
//  BookStore
//
//  Created by Sanjay Mali on 29/04/21.
//

import UIKit
import Alamofire
class BookStoreViewController: UIViewController {
    @IBOutlet weak var collectionView:UICollectionView!
    var bookstore = [Results]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getBookStore()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
}
extension BookStoreViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookstore.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCell", for: indexPath) as! GenreCollectionCell
        cell.titleLbl.text = bookstore[indexPath.row].title
        return cell
    }
}
extension BookStoreViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/3.0
        let yourHeight = yourWidth
        return CGSize(width: yourWidth - 16, height: 250)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
extension BookStoreViewController{
    private func getBookStore(){
        AF.request("http://skunkworks.ignitesol.com:8000/books/")
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    do{
                        let json = try JSONDecoder.init().decode(BooksStore.self, from:response.data!)
                        print("json = \(json)") //JSONSerialization
                        self.bookstore = json.results
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

