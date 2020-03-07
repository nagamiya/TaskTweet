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
    @IBOutlet weak var tableView: UITableView!

    var score: Int = 0
    let userDefaults = UserDefaults.standard
    /* --- 元々のデータ --- */
    let TASKDATA : [String] = ["7:30に起きる",
                "LINE確認",
                "Gmail確認",
                "Pinterest確認",
                "家事を１つする",
                "AtCoderの問題１つとく",
                "開発に関すること30分以上する"]
 
    let POINTDATA : [Int] = [15, 10, 10, 10, 15, 19, 20]
    /* --- 元々のデータここまで --- */
    /* --- 実際に使うデータ --- */
    var savetitle : [String] = []
    var savepoint : [Int] = []
    /* --- ここまで --- */
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
  
        // 保存済みデータがあればそれを保存、なければ初期化で突っ込む
        // スワイプされたらscore加算なので、scoreが0かどうかで初期状態を調べる
        score = userDefaults.integer(forKey: "savescore")
        if score != 0 {
            savetitle = userDefaults.array(forKey: "savetitle") as! [String]
            savepoint = userDefaults.array(forKey: "savepoint") as! [Int]
            scoreLabel.text = String(score) + " Point GET"
        }else{
            savedata_init()
        }
        
    }
    
    /*  ---TableViewの使うことにおいてこの２つが必要--- */
    // TableViewのcellの長さを返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savetitle.count
    }
    
    // numberOfRowsInSectionのところの長さの分だけデータをセット
    // カラーコードメモ：A6C2CE, 9C8F96, EBC57C, 6B799E
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = "▶︎ " + savetitle[indexPath.row]
        
        /* --- 見た目カスタムここから --- */
        tableView.separatorColor = UIColor(hex: "9C8F96")
        cell.textLabel?.textColor = UIColor(hex: "6B799E")
        /* --- 見た目カスタムここまで --- */
        
        return cell
    }
    /* --- TableViewの必須準備ここまで--- */
    
    /* --- スワイプで削除されたら --- */
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // score加算処理して保存
        score = score + savepoint[indexPath.row]
        scoreLabel.text = String(score) + " Point GET"
        userDefaults.set(score, forKey: "savescore")
        
        // 削除されたcellの値を使用データに反映させる
        savetitle.remove(at: indexPath.row)
        savepoint.remove(at: indexPath.row)
        userDefaults.set(savetitle, forKey: "savetitle")
        userDefaults.set(savepoint, forKey: "savepoint")
        
        let indexPathes = [indexPath]
        tableView.deleteRows(at: indexPathes, with: .automatic)
        
    }
    
    /* --- スワイプ削除機能の文字をDeleteからDoneに変更 --- */
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Done"
    }
    
    // データ初期化用
    func savedata_init(){
        savetitle = TASKDATA
        savepoint = POINTDATA
        score = 0
        scoreLabel.text = "Point KYOMU"
        tableView.reloadData()
        userDefaults.set(savetitle, forKey: "savetitle")
        userDefaults.set(savepoint, forKey: "savepoint")
        userDefaults.set(score, forKey: "savescore")
        
    }
    
    @IBAction func tapReset(_ sender: Any) {
        savedata_init()
    }
    
    @IBAction func tapTweet(_ sender: Any) {
        let tweetSub = tweetComment() + "\n\n...Tweet for TaskTweetApp..."
        let tweet = "今日のながみやの優等生力は..." + String(score) + "点です！\n" + tweetSub
        
        let encodedText = tweet.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let encodedText = encodedText,
            let url = URL(string: "https://twitter.com/intent/tweet?text=\(encodedText)") {
            savedata_init()
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
    
    func tweetComment() -> String {
        if score >= 99 {
            return "👏完璧！すごい！！天才！えらい！！！！👏"
        }else if score > 75{
            return "✨流石優等生！！あと少しで天才！✨"
        }else if score > 50{
            return "😎おつかれさま！！今日も一日乗り切った！😎"
        }else if score > 25 {
            return "🙃また明日も頑張ろう🙃"
        }else{
            return "🐰きょむうさにしてやんぞ🐰"
        }
    }
    
}
