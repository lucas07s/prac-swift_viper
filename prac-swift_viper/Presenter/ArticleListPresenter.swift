//
//  ArticlePresenter.swift
//  prac-swift_viper
//
//  Created by Lucas on 2022/12/22.
//

import Foundation

protocol ArticleListPresenterProtocol: AnyObject {

    func didLoad()
    func didSelect(articleEntity: ArticleEntity)

}

protocol ArticleListViewProtocol: AnyObject {

    func showArticles(_ articleEntities: [ArticleEntity])
    func showEmpty()
    func showError(_ error: Error )

}

class ArticleListPresenter {

    struct Dependency {
        let router: ArticleListRouterProtocol!
        let getArticleArrayUseCase: UseCase<Void, [ArticleEntity], Error>
    }

    weak var view: ArticleListViewProtocol!
    private var di: Dependency

    init(view: ArticleListViewProtocol, inject dependency: Dependency) {
        self.view = view
        self.di = dependency
    }

}

extension ArticleListPresenter: ArticleListPresenterProtocol {

    func didLoad() {
        di.getArticleArrayUseCase.execute(()) { [weak self] result in

            guard let self = self else { return }

            switch result {
                case .success(let articleEntities):
                    if articleEntities.isEmpty {
                        self.view.showEmpty()
                        return
                    }
                    self.view.showArticles(articleEntities)
                case .failure(let error):
                    self.view.showError(error)
            }

        }
    }

    func didSelect(articleEntity: ArticleEntity) {
        di.router.showArticleDetail(articleEntity: articleEntity )
    }


}
