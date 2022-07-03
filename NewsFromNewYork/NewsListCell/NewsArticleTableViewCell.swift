//
//  NewsArticleTableViewCell.swift
//  NewsFromNewYork
//
//  Created by prasanth on 03/07/22.
//

import UIKit

class NewsArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var articletitleLabel: UILabel!
    @IBOutlet weak var articleAbstractLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setUpCell(newsData: NewsDetail) {
        if !(newsData.media?.isEmpty ?? true), let metaData = newsData.media?[0].mediaMetadata, let image = metaData[2].url, let title = newsData.title, let abstract = newsData.abstract, let author = newsData.byline, let date = newsData.publishedDate {
            bgImage.loadImageFrom(urlString: image)
            articleImage.loadImageFrom(urlString: image)
            articletitleLabel.text = title
            articleAbstractLabel.text = abstract
            authorLabel.text = author.isEmpty ? "un-known" : author
            dateLabel.text = date
        }
    }
    
}
