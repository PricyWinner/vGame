//
//  AddViewController.swift
//  vGame
//
//  Created by Alexander Imanuel on 16/01/23.
//

import UIKit

class AddViewController: UIViewController {

    var game:Game?
    var isNewVoucher:Bool?
    var retrieveVoucher:VoucherClass?
    @IBOutlet weak var tf_gameName: UITextField!
    @IBOutlet weak var tf_voucherPrice: UITextField!
    @IBOutlet weak var tf_voucherCredit: UITextField!
    
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("game\(game!.name!)")
        tf_gameName.text = game!.name!
        tf_gameName.textColor = UIColor.systemGray2
        tf_voucherCredit.keyboardType = .asciiCapableNumberPad
        tf_voucherPrice.keyboardType = .asciiCapableNumberPad
//        print(isNewVoucher)
        if(!isNewVoucher!){
            lbl_title.text = "Update Voucher"
            var credit:String = retrieveVoucher!.credit!
            let unit:String = String(credit[credit.index(before: credit.endIndex)])
            credit.remove(at: credit.index(before: credit.endIndex))
            var multiplier:Double?
            if(unit == "K"){
                multiplier = 1000
            }else if(unit == "M"){
                multiplier = 1000000
            }else{
                multiplier = 1
            }
            var creditResult:String = "\((credit as NSString).doubleValue * multiplier!)"
            tf_voucherCredit.text = creditResult
            tf_voucherPrice.text = "\(retrieveVoucher!.price)"
            addBtn.titleLabel?.text = "Update Voucher"
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addVoucherOnClick(_ sender: Any) {
        let alert = UIAlertController(title: "Error", message: "Voucher price cannot be empty", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        if(tf_voucherCredit.text!.isEmpty){
            present(alert, animated: true, completion: nil)
            return
        }
        if(tf_voucherPrice.text!.isEmpty){
            present(alert, animated: true, completion: nil)
            return
        }
        else{
            if(isNewVoucher == true){
                VoucherService.createVoucher(credit: formatToTitle(number: tf_voucherCredit.text!), price: (tf_voucherPrice.text! as NSString).doubleValue ,game: game!)
                VoucherService.getVouchers(game: game!)
                navigationController?.popViewController(animated: true)
            }else{
                VoucherService.updateVoucher(credit: formatToTitle(number: tf_voucherCredit.text!), price: (tf_voucherPrice.text! as NSString).doubleValue ,voucher: retrieveVoucher!)
                navigationController?.popViewController(animated: true)
            }
            
        }
    }
    
    func formatToTitle(number: String) -> String{
        
        let num = (number as NSString).doubleValue
        let thousandNum = num/1000
        let millionNum = num/1000000
        if num >= 1000 && num < 1000000{
            return("\(String(format: "%.1f", thousandNum))K")
        }
        if num >= 1000000{
                return("\(String(format: "%.1f", millionNum))M")
        }
        else{
            if(floor(num) == num){
                return ("\(String(num))")
            }
            return ("\(num)")
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
//    func convert(data:Double){
//        NSNumber num1 = [NSNumber, numberWithDouble:1234567.8369];
//        NSString *numberStr = [NSNumberFormatter localizedStringFromNumber:num1 numberStyle:style];
//    }

}
