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
        static let asRead: String = NSLocalizedString("action_read", comment: "Mark chapter as read")
        static let asUnread: String = NSLocalizedString("action_unread", comment: "Mark chapter as unread")
        static let markAsRead: String = NSLocalizedString("action_mark_as_read", comment: "Mark chapter as read")
        static let markAsUnread: String = NSLocalizedString("action_mark_as_unread", comment: "Mark chapter as unread")
        static let download: String = NSLocalizedString("action_download", comment: "Download chapter action")
        static let addToLib: String = NSLocalizedString("action_add_to_library", comment: "Add manga to library")
        static let rmvFromLib: String = NSLocalizedString("action_remove_from_library", comment: "Remove chapter from library")
        static let markPrevious: String = NSLocalizedString("action_mark_previous", comment: "Mark previous chapters")
        static let savePage: String = NSLocalizedString("action_save_page", comment: "Save chapter page")
    }
    
    public enum Errors {
        static let anilistLogInError: String = NSLocalizedString("error_anilist_login", comment: "AniList account LogIn error")
        static let anilistLogOutError: String = NSLocalizedString("error_anilist_logout", comment: "AniList account LogOut error")
        static let keychainSave: String = NSLocalizedString("error_keychain_save", comment: "Keychain save error")
    }
    
    public enum Common {
        static let done: String = NSLocalizedString("common_done", comment: "Done")
        static let cancel: String = NSLocalizedString("common_cancel", comment: "Cancel")
        static let add: String = NSLocalizedString("common_add", comment: "Add")
        static let remove: String = NSLocalizedString("common_remove", comment: "Remove")
        static let search: String = NSLocalizedString("common_search", comment: "Search bar")
        static let all: String = NSLocalizedString("common_all", comment: "All")
        static let none: String = NSLocalizedString("common_none", comment: "None")
        static let of: String = NSLocalizedString("common_of", comment: "Of preposition")
        static let ok: String = NSLocalizedString("common_ok", comment: "OK")
        static let attention: String = NSLocalizedString("common_attention", comment: "Attention")
        static let error: String = NSLocalizedString("common_error", comment: "Error")
    }
    
    public enum Anilist {
        static let logOutMessage: String = NSLocalizedString("anilist_logout", comment: "AniList account LogOut")
    }
    
    public enum Discovery {
        public static var title: String = NSLocalizedString("discovery_title", comment: "Discovery mangas")
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
        public static var mangaQuality: String = NSLocalizedString("manga_source_quality", comment: "Manga Quality")
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
        static let author: String = NSLocalizedString("manga_author", comment: "Manga author")
        static let year: String = NSLocalizedString("manga_year", comment: "Manga release year")
        static let status: String = NSLocalizedString("manga_status", comment: "Manga status")
        static let genres: String = NSLocalizedString("manga_genres", comment: "Manga genres")
        static let updated: String = NSLocalizedString("manga_updated", comment: "Manga las time updated")
        static let selectChapters: String = NSLocalizedString("manga_select_chapters", comment: "Select manga chapters")
        static let startReading: String = NSLocalizedString("manga_start_reading", comment: "Manga start reading button")
        static let addToLibrary: String = NSLocalizedString("manga_add_to_library", comment: "Add to library")
        static let descHeader: String = NSLocalizedString("manga_description_header", comment: "Manga description title")
        static let chapHeader: String = NSLocalizedString("manga_chapter_header", comment: "Manga chapters title")
        static let mark: String = NSLocalizedString("manga_mark", comment: "Mark chapter")
        static let selectedChapters: String = NSLocalizedString("manga_selected_chapters", comment: "Selected manga chapters")
    }
    
    public enum Chapter {
        static let chaptersOf: String = NSLocalizedString("manga_chapters_of", comment: "Chapter Of")
    }
    
    public enum Adjusts {
        static let trackerHeader: String = NSLocalizedString("adjusts_tracker_header", comment: "")
        static var trackerFooter: AttributedString {
            let string = NSLocalizedString("adjusts_tracker_footer", comment: "")
            do {
                return try AttributedString(markdown: string)
            } catch { print(error.localizedDescription)}
            return AttributedString(string)
        }
        static let trackerUser: String = NSLocalizedString("adjusts_tracker_user", comment: "")
        static let logIn: String = NSLocalizedString("adjusts_tracker_log_in", comment: "")
        static let logOut: String = NSLocalizedString("adjusts_tracker_log_out", comment: "")
        static let icloudHeader: String = NSLocalizedString("adjusts_icloud_header", comment: "")
        static let icloudSync: String = NSLocalizedString("adjusts_icloud_sync", comment: "")
        static var icloudFooter: AttributedString {
            let string = NSLocalizedString("adjusts_icloud_footer", comment: "")
            do {
                return try AttributedString(markdown: string)
            } catch { print(error.localizedDescription)}
            return AttributedString(string)
        }
        static let securityHeader: String = NSLocalizedString("adjusts_security_header", comment: "")
        static let securityFooter: String = NSLocalizedString("adjusts_security_footer", comment: "")
        static let securityBiometry: String = NSLocalizedString("adjusts_security_biometry", comment: "")
        static let securityLevel: String = NSLocalizedString("adjusts_security_level", comment: "")
        static let securityLibrary: String = NSLocalizedString("adjusts_security_library", comment: "")
        static let libraryFooter: String = NSLocalizedString("adjusts_security_library_footer", comment: "")
        static let appFooter: String = NSLocalizedString("adjusts_security_app_footer", comment: "")
        static let notificationHeader: String = NSLocalizedString("adjusts_notification_header", comment: "")
        static let notificationFooter: String = NSLocalizedString("adjusts_notification_footer", comment: "")
        static let notificationUpdate: String = NSLocalizedString("adjusts_notification_updated_mangas", comment: "")
        static let ageRatingHeader: String = NSLocalizedString("adjusts_age_rating_header", comment: "")
        static var ageRatingFooter: AttributedString {
            let string = NSLocalizedString("adjusts_age_rating_footer", comment: "")
            do {
                return try AttributedString(markdown: string)
            } catch { print(error.localizedDescription)}
            return AttributedString(string)
        }
    }
}
