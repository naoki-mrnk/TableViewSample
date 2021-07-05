//
//  ViewController.swift
//  TableViewSample
//
//  Created by naoki-mrnk on 2021/07/05.
//

import UIKit

class ViewController: UIViewController, CatchProtocol {
    
    // MARK: - Property
    var Item = ["AAA", "BBB", "CCC", "DDD"]
    
    /// 受け取ったTextを入れる変数
    var reception = String()
    
    
    // MARK: - IBOutlet
    @IBOutlet private weak var fab: UIButton!
    @IBOutlet weak var tableView: UITableView!
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButton()
    }
    
    // MARK: - IBAction
    @IBAction func toAddItemView(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toAddItem", sender: self)
    }
    // 値の受け取り
    func catchData(backString: String) {
        reception = backString
        Item += [reception]
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // FAB
    var startingFrame: CGRect!
    var endingFrame: CGRect!
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) && self.fab.isHidden {
            self.fab.isHidden = false
            self.fab.frame = startingFrame
            UIView.animate(withDuration: 1.0) {
                self.fab.frame = self.endingFrame
            }
        }
    }
    
    func setupButton() {
        fab.layer.cornerRadius = 25
    }
    
    func configureSizes() {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        startingFrame = CGRect(x: 0, y: screenHeight + 100, width: screenWidth, height: 100)
        endingFrame = CGRect(x: 0, y: screenHeight - 100, width: screenWidth, height: 100)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let addItemViewController = segue.destination as! AddItemViewController
        addItemViewController.delegate = self
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel!.text = Item[indexPath.row]
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        self.Item.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
