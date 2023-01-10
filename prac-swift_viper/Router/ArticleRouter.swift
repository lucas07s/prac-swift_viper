//
//  ArticleRouter.swift
//  prac-swift_viper
//
//  Created by Lucas on 2022/12/22.
//

import UIKit

protocol ArticleListRouterProtocol: AnyObject {

    func showArticleDetail(articleEntity: ArticleEntity)

}

class ArticleListRouter: ArticleListRouterProtocol {

    weak var view: UIViewController!

    init(view: UIViewController) {
        self.view = view
    }

    func showArticleDetail(articleEntity: ArticleEntity) {
        print("詳細画面へ遷移する 記事ID:\(articleEntity.id)")

        guard let articleDetailViewController = UIStoryboard(name: "ArticleDetail", bundle: nil).instantiateInitialViewController() as? ArticleDetailViewController else {
            fatalError()
        }

        articleDetailViewController.articleEntity = articleEntity

        articleDetailViewController.presenter = ArticleDetailPresenter(
            view: articleDetailViewController,
            inject: ArticleDetailPresenter.Dependency(
                getArticleByIdUseCase: UseCase(GetArticleByIdUseCase())
            )
        )

        view.navigationController?.pushViewController(articleDetailViewController, animated: true)

    }

}
