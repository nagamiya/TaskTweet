//
//  ViewController.swift
//  TaskTweet
//
//  Created by Nagamiya on 2020/02/27.
//  Copyright © 2020 NAGAMIYA. All rights reserved.
//  

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var scoreLabel: UILabel!
    //var tweetButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: Selector(("tapTweetButton")))
    
    
    var score: Int = 0
    let userDefaults = UserDefaults.standard
    /* --- 元々のデータ --- */
    let TASKDATA : [String] = ["7:30に起きる",
                "LINE確認",
                "Gmail確認",
                "Pinterest確認",
                "家事を１つする",
                "開発に関すること30分以上する",
                "AtCoderの問題１つとく"]
 
    let POINTDATA : [Int] = [15, 10, 10, 10, 15, 20, 20]
    /* --- 元々のデータここまで --- */
    /* --- １日分 --- */
    var savetitle : [String] = []
    var savepoint : [Int] = []
    /* --- １日分 --- */
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationItem.setRightBarButtonItems([tweetButton], animated: true)

        
        score = userDefaults.integer(forKey: "savescore")
        print(score)
        
        // 保存済みデータがあればそれを保存、なければ初期化で突っ込む
        if score != 0 {
            print("a")
            savetitle = userDefaults.array(forKey: "savetitle") as! [String]
            savepoint = userDefaults.array(forKey: "savepoint") as! [Int]
            scoreLabel.text = String(score) + " Point GET"
        }else{
            print("b")
            savetitle = TASKDATA
            savepoint = POINTDATA
            scoreLabel.text = "Point KYOMU"
        }
        
    }
    /*  ---TableViewの使うことにおいてこの２つが必要--- */
    // TableViewのcellの長さを返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savetitle.count
    }
    
    // numberOfRowsInSectionのところの長さの分だけデータをセット
    // 見た目カスタムもここでしちゃお
    // color:A6C2CE
    // color:9C8F96
    // color:EBC57C
    // color:6B799E
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = "▶︎ " + savetitle[indexPath.row]
        
        /* --- 見た目ここから --- */
        tableView.separatorColor = UIColor(hex: "9C8F96")
        cell.textLabel?.textColor = UIColor(hex: "6B799E")
        
        /* --- 見た目ここまで --- */
        
        return cell
    }
    /* --- TableViewの必須準備ここまで--- */
    
    /* --- スワイプ削除のやつ --- */
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // score加算処理
        score = score + savepoint[indexPath.row]
        scoreLabel.text = String(score) + " Point GET"
        userDefaults.set(score, forKey: "savescore")
        
        // 実際に削除して反映させる
        savetitle.remove(at: indexPath.row)
        savepoint.remove(at: indexPath.row)
        userDefaults.set(savetitle, forKey: "savetitle")
        userDefaults.set(savepoint, forKey: "savepoint")
        
        //task.remove(at: indexPath.row)
        let indexPathes = [indexPath]
        tableView.deleteRows(at: indexPathes, with: .automatic)
        
        
    }
    
    /* --- スワイプ削除機能の文字をDeleteからDoneに変更 --- */
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Done"
    }
    
    @IBAction func tapReset(_ sender: Any) {
        
    }
    
    @IBAction func tapTweet(_ sender: Any) {
        
    }
    
}
