//
//  CategoryViewController.swift
//  vGame
//
//  Created by Alexander Imanuel on 13/01/23.
//

import UIKit
protocol TableViewCellDelegate: AnyObject{
    func onClick(with game:Game)
}
class CategoryCellController : UITableViewCell{
    weak var delegate:TableViewCellDelegate?
    @IBOutlet weak var iv_category: UIImageView!
    private var selectedGame:Game?
    
//    @IBAction func onClick(_ sender: Any) {
//    }
    
    @IBAction func onClick(_ sender: Any) {
        delegate?.onClick(with: selectedGame!)
    }
    
//    @IBAction func onClick(_ sender: Any) {
//        delegate?.onClick(with: selectedGame!)
//    }
    func conf(with game:Game){
        self.selectedGame = game
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        iv_category.layer.cornerRadius = 15
        iv_category.layer.masksToBounds = true
    }
    
}

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TableViewCellDelegate{
    var selectedGame:Game?
    
    
    func onClick(with selectedGame: Game) {
        
//        ViewController.cart.append(selectedFood)
//        print("\(ViewController.cart.count)")
//        print("onclick view cell:\(selectedGame.name)")
         
        self.selectedGame = selectedGame
        VoucherService.getVouchers(game: selectedGame)
        performSegue(withIdentifier: "toVoucher", sender: self)
        
    }
    override func prepare(for segue:
        UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toVoucher"{
                let dest = segue.destination as! VoucherViewController
                
                dest.retrieveGame = self.selectedGame
            }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        GameService.gameCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryCellController
        
                let game = GameService.gameCategory[GameService.gameCategory.count - indexPath.row - 1]
        //        let img = product.img
        cell.iv_category.image = UIImage(named: game.image!)
//        cell.iv_category.layer.cornerRadius =
//        cell.iv_category.layer.masksToBounds = true
        cell.conf(with: game)
        cell.delegate = self
        return cell
    }
    
    @IBOutlet weak var tv_gameCategory: UITableView!
    
    @IBOutlet weak var labelCategoryPage: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tv_gameCategory.delegate = self
        self.tv_gameCategory.dataSource = self
        
        // Do any additional setup after loading the view.
        if(LoginViewController.iscurrentUserAdmin! == true){
            labelCategoryPage.text = "Welcome, Admin"
        }else{
            labelCategoryPage.text = "Welcome, \(UserService.currentUser.username!)"
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
//
////
////  HomeViewController.swift
////  cucuan
////
////  Created by Alexander Imanuel on 12/12/22.
////
//
//import UIKit
//
//class HomeCellController:UITableViewCell{
//
//
//    @IBOutlet weak var ivImage: UIImageView!
//
//    @IBOutlet weak var tvName: UILabel!
//
//
//    @IBOutlet weak var shopeeView: UIView!
//
//    @IBOutlet weak var tokpedView: UIView!
//
//    @IBOutlet weak var tiktokView: UIView!
//
//    @IBOutlet weak var lbl_shopeeHargaJual: UILabel!
//
//    @IBOutlet weak var lbl_tokpedHargaJual: UILabel!
//
//    @IBOutlet weak var lbl_tiktokHargaJual: UILabel!
//}
//
//
//class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    @IBOutlet weak var btnAdd: UIButton!
//
//    @IBOutlet weak var tv_products: UITableView!
//
//    @IBOutlet weak var buttonView: UIView!
//    private var isNewProduct:Bool = true
//    private var selectedProduct:ProductClass?
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        ProductService.products.count
//    }
//
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! HomeCellController
//
//        let product = ProductService.products[ProductService.products.count - indexPath.row - 1]
////        let img = product.img
//        cell.ivImage.image = UIImage(data: product.img!)
//        cell.tvName.text = product.name
//
//        cell.shopeeView.isHidden = !product.shopeeIsChecked
//        cell.tiktokView.isHidden = !product.tikTokisChecked
//        cell.tokpedView.isHidden = !product.tokPedIsChecked
//
//        if(product.shopeeIsChecked){
//            cell.lbl_shopeeHargaJual.text = String(format: "Rp.%.2f", countSalePrice(modal: product.modal, keuntungan: product.shopeeProfit, biaya: Double(product.shopeeAppFee)))
//            cell.lbl_shopeeHargaJual.adjustsFontSizeToFitWidth = false
//            cell.lbl_shopeeHargaJual.lineBreakMode = NSLineBreakMode.byTruncatingTail
//        }
//        if(product.tokPedIsChecked){
//            cell.lbl_tokpedHargaJual.text = String(format: "Rp.%.2f", countSalePrice(modal: product.modal, keuntungan: product.tokPedProfit, biaya: Double(product.tokPedAppFee)))
//        }
//        if(product.tikTokisChecked){
//            cell.lbl_tiktokHargaJual.text = String(format: "Rp.%.2f", countSalePrice(modal: product.modal, keuntungan: product.tikTokProfit, biaya: Double(product.tikTokAppFee)))
//        }
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        return .none
//    }
//
////    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
////        if editingStyle == .delete {
////            tableView.beginUpdates()
////            ProductService.products.remove(at: indexPath.row)
////            tableView.deleteRows(at: [indexPath], with: .fade)
////            tableView.endUpdates()
////
//
//
////    }
//
//    private func handlerDelete(index: IndexPath, tableView: UITableView) {
//        tableView.beginUpdates()
//
//        ProductService.deleteProduct(product: ProductService.products[ProductService.products.count - index.row - 1])
//        ProductService.products.remove(at: index.row)
//        tableView.deleteRows(at: [index], with: .fade)
//        tableView.endUpdates()
//    }
//    private func handlerUpdate(index:IndexPath, tableView: UITableView) {
//        tableView.beginUpdates()
//
////        ProductService.deleteProduct(product: ProductService.products[index.row + ProductService.products.count - 1])
////        ProductService.products.remove(at: index.row)
////        ProductService.getProducts2()
////        tableView.reloadData()
////        tableView.deleteRows(at: [index], with: .fade)
//        isNewProduct = false
////        print("id product\(index.row + ProductService.products.count - 1)")
////        print(
////            ProductService.products.count - index.row - 1
////        )
////        print("products count: \(ProductService.products.count)")
////        selectedProduct = ProductClass()
//        selectedProduct = ProductService.products[ProductService.products.count - index.row - 1]
//
//        performSegue(withIdentifier: "toAdd", sender: self)
//
////        ProductService.updateProduct(name: "sepatu", product: ProductService.products[index.row + ProductService.products.count - 1])
////        print("update")
//        tableView.reloadData()
//        tableView.endUpdates()
//    }
//
//
//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let delete = UIContextualAction(style: .destructive, title: "Delete") {[weak self] (delete, view, completionHandler) in self?.handlerDelete(index: indexPath, tableView: tableView)
//            completionHandler(true)
//        }
//        delete.backgroundColor = .systemRed
//
//        let update = UIContextualAction(style: .normal, title: "Update") {[weak self] (update, view, completionHandler) in self?.handlerUpdate(index: indexPath, tableView: tableView)
//            completionHandler(true)
//        }
//        update.backgroundColor = .systemGreen
//
//        return UISwipeActionsConfiguration(actions: [delete, update])
//    }
//
//    @IBOutlet weak var helloUser: UILabel!
//
//    @IBOutlet weak var productTableView: UITableView!
//
//    @objc
//    func logoutButton(){
//        navigationController?.popToRootViewController(animated: true)
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.navigationItem.setHidesBackButton(true, animated: true)
//
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButton))
//
//        ProductService.getProducts2()
//        tv_products.reloadData()
//        print("produk count di home\(ProductService.products.count)")
//        btnAdd.layer.cornerRadius = btnAdd.frame.width/2
//
//        btnAdd.layer.masksToBounds = true
//
//        buttonView.layer.cornerRadius = btnAdd.frame.width/2
//        buttonView.layer.masksToBounds = true
//
//        helloUser.text = "Hello, " + (UserService.currUser.userName)!
//
//        self.productTableView.delegate = self
//
//        self.productTableView.dataSource = self
//
//
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        tv_products.reloadData()
//    }
//
//
//
//    func countSalePrice(modal: Double, keuntungan: Double, biaya: Double) -> Double {
//        return modal * (modal + keuntungan) / (modal - biaya)
//    }
//
//
//    @IBAction func addBtnOnclick(_ sender: Any) {
//        isNewProduct = true
//        print("pencet add button")
//
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if segue.identifier == "toAdd" {
//                let dest = segue.destination as! AddViewController
//
//                dest.isNewProduct = isNewProduct
//                dest.retrieveProduct = selectedProduct
//            }
//        }
//
//
//
//}
