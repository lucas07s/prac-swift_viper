//
//  ArticleListViewController.swift
//  prac-swift_viper
//
//  Created by Lucas on 2022/12/22.
//

import UIKit

class ArticleListViewController: UIViewController {

    var presenter: ArticleListPresenterProtocol!

    @IBOutlet private weak var tableView: UITableView!

    private var articleEntities = [ArticleEntity]()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.didLoad()

        self.title = "投稿リスト"

    }

}

extension ArticleListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleEntities.count
    }
}

extension ArticleListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = articleEntities[indexPath.row].title
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        presenter.didSelect(articleEntity: articleEntities[indexPath.row])
    }
}

extension ArticleListViewController: ArticleListViewProtocol {

    func showArticles(_ articleEntities: [ArticleEntity]) {
        self.articleEntities = articleEntities
        tableView.reloadData()
    }

    func showEmpty() {
        showArticles([])
    }

    func showError(_ error: Error) {

    }


}
