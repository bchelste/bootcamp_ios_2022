//
//  ArticleManager.swift
//  bchelste2022
//
//  Created by Artem Potekhin on 21.08.2022.
//

import Foundation
import CoreData

public class ArticleManager {
    
    let modelName = "article"
    
    lazy var model: NSManagedObjectModel = {
        let bundle = Bundle(for: type(of: self))
        guard let modelURL = bundle.url(forResource: modelName, withExtension: "momd"),
              let resultModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Data model is not presented!")
        }
        return resultModel
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName, managedObjectModel: model)
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unresolved error \(error), \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    public static let shared = ArticleManager()
    
    public init() {
        
    }
    
    public func newArticle() -> Article {
        let article = NSEntityDescription.insertNewObject(forEntityName: "Article",
                                                          into: self.context) as! Article
        return article
    }
    
    public func getAllArticles() -> [Article] {
        let request: NSFetchRequest<Article> = Article.fetchRequest()
        var result = [Article]()
        do {
            try result.append(contentsOf: context.fetch(request))
        } catch {
            print("getAllArticles error: \(error.localizedDescription)")
        }
        return result
    }
    
    public func getArticles(withLang lang: String) -> [Article] {
        let request: NSFetchRequest<Article> = Article.fetchRequest()
        request.predicate = NSPredicate(format: "language == %@", lang)
        var result = [Article]()
        do {
            try result.append(contentsOf: context.fetch(request))
        } catch {
            print("getArticles with Lang error: \(error.localizedDescription)")
        }
        return result
    }
    
    public func getArticles(containingString str: String) -> [Article] {
        let request: NSFetchRequest<Article> = Article.fetchRequest()
        request.predicate = NSPredicate(format: "(title CONTAINS[cd] %@) || (content CONTAINS[cd] %@)",
                                        str, str)
        var result = [Article]()
        do {
            try result.append(contentsOf: context.fetch(request))
        } catch {
            print("getArticles containing str error: \(error.localizedDescription)")
        }
        return result
    }
    
    public func removeArticle(article: Article) {
        context.delete(article)
    }
    
    public func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                fatalError("Unresolved error \(error), \(error.localizedDescription)")
            }
        }
    }
}
