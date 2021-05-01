//
//  CategoryViewController.swift
//  BookStore
//
//  Created by Sanjay Mali on 29/04/21.
//

import UIKit

class CategoryViewController: UIViewController {
    @IBOutlet weak var tableView:UITableView!
    let icon_Array = ["Fiction", "Drama","Humour","Politics","Philosophy","History","Adventure"]
    override func viewDidLoad() {
        super.viewDidLoad()
        let navBackgroundImage = UIImage(named: "Pattern") // Get our image
        self.navigationController!.navigationBar.setBackgroundImage(navBackgroundImage, for: .default) // Set the Nav Bar Image
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 90
        self.tableView.tableFooterView = UIView()
        
    }
}
//MARK: DataSource methods
extension CategoryViewController :UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icon_Array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Category") as! CategoryCell
        cell.icon.image = UIImage(named:icon_Array[indexPath.row])
        cell.titleLbl.text = icon_Array[indexPath.row].uppercased()
        cell.titleLbl.font = UIFont.body_bold_Font
        cell.icon.contentMode = .scaleAspectFit
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Category") as! CategoryCell
        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.4) {
            cell.transform = CGAffineTransform.identity
        }
    }
    
}
//MARK: Delegate methods
extension CategoryViewController :UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let nav = storyboard.instantiateViewController(withIdentifier: "BookStoreViewController") as! BookStoreViewController
        nav.searchString = icon_Array[indexPath.row]
        self.navigationController?.pushViewController(nav, animated: true)
    }
}
