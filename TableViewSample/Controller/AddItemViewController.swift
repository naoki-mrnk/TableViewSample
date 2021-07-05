//
//  AddItemViewController.swift
//  TableViewSample
//
//  Created by naokmi-mrnk on 2021/07/05.
//

import UIKit

class AddItemViewController: UIViewController {
    // MARK: - Properties
    /// CatchProtocol
    var delegate:CatchProtocol?
    /// 前の画面に戻すTextを入れておく変数
    var backString = String()
    
    // MARK: - IBOutlet
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBAction
    @IBAction func addArray(_ sender: UIButton) {
        // TextFieldからtextを取得
        backString = textField.text!
        // 渡したい引数
        delegate?.catchData(backString: backString)
        // 前の画面に戻る
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Protocol
protocol CatchProtocol {
    func catchData (backString: String)
}
