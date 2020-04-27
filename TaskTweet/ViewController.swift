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

    var currentScore: Int = 0
    let userDefaults = UserDefaults.standard
    /* --- 元々のデータ --- */
    let taskData : [String] = [
                "7:30に起きる",
                "LINE確認",
                "Gmail確認",
                "Pinterest確認",
                "家事を１つする",
                "検査系の勉強２時間",
                "プログラミング30分以上"]
 
    let pointData : [Int] = [15, 10, 10, 10, 15, 19, 20]
    /* --- 元々のデータここまで --- */
    /* --- 実際に使うデータ --- */
    var saveTitle : [String] = []
    var savePoint : [Int] = []
    /* --- ここまで --- */
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
  
        // 保存済みデータがあればそれを保存、なければ初期化で突っ込む
        // スワイプされたらscore加算なので、scoreが0かどうかで初期状態を調べる
        currentScore = userDefaults.integer(forKey: "savescore")
        if currentScore != 0 {
            saveTitle = userDefaults.array(forKey: "savetitle") as! [String]
            savePoint = userDefaults.array(forKey: "savepoint") as! [Int]
            scoreLabel.text = String(currentScore) + " Point GET"
        }else{
            savedata_init()
        }
        
    }
    
    /*  ---TableViewの使うことにおいてこの２つが必要--- */
    // TableViewのcellの長さを返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return saveTitle.count
    }
    
    // numberOfRowsInSectionのところの長さの分だけデータをセット
    // カラーコードメモ：A6C2CE, 9C8F96, EBC57C, 6B799E
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = "▶︎ " + saveTitle[indexPath.row]
        
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
        currentScore = currentScore + savePoint[indexPath.row]
        scoreLabel.text = String(currentScore) + " Point GET"
        userDefaults.set(currentScore, forKey: "savescore")
        
        // 削除されたcellの値を使用データに反映させる
        saveTitle.remove(at: indexPath.row)
        savePoint.remove(at: indexPath.row)
        userDefaults.set(saveTitle, forKey: "savetitle")
        userDefaults.set(savePoint, forKey: "savepoint")
        
        let indexPathes = [indexPath]
        tableView.deleteRows(at: indexPathes, with: .automatic)
        
    }
    
    /* --- スワイプ削除機能の文字をDeleteからDoneに変更 --- */
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Done"
    }
    
    // データ初期化用
    func savedata_init(){
        saveTitle = taskData
        savePoint = pointData
        currentScore = 0
        scoreLabel.text = "Point KYOMU"
        tableView.reloadData()
        userDefaults.set(saveTitle, forKey: "savetitle")
        userDefaults.set(savePoint, forKey: "savepoint")
        userDefaults.set(currentScore, forKey: "savescore")
        
    }
    
    @IBAction func tapReset(_ sender: Any) {
        savedata_init()
    }
    
    @IBAction func tapTweet(_ sender: Any) {
        let tweetSub = tweetComment() + "\n\n...Tweet for TaskTweetApp..."
        let tweet = "今日のながみやの優等生力は..." + String(currentScore) + "点です！\n" + tweetSub
        
        let encodedText = tweet.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let encodedText = encodedText,
            let url = URL(string: "https://twitter.com/intent/tweet?text=\(encodedText)") {
            savedata_init()
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
    
    func tweetComment() -> String {
        if currentScore >= 99 {
            return "👏完璧！すごい！！天才！えらい！！！！👏"
        }else if currentScore > 75{
            return "✨流石優等生！！あと少しで天才！✨"
        }else if currentScore > 50{
            return "😎おつかれさま！！今日も一日乗り切った！😎"
        }else if currentScore > 25 {
            return "🙃また明日も頑張ろう🙃"
        }else{
            return "🐰きょむうさにしてやんぞ🐰"
        }
    }
    
}
