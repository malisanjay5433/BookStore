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
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 90
        self.tableView.tableFooterView = UIView()
    }
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        //        if segue.identifier == "Category"{
//        if let cell = sender as? CategoryCell {
//            let i = self.tableView.indexPath(for: cell)
//            if segue.identifier == "Category" {
//                let vc = segue.destination as! BookStoreViewController
//                vc.searchString = icon_Array[i]
//            }
//        }
//    }
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
        cell.icon.contentMode = .scaleAspectFit
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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
