//
//  VoucherViewController.swift
//  vGame
//
//  Created by Alexander Imanuel on 16/01/23.
//

import UIKit
protocol VoucherTableViewCellDelegate: AnyObject{
    func onClick(with voucher:VoucherClass)
}

class VoucherTableViewCell:UITableViewCell{
    
    weak var delegate:VoucherTableViewCellDelegate?
    
    private var voucher:VoucherClass?
    
    @IBAction func voucherOnClick(_ sender: Any) {
        delegate?.onClick(with: voucher!)
    }
    func conf(with voucher:VoucherClass){
        self.voucher = voucher
    }

    @IBAction func btnToDetail(_ sender: Any) {
        
    }
    @IBOutlet weak var lbl_gamename: UILabel!
    @IBOutlet weak var iv_image: UIImageView!
    @IBOutlet weak var lbl_price: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        iv_image.layer.cornerRadius = 10
        iv_image.layer.masksToBounds = true
    }
    
    
}

class VoucherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,
    VoucherTableViewCellDelegate{
        private var isNewVoucher:Bool = true
    func onClick(with voucher: VoucherClass) {
        selectedVoucher = voucher
        performSegue(withIdentifier: "toDetail", sender: self)
    }
    
    private var selectedVoucher:VoucherClass?
    
    @IBOutlet weak var buttonView: UIView!
    
    @IBOutlet weak var btnAdd: UIButton!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        VoucherService.vouchers.count
    }
    
    
    @IBAction func addVoucher(_ sender: Any) {
//        print("add")
        self.isNewVoucher = true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "voucherCell", for: indexPath) as! VoucherTableViewCell

        let voucher = VoucherService.vouchers[VoucherService.vouchers.count - indexPath.row - 1]
        cell.iv_image.image = UIImage(named: retrieveGame!.image!)
        cell.lbl_price.text = voucher.credit
//        cell.lbl_price.text = String(voucher.credit)
        cell.lbl_gamename.text = ("\(voucher.game!.name!) \(voucher.credit!)")
        cell.lbl_price.text = ("Rp.\(String(voucher.price))")
        cell.conf(with: voucher)
        if(!LoginViewController.iscurrentUserAdmin!){
            cell.delegate = self
        }
        else{

        }
        return cell
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    func handlerDelete(index: IndexPath, tableView: UITableView) {
        tableView.beginUpdates()
        VoucherService.deleteVoucher(voucher: VoucherService.vouchers[VoucherService.vouchers.count - index.row - 1])
        VoucherService.vouchers.remove(at: index.row)
        tableView.deleteRows(at: [index], with: .fade)
        tableView.endUpdates()
    }
    func handlerUpdate(index:IndexPath, tableView: UITableView) {
        tableView.beginUpdates()
        self.isNewVoucher = false
        selectedVoucher2 = VoucherService.vouchers[VoucherService.vouchers.count - index.row - 1]
        performSegue(withIdentifier: "toAdd", sender: self)
        tableView.reloadData()
        tableView.endUpdates()
    }
        
        func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let delete = UIContextualAction(style: .destructive, title: "Delete") {[weak self] (delete, view, completionHandler) in self?.handlerDelete(index: indexPath, tableView: tableView)
                completionHandler(true)
            }
            delete.backgroundColor = .systemRed
            
            let update = UIContextualAction(style: .normal, title: "Update") {[weak self] (update, view, completionHandler) in self?.handlerUpdate(index: indexPath, tableView: tableView)
                completionHandler(true)
            }
            update.backgroundColor = .systemGreen
            
            return UISwipeActionsConfiguration(actions: [delete, update])
        }

//    func onClick(with name:String) {
//
//    }
    
    
    var retrieveGame:Game?
    var selectedVoucher2:VoucherClass?
    @IBOutlet weak var tv_voucher: UITableView!
    @IBOutlet weak var lbl_title: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl_title.text = retrieveGame!.name!
        self.tv_voucher.delegate = self
        self.tv_voucher.dataSource = self
        // Do any additional setup after loading the view.
//        VoucherService.getVouchers(game: retrieveGame!)
//        tv_voucher.reloadData()
        if(LoginViewController.iscurrentUserAdmin!) {
            btnAdd.isHidden = false
            buttonView.isHidden = false
            btnAdd.layer.cornerRadius = btnAdd.frame.width/2
            
            btnAdd.layer.masksToBounds = true
            
            buttonView.layer.cornerRadius = btnAdd.frame.width/2
            buttonView.layer.masksToBounds = true
            btnAdd.tintColor = UIColor(red: 246, green: 135, blue: 18, alpha: 0)
        } else {
            btnAdd.isHidden = true
            buttonView.isHidden = true
        }
        
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        tv_voucher.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAdd" {
                    let dest = segue.destination as! AddViewController
            dest.retrieveVoucher = self.selectedVoucher2
            dest.game = self.retrieveGame!
            dest.isNewVoucher = self.isNewVoucher
                }
        if segue.identifier == "toDetail" {
                    let dest = segue.destination as! DetailViewController

            dest.retrieveVoucher = self.selectedVoucher!
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
