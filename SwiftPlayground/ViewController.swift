//
//  ViewController.swift
//  SwiftPlayground
//
//  Created by 이찬형 on 2020/09/04.
//  Copyright © 2020 이찬형. All/Users/lchyung1998/Documents/C_Project/SwiftPlayground/SwiftPlayground/Type1.swift rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableViewMain: UITableView!
    private var newsData: Array<Dictionary<String, Any>>?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // delegate 설정
        tableViewMain.delegate = self
        tableViewMain.dataSource = self
        getNews()
    }
    // API KEY = "0bc3756fdd824c8e8540c512ec0b2405"
    func getNews() {
        // JSON 데이터 가져오기
        let task = URLSession.shared.dataTask(with: URL(string: "https://newsapi.org/v2/top-headlines?country=kr&apiKey=0bc3756fdd824c8e8540c512ec0b2405")!) { (data, response, error) in
            if let dataJson = data {
                do {
                    // JSON 파싱
                    let json = try JSONSerialization.jsonObject(with: dataJson, options: []) as! Dictionary<String, Any>
                    let articles = json["articles"] as! Array<Dictionary<String, Any>>
                    // 전역변수에 값 대입
                    self.newsData = articles
                    // 백그라운드에서 완료된 network 작업을 tableView가 그리도록 dispatch
                    DispatchQueue.main.async {
                        self.tableViewMain.reloadData()
                    }
                }
                catch {}
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let news = newsData {
            return news.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // cell의 형식을 설정
        let cell = tableViewMain.dequeueReusableCell(withIdentifier: "Type1", for: indexPath) as! Type1
        let idx = indexPath.row
        if let news = newsData {
            let row = news[idx]
            if let r = row as? Dictionary<String, Any> {
                if let title = r["title"] as? String {
                    cell.lblTest.text = title
                }
            }
        }
        return cell
    }
    
    // Click table cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
