//
//  ViewController.swift
//  TaskTweet
//
//  Created by Nagamiya on 2020/02/27.
//  Copyright © 2020 NAGAMIYA. All rights reserved.
//  

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let testTODO = ["a", "b", "c", "d"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    /*  ---TableViewの使うことにおいてこの２つが必要--- */
    // TableViewのcellの長さを返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testTODO.count
    }
    
    // numberOfRowsInSectionのところの長さの分だけデータをセット
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = testTODO[indexPath.row]
        return cell
    }
    /* --- TableViewの必須準備ここまで--- */
    

}

