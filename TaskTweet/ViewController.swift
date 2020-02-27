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
    
    var score: Int = 0
    
    /*
     title: やること
     point: 完了したらゲットできるポイント
     done: 実行したらtrue, してなければfalse
    */
    class TaskInfo{
        var title: String
        var point: Int
        
        init(title: String, point: Int) {
            self.title = title
            self.point = point
        }
    }
    
    var task : [TaskInfo] = []
    let TASKDATA : [String] = ["7:30に起きる",
                "LINE確認",
                "Gmail確認",
                "Pinterest確認",
                "家事を１つする",
                "開発に関すること30分以上する",
                "AtCoderの問題１つとく"]
 
    let POINTDATA : [Int] = [15, 10, 10, 10, 15, 20, 20]
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scoreLabel.text = "Point KYOMU"
        
        // インスタンス生成して突っ込んでいる
        for i in 0 ..< TASKDATA.count {
            let item = TaskInfo(title: TASKDATA[i], point: POINTDATA[i])
            task.append(item)
        }
        
    }
    
    /*  ---TableViewの使うことにおいてこの２つが必要--- */
    // TableViewのcellの長さを返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task.count
    }
    
    // numberOfRowsInSectionのところの長さの分だけデータをセット
    // 見た目カスタムもここでしちゃお
    // color:A6C2CE
    // color:9C8F96
    // color:EBC57C
    // color:6B799E
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = "▶︎ " + task[indexPath.row].title
        
        /* --- 見た目ここから --- */
        tableView.separatorColor = UIColor(hex: "6B799E")
        cell.textLabel?.textColor = UIColor(hex: "9C8F96")
        /* --- 見た目ここまで --- */
        
        return cell
    }
    /* --- TableViewの必須準備ここまで--- */
    
    /* --- スワイプ削除のやつ --- */
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // score加算処理
        let item = task[indexPath.row]
        score = score + item.point
        scoreLabel.text = String(score) + " Point GET"
        
        // 実際に削除すして反映させる
        task.remove(at: indexPath.row)
        let indexPathes = [indexPath]
        tableView.deleteRows(at: indexPathes, with: .automatic)
    }
    
    /* --- スワイプ削除機能の文字をDeleteからDoneに変更 --- */
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Done"
    }

}

