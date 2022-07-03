//
//  NewsModel.swift
//  NewsFromNewYork
//
//  Created by prasanth on 03/07/22.
//

import Foundation

// MARK: - NewsModel
class NewsModel: Codable {
    var status, copyright: String?
    var numResults: Int?
    var results: [NewsDetail]?

    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults = "num_results"
        case results
    }

    init(status: String?, copyright: String?, numResults: Int?, results: [NewsDetail]?) {
        self.status = status
        self.copyright = copyright
        self.numResults = numResults
        self.results = results
    }
}

// MARK: - NewsDetail
class NewsDetail: Codable {
    var uri: String?
    var url: String?
    var id, assetID: Int?
    var source: Source?
    var publishedDate, updated, section, subsection: String?
    var nytdsection, adxKeywords: String?
    var byline: String?
    var type: ResultType?
    var title, abstract: String?
    var desFacet, orgFacet, perFacet, geoFacet: [String]?
    var media: [Media]?
    var etaID: Int?

    enum CodingKeys: String, CodingKey {
        case uri, url, id
        case assetID = "asset_id"
        case source
        case publishedDate = "published_date"
        case updated, section, subsection, nytdsection
        case adxKeywords = "adx_keywords"
        case byline, type, title, abstract
        case desFacet = "des_facet"
        case orgFacet = "org_facet"
        case perFacet = "per_facet"
        case geoFacet = "geo_facet"
        case media
        case etaID = "eta_id"
    }

    init(uri: String?, url: String?, id: Int?, assetID: Int?, source: Source?, publishedDate: String?, updated: String?, section: String?, subsection: String?, nytdsection: String?, adxKeywords: String?, byline: String?, type: ResultType?, title: String?, abstract: String?, desFacet: [String]?, orgFacet: [String]?, perFacet: [String]?, geoFacet: [String]?, media: [Media]?, etaID: Int?) {
        self.uri = uri
        self.url = url
        self.id = id
        self.assetID = assetID
        self.source = source
        self.publishedDate = publishedDate
        self.updated = updated
        self.section = section
        self.subsection = subsection
        self.nytdsection = nytdsection
        self.adxKeywords = adxKeywords
        self.byline = byline
        self.type = type
        self.title = title
        self.abstract = abstract
        self.desFacet = desFacet
        self.orgFacet = orgFacet
        self.perFacet = perFacet
        self.geoFacet = geoFacet
        self.media = media
        self.etaID = etaID
    }
}

// MARK: - Media
class Media: Codable {
    var type: MediaType?
    var subtype: Subtype?
    var caption, copyright: String?
    var approvedForSyndication: Int?
    var mediaMetadata: [MediaMetadatum]?

    enum CodingKeys: String, CodingKey {
        case type, subtype, caption, copyright
        case approvedForSyndication = "approved_for_syndication"
        case mediaMetadata = "media-metadata"
    }

    init(type: MediaType?, subtype: Subtype?, caption: String?, copyright: String?, approvedForSyndication: Int?, mediaMetadata: [MediaMetadatum]?) {
        self.type = type
        self.subtype = subtype
        self.caption = caption
        self.copyright = copyright
        self.approvedForSyndication = approvedForSyndication
        self.mediaMetadata = mediaMetadata
    }
}

// MARK: - MediaMetadatum
class MediaMetadatum: Codable {
    var url: String?
    var format: Format?
    var height, width: Int?

    init(url: String?, format: Format?, height: Int?, width: Int?) {
        self.url = url
        self.format = format
        self.height = height
        self.width = width
    }
}

enum Format: String, Codable {
    case mediumThreeByTwo210 = "mediumThreeByTwo210"
    case mediumThreeByTwo440 = "mediumThreeByTwo440"
    case standardThumbnail = "Standard Thumbnail"
}

enum Subtype: String, Codable {
    case photo = "photo"
}

enum MediaType: String, Codable {
    case image = "image"
}

enum Source: String, Codable {
    case newYorkTimes = "New York Times"
}

enum ResultType: String, Codable {
    case article = "Article"
}
