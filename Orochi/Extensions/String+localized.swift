//
//  String+localized.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 19/11/22.
//

import Foundation

// String+localized 
extension String {
    public enum ContextMenu {
        static let markAsRead: String = NSLocalizedString("action_mark_as_read", comment: "")
        static let addToLib: String = NSLocalizedString("action_add_to_library", comment: "")
        static let rmvFromLib: String = NSLocalizedString("action_remove_from_library", comment: "")
    }
    
    public enum Common {
        static let done: String = NSLocalizedString("common_done", comment: "Done")
        static let cancel: String = NSLocalizedString("common_cancel", comment: "Cancel")
        static let add: String = NSLocalizedString("common_add", comment: "")
        static let remove: String = NSLocalizedString("common_remove", comment: "")
    }
    
    public enum Discovery {
        public static var title: String = NSLocalizedString("discovery_title", comment: "Discovery mangas")
        public static var searchPlaceholder: String = NSLocalizedString("discovery_search_placeholder", comment: "Search bar placeholder")
        public static var author: String = NSLocalizedString("discovery_cell_author", comment: "Manga public")
        public static var year: String = NSLocalizedString("discovery_cell_year", comment: "Manga year")
        public static var lastUpdated: String = NSLocalizedString("discovery_cell_last_updated", comment: "Last updated manga")
        public static var ongoing: String = NSLocalizedString("discovery_status_ongoing", comment: "Ongoing manga")
        public static var hiatus: String = NSLocalizedString("discovery_status_hiatus", comment: "Hiatus manga")
        public static var completed: String = NSLocalizedString("discovery_status_completed", comment: "Completed manga")
    }
    
    public enum Library {
        public static var title: String = NSLocalizedString("library_title", comment: "User library")
    }
    
    public enum Settings {
        public static var title: String = NSLocalizedString("settings_title", comment: "User settings")
    }
    
    public enum MangaSource {
        public static var title: String = NSLocalizedString("manga_source_title", comment: "MangaDex Source")
        public static var siteFooter: AttributedString  {
            let string = NSLocalizedString("manga_source_site_footer", comment: "MangaDex website")
            do {
                return try AttributedString(markdown: string)
            } catch { print(error.localizedDescription)}
            return AttributedString(string)
        }
        public static var languageHeader: String = NSLocalizedString("manga_source_language_header", comment: "Language options")
        public static var languageFooter: String = NSLocalizedString("manga_source_language_footer", comment: "Language description")
        public static var qualityHeader: String = NSLocalizedString("manga_source_quality_header", comment: "Manga quality options")
        public static var qualityFooter: AttributedString {
            let string = NSLocalizedString("manga_source_quality_footer", comment: "Manga quality description")
            do {
                return try AttributedString(markdown: string)
            } catch { print(error.localizedDescription) }
            return AttributedString(string)
        }
        public static var lowQuality: String  = NSLocalizedString("manga_source_low_quality", comment: "Low manga quality")
        public static var mediumQuality: String = NSLocalizedString("manga_source_medium_quality", comment: "Medium manga quality")
        public static var highQuality: String = NSLocalizedString("manga_source_high_quality", comment: "High manga quality")
        public static var qualityActionTitle: String = NSLocalizedString("manga_source_quality_title", comment: "Quality action")
        public static var qualityActionDialog: String = NSLocalizedString("manga_source_quality_dialog", comment: "Manga options description")
    }
    
    public enum Filter {
        static let title: String = NSLocalizedString("filter_title", comment: "")
        static let filterByHeader: String = NSLocalizedString("filter_filter_by_header", comment: "")
        static let filterByFooter: String = NSLocalizedString("filter_filter_by_footer", comment: "")
        static let orderByHeader: String = NSLocalizedString("filter_order_by_header", comment: "")
        static let orderByFooter: String = NSLocalizedString("filter_order_by_footer", comment: "")
        static let mangaInfoHeader: String = NSLocalizedString("filter_manga_info_header", comment: "")
        static let mangaInfoFooter: String = NSLocalizedString("filter_manga_info_footer", comment: "")
        static let ascending: String = NSLocalizedString("filter_ascending", comment: "")
        static let descending: String = NSLocalizedString("filter_descending", comment: "")
        static let none: String = NSLocalizedString("filter_none", comment: "")
        static let name: String = NSLocalizedString("filter_name", comment: "")
        static let lastUpdated: String = NSLocalizedString("filter_last_updated", comment: "")
        static let releaseYear: String = NSLocalizedString("filter_release_year", comment: "")
        static let language: String = NSLocalizedString("filter_language", comment: "")
        static let year: String = NSLocalizedString("filter_year", comment: "")
        static let demoPublic: String = NSLocalizedString("filter_public", comment: "")
        static let status: String = NSLocalizedString("filter_status", comment: "")
    }
    
    public enum Manga {
        static let author: String = NSLocalizedString("manga_author", comment: "")
        static let year: String = NSLocalizedString("manga_year", comment: "")
        static let status: String = NSLocalizedString("manga_status", comment: "")
        static let genres: String = NSLocalizedString("manga_genres", comment: "")
        static let updated: String = NSLocalizedString("manga_updated", comment: "")
        static let startReading: String = NSLocalizedString("manga_start_reading", comment: "")
        static let descHeader: String = NSLocalizedString("manga_description_header", comment: "")
        static let chapHeader: String = NSLocalizedString("manga_chapter_header", comment: "")
    }
}
