//
//  DetailViewController.swift
//  vGame
//
//  Created by Alexander Imanuel on 16/01/23.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var iv_game: UIImageView!
    @IBOutlet weak var lbl_gameNam: UILabel!
    @IBOutlet weak var lbl_email: UILabel!
    @IBOutlet weak var lbl_credit: UILabel!
    @IBOutlet weak var lbl_totalPrice: UILabel!
    @IBOutlet weak var CodeView: UIView!
    @IBOutlet weak var lbl_voucherCode: UILabel!
    @IBOutlet weak var copyToClipboardBtn: UIButton!
    var retrieveVoucher:VoucherClass?
    var isNewProduct:Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        print(isNewProduct)
        CodeView.layer.borderWidth = 3
        CodeView.layer.borderColor = UIColor.systemOrange.cgColor
        CodeView.layer.cornerRadius = 10
        
        iv_game.layer.cornerRadius = 15
        iv_game.layer.masksToBounds = true
        iv_game.image = UIImage(named: retrieveVoucher!.game!.image!)
        lbl_gameNam.text = UserService.currentUser.email!
        lbl_credit.text = retrieveVoucher?.credit
        lbl_totalPrice.text =  String(format: "Rp.%.2f", retrieveVoucher!.price)
        // Do any additional setup after loading the view.
        lbl_voucherCode.text = "\(String(describing: retrieveVoucher!.redeemCode!))"
        
    }
    
    @IBAction func btnCopy(_ sender: Any) {
        UIPasteboard.general.string = "\(String(describing: retrieveVoucher!.redeemCode!))"
        toastMsg("Copied to clipboard")
    }
    
    @IBAction func buyBtn(_ sender: Any) {
        CodeView.isHidden = false
        VoucherService.buyVoucher(voucher: retrieveVoucher!)
        
    }
    
    func toastMsg(_ msg: String) {
        
        let alertDisapperTimeInSeconds = 1.0
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .actionSheet)
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + alertDisapperTimeInSeconds) {
          alert.dismiss(animated: true)
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
