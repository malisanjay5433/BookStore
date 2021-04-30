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
    var searchString:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = searchString
        self.getBookStore()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    func addNavBarImage() {
        let navController = navigationController!
        let image = UIImage(named: "Pattern") //Your logo url here
        let imageView = UIImageView(image: image)
        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height
        let bannerX = bannerWidth / 2 - (image?.size.width)! / 2
        let bannerY = bannerHeight / 2 - (image?.size.height)! / 2
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
    
}
extension BookStoreViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (self.bookstore.count == 0) {
            self.collectionView.setEmptyMessage("No viewable version available.")
        } else {
            self.collectionView.restore()
        }
        return bookstore.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCell", for: indexPath) as! GenreCollectionCell
        cell.titleLbl.text = bookstore[indexPath.row].title
        return cell
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
        return CGSize(width: size, height:200)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 4, left: 4, bottom: 4, right: 4 )
    }
}
extension BookStoreViewController{
    private func getBookStore(){
        let api = "http://skunkworks.ignitesol.com:8000/books/?search=\(searchString ?? "")"
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

extension UICollectionView {
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
