//
//  ViewController.swift
//  GroupingSample
//
//  Created by 高橋翼 on 2021/03/17.
//

import UIKit

class ViewController: UIViewController {
    //データを表示するのに使うテーブル
    @IBOutlet weak var tableView: UITableView!
    //表示するデータの元となる配列を用意
    let dataArray: [SampleData] = [SampleData(groupID: 5, title: "aaa"),
                                   SampleData(groupID: 5, title: "bbb"),
                                   SampleData(groupID: 1, title: "ccc"),
                                   SampleData(groupID: 5, title: "ddd"),
                                   SampleData(groupID: 4, title: "eee"),
                                   SampleData(groupID: 1, title: "fff"),
                                   SampleData(groupID: 3, title: "ggg"),
                                   SampleData(groupID: 3, title: "hhh"),
                                   SampleData(groupID: 7, title: "iii"),
                                   SampleData(groupID: 3, title: "jjj"),
                                   SampleData(groupID: 4, title: "kkk"),
                                   SampleData(groupID: 1, title: "lll"),
                                   SampleData(groupID: 1, title: "nnn"),
                                   SampleData(groupID: 5, title: "mmm")]
    //グルーピング後のデータは辞書型なのでTableViewのIndexPathで参照できるようにkeyを保持する配列が必要
    var groupingIDs: [Int] = []
    //グルーピング後の辞書型のデータ
    var groupingData: [Int : [SampleData]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //データソースの実装先を指定する
        tableView.dataSource = self
        //SampleDataの配列をgroupIDでグルーピングする
        groupingData = Dictionary(grouping: dataArray) { (data) -> Int in
            return data.groupID
        }
        //辞書型のkeysをIntの配列にキャストして保持しておく
        groupingIDs = [Int](groupingData.keys)
        //ソートしておく
        groupingIDs.sort()
    }
    
}

//TableViewのデータソースを実装してあげる
extension ViewController: UITableViewDataSource {
    //表示するセクションの個数を返してあげる
    func numberOfSections(in tableView: UITableView) -> Int {
        //グルーピング後の辞書の個数を返す
        return groupingData.count
    }
    //セクションヘッダーに表示する文字列を返してあげる
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //適当にgroupIDを表示してみる
        return "グルーピングID: \(groupingIDs[section])"
    }
    //セクションないに表示するセルの個数を返してあげる
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //グルーピング後の辞書の該当するkeyの要素の個数を返してあげる (強制アンラップはやめた方がいい)
        return groupingData[groupingIDs[section]]!.count
    }
    //表示するセルを返してあげる
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //ストーリーボードに配置したcellのIdentifierと同じにする
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //適当にタイトルを表示してみる (強制アンラップはやめた方がいい)
        cell.textLabel?.text = groupingData[groupingIDs[indexPath.section]]![indexPath.row].title
        return cell
    }
    
}

