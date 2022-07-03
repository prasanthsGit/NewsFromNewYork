//
//  NewsListViewController.swift
//  NewsFromNewYork
//
//  Created by prasanth on 03/07/22.
//

import UIKit

class NewsListViewController: UIViewController {
    
    @IBOutlet weak var articleListTable: UITableView!
    var newsList: [NewsDetail]?
    var newsUrl: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        articleListTable.register(UINib(nibName: "NewsArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsArticleTableViewCell")
        newsUrl = Constants.shared.url + Constants.shared.apiKey
        newsListAPICall(urL: newsUrl) { status in
            print("api status: \(status)")
        }
    }
    
    //MARK: API Calling
    func newsListAPICall(urL: String, completion: @escaping (_ status: Bool) -> Void) {
        guard let url = URL(string: urL) else { return }
        if Reachability.shared.isConnectedToNetwork() {
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                if let data = data {
                    print(data)
                    if let newsData = try? JSONDecoder().decode(NewsModel.self, from: data) {
                        self?.newsList = newsData.results
                        if self?.newsList?.isEmpty ?? true {
                            self?.showAlert(message: "No data found!")
                        } else {
                            DispatchQueue.main.async {
                                self?.articleListTable.reloadData()
                            }
                        }
                        completion(true)
                    } else {
                        DispatchQueue.main.async {
                            self?.showAlert(message: "Invalid Response")
                        }
                        completion(false)
                    }
                } else if let error = error {
                    DispatchQueue.main.async {
                        self?.showAlert(message: "HTTP Request Failed \(error)")
                    }
                    completion(false)
                }
            }
            task.resume()
        } else {
            self.showAlert(message: "Please check your internet connection!")
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let artcileTableCell = tableView.dequeueReusableCell(withIdentifier: "NewsArticleTableViewCell", for: indexPath) as? NewsArticleTableViewCell else { return UITableViewCell() }
        if let newsDetail = newsList?[indexPath.row] {
            artcileTableCell.setUpCell(newsData: newsDetail)
        }
        artcileTableCell.selectionStyle = .none
        return artcileTableCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "WebViewNewsDetailViewController") as? WebViewNewsDetailViewController else { return }
        if let newsDetail = newsList?[indexPath.row] {
            controller.urString = newsDetail.url
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
