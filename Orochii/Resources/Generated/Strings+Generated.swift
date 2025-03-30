// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L {
  /// Order
  internal static let order = L.tr("Localizable", "order", fallback: "Order")
  internal enum Account {
    /// ------------------------------------------------------------
    internal static let noActivities = L.tr("Localizable", "account.no_activities", fallback: "You have no activities :(")
    /// You have no favorites :(
    internal static let noFavorites = L.tr("Localizable", "account.no_favorites", fallback: "You have no favorites :(")
    internal enum Character {
      /// AGE
      internal static let age = L.tr("Localizable", "account.character.age", fallback: "AGE")
      /// GENDER
      internal static let gender = L.tr("Localizable", "account.character.gender", fallback: "GENDER")
      /// MANGA APPEARENCES
      internal static let mangaAppearences = L.tr("Localizable", "account.character.manga_appearences", fallback: "MANGA APPEARENCES")
      /// MEMBER FAVORITES
      internal static let memberFavorites = L.tr("Localizable", "account.character.member_favorites", fallback: "MEMBER FAVORITES")
      /// SUMMARY
      internal static let summary = L.tr("Localizable", "account.character.summary", fallback: "SUMMARY")
      internal enum Title {
        /// ALTERNATIVE TITLES
        internal static let alternative = L.tr("Localizable", "account.character.title.alternative", fallback: "ALTERNATIVE TITLES")
        /// NATIVE
        internal static let native = L.tr("Localizable", "account.character.title.native", fallback: "NATIVE")
        /// SPOILER TITLES
        internal static let spoiler = L.tr("Localizable", "account.character.title.spoiler", fallback: "SPOILER TITLES")
        /// USER PREFERRED
        internal static let userPreferred = L.tr("Localizable", "account.character.title.user_preferred", fallback: "USER PREFERRED")
      }
    }
    internal enum Feed {
      /// Following Feed
      internal static let following = L.tr("Localizable", "account.feed.following", fallback: "Following Feed")
      /// Mine
      internal static let mine = L.tr("Localizable", "account.feed.mine", fallback: "Mine")
    }
    internal enum Section {
      /// Chapters Read Per Staff
      internal static let chaptersPerStaff = L.tr("Localizable", "account.section.chapters_per_staff", fallback: "Chapters Read Per Staff")
      /// Chapters Read Per Year
      internal static let chaptersPerYear = L.tr("Localizable", "account.section.chapters_per_year", fallback: "Chapters Read Per Year")
      /// Chapters Read
      internal static let chaptersRead = L.tr("Localizable", "account.section.chapters_read", fallback: "Chapters Read")
      /// Manga Per Country
      internal static let country = L.tr("Localizable", "account.section.country", fallback: "Manga Per Country")
      /// Genres Distribution
      internal static let genres = L.tr("Localizable", "account.section.genres", fallback: "Genres Distribution")
      /// Mangas Read Per Year
      internal static let mangasPerYear = L.tr("Localizable", "account.section.mangas_per_year", fallback: "Mangas Read Per Year")
      /// Mean Score
      internal static let meanScore = L.tr("Localizable", "account.section.mean_score", fallback: "Mean Score")
      /// Standard Deviation
      internal static let standardDeviation = L.tr("Localizable", "account.section.standard_deviation", fallback: "Standard Deviation")
      /// Statuses
      internal static let statuses = L.tr("Localizable", "account.section.statuses", fallback: "Statuses")
      /// Tags Distribution
      internal static let tags = L.tr("Localizable", "account.section.tags", fallback: "Tags Distribution")
      /// Total Mangas
      internal static let totalMangas = L.tr("Localizable", "account.section.total_mangas", fallback: "Total Mangas")
      /// Volumes Read
      internal static let volumesRead = L.tr("Localizable", "account.section.volumes_read", fallback: "Volumes Read")
    }
    internal enum Tab {
      /// Activity
      internal static let activity = L.tr("Localizable", "account.tab.activity", fallback: "Activity")
      /// Favorites
      internal static let favorites = L.tr("Localizable", "account.tab.favorites", fallback: "Favorites")
      /// Stats
      internal static let stats = L.tr("Localizable", "account.tab.stats", fallback: "Stats")
      internal enum Favorites {
        /// Characters
        internal static let characters = L.tr("Localizable", "account.tab.favorites.characters", fallback: "Characters")
        /// Mangas
        internal static let mangas = L.tr("Localizable", "account.tab.favorites.mangas", fallback: "Mangas")
        /// Authors
        internal static let staff = L.tr("Localizable", "account.tab.favorites.staff", fallback: "Authors")
      }
    }
  }
  internal enum Action {
    /// Add to Library
    internal static let addToLibrary = L.tr("Localizable", "action.add_to_library", fallback: "Add to Library")
    /// Download
    internal static let download = L.tr("Localizable", "action.download", fallback: "Download")
    /// Mark as Read
    internal static let markAsRead = L.tr("Localizable", "action.mark_as_read", fallback: "Mark as Read")
    /// Mark as Unread
    internal static let markAsUnread = L.tr("Localizable", "action.mark_as_unread", fallback: "Mark as Unread")
    /// Mark Previous
    internal static let markPrevious = L.tr("Localizable", "action.mark_previous", fallback: "Mark Previous")
    /// as Read
    internal static let read = L.tr("Localizable", "action.read", fallback: "as Read")
    /// Remove from Library
    internal static let removeFromLibrary = L.tr("Localizable", "action.remove_from_library", fallback: "Remove from Library")
    /// Save Page
    internal static let savePage = L.tr("Localizable", "action.save_page", fallback: "Save Page")
    /// as Unread
    internal static let unread = L.tr("Localizable", "action.unread", fallback: "as Unread")
  }
  internal enum Adjusts {
    /// ------------------------------------------------------------
    internal static let title = L.tr("Localizable", "adjusts.title", fallback: "Adjusts")
    internal enum About {
      /// Build
      internal static let build = L.tr("Localizable", "adjusts.about.build", fallback: "Build")
      /// Some informations about the App
      internal static let footer = L.tr("Localizable", "adjusts.about.footer", fallback: "Some informations about the App")
      /// About
      internal static let header = L.tr("Localizable", "adjusts.about.header", fallback: "About")
      /// Version
      internal static let version = L.tr("Localizable", "adjusts.about.version", fallback: "Version")
    }
    internal enum AgeRating {
      /// **Not safe for work**: material that should only be looked at in private because it contains some things that could be _offensive_
      internal static let footer = L.tr("Localizable", "adjusts.age_rating.footer", fallback: "**Not safe for work**: material that should only be looked at in private because it contains some things that could be _offensive_")
      /// Age Rating
      internal static let header = L.tr("Localizable", "adjusts.age_rating.header", fallback: "Age Rating")
    }
    internal enum Icloud {
      /// Your manga library will be saved in the **Cloud** to be accessed from other devices
      internal static let footer = L.tr("Localizable", "adjusts.icloud.footer", fallback: "Your manga library will be saved in the **Cloud** to be accessed from other devices")
      /// iCloud
      internal static let header = L.tr("Localizable", "adjusts.icloud.header", fallback: "iCloud")
      /// Sync
      internal static let sync = L.tr("Localizable", "adjusts.icloud.sync", fallback: "Sync")
    }
    internal enum Notification {
      /// You will be notified every time a new manga chapter is released
      internal static let footer = L.tr("Localizable", "adjusts.notification.footer", fallback: "You will be notified every time a new manga chapter is released")
      /// Notification
      internal static let header = L.tr("Localizable", "adjusts.notification.header", fallback: "Notification")
      /// Chapter Update
      internal static let updatedMangas = L.tr("Localizable", "adjusts.notification.updated_mangas", fallback: "Chapter Update")
    }
    internal enum Security {
      /// Lock library
      internal static let biometry = L.tr("Localizable", "adjusts.security.biometry", fallback: "Lock library")
      /// Make your library and your mangas more secure
      internal static let footer = L.tr("Localizable", "adjusts.security.footer", fallback: "Make your library and your mangas more secure")
      /// Security
      internal static let header = L.tr("Localizable", "adjusts.security.header", fallback: "Security")
      /// Library
      internal static let library = L.tr("Localizable", "adjusts.security.library", fallback: "Library")
    }
    internal enum Tracker {
      /// You can connect your <b>AniList</b> account and track your mangas
      internal static let footer = L.tr("Localizable", "adjusts.tracker.footer", fallback: "You can connect your <b>AniList</b> account and track your mangas")
      /// Tracker
      internal static let header = L.tr("Localizable", "adjusts.tracker.header", fallback: "Tracker")
      /// LogIn
      internal static let logIn = L.tr("Localizable", "adjusts.tracker.log_in", fallback: "LogIn")
      /// Log Out
      internal static let logOut = L.tr("Localizable", "adjusts.tracker.log_out", fallback: "Log Out")
      /// %@ Mangas
      internal static func mangasCount(_ p1: Any) -> String {
        return L.tr("Localizable", "adjusts.tracker.mangas_count", String(describing: p1), fallback: "%@ Mangas")
      }
      /// User
      internal static let user = L.tr("Localizable", "adjusts.tracker.user", fallback: "User")
    }
  }
  internal enum Anilist {
    /// ------------------------------------------------------------
    internal static let logout = L.tr("Localizable", "anilist.logout", fallback: "Are you sure you want to Log Out of your AniList account?")
  }
  internal enum Common {
    /// Add
    internal static let add = L.tr("Localizable", "common.add", fallback: "Add")
    /// All
    internal static let all = L.tr("Localizable", "common.all", fallback: "All")
    /// Attention
    internal static let attention = L.tr("Localizable", "common.attention", fallback: "Attention")
    /// Cancel
    internal static let cancel = L.tr("Localizable", "common.cancel", fallback: "Cancel")
    /// Done
    internal static let done = L.tr("Localizable", "common.done", fallback: "Done")
    /// Error
    internal static let error = L.tr("Localizable", "common.error", fallback: "Error")
    /// Mark
    internal static let mark = L.tr("Localizable", "common.mark", fallback: "Mark")
    /// None
    internal static let `none` = L.tr("Localizable", "common.none", fallback: "None")
    /// NSFW
    internal static let nsfw = L.tr("Localizable", "common.nsfw", fallback: "NSFW")
    /// of
    internal static let of = L.tr("Localizable", "common.of", fallback: "of")
    /// OK
    internal static let ok = L.tr("Localizable", "common.ok", fallback: "OK")
    /// Remove
    internal static let remove = L.tr("Localizable", "common.remove", fallback: "Remove")
    /// Save
    internal static let save = L.tr("Localizable", "common.save", fallback: "Save")
    /// Search
    internal static let search = L.tr("Localizable", "common.search", fallback: "Search")
    /// Unknown
    internal static let unknown = L.tr("Localizable", "common.unknown", fallback: "Unknown")
  }
  internal enum Discovery {
    /// Award Winning
    internal static let awardWinning = L.tr("Localizable", "discovery.award_winning", fallback: "Award Winning")
    /// Most Relevants
    internal static let mostRelevants = L.tr("Localizable", "discovery.most_relevants", fallback: "Most Relevants")
    /// Seinen Public
    internal static let seinen = L.tr("Localizable", "discovery.seinen", fallback: "Seinen Public")
    /// Shounen Public
    internal static let shounen = L.tr("Localizable", "discovery.shounen", fallback: "Shounen Public")
    /// %@
    internal static func thisYear(_ p1: Any) -> String {
      return L.tr("Localizable", "discovery.this_year", String(describing: p1), fallback: "%@")
    }
    /// ------------------------------------------------------------
    internal static let title = L.tr("Localizable", "discovery.title", fallback: "Discover")
    /// Webcomics Full Colored
    internal static let webcomics = L.tr("Localizable", "discovery.webcomics", fallback: "Webcomics Full Colored")
    internal enum Cell {
      /// AUTHOR
      internal static let author = L.tr("Localizable", "discovery.cell.author", fallback: "AUTHOR")
      /// UPDATED
      internal static let lastUpdated = L.tr("Localizable", "discovery.cell.last_updated", fallback: "UPDATED")
      /// YEAR
      internal static let year = L.tr("Localizable", "discovery.cell.year", fallback: "YEAR")
    }
    internal enum Search {
      /// No results found for: *%@*
      internal static func noResults(_ p1: Any) -> String {
        return L.tr("Localizable", "discovery.search.no_results", String(describing: p1), fallback: "No results found for: *%@*")
      }
      /// Manga title
      internal static let placeholder = L.tr("Localizable", "discovery.search.placeholder", fallback: "Manga title")
    }
    internal enum Status {
      /// Completed
      internal static let completed = L.tr("Localizable", "discovery.status.completed", fallback: "Completed")
      /// Hiatus
      internal static let hiatus = L.tr("Localizable", "discovery.status.hiatus", fallback: "Hiatus")
      /// Ongoing
      internal static let ongoing = L.tr("Localizable", "discovery.status.ongoing", fallback: "Ongoing")
    }
  }
  internal enum Error {
    /// ------------------------------------------------------------
    internal static let anilistLogin = L.tr("Localizable", "error.anilist_login", fallback: "Error when trying to login on your AniList account.")
    /// Empty URL.
    internal static let emptyUrl = L.tr("Localizable", "error.empty_url", fallback: "Empty URL.")
    /// Invalid URL.
    internal static let invalidUrl = L.tr("Localizable", "error.invalid_url", fallback: "Invalid URL.")
    /// Object is nil.
    internal static let nilObject = L.tr("Localizable", "error.nil_object", fallback: "Object is nil.")
    /// Error when trying save your credentials on Keychain.
    internal static let saveKeychain = L.tr("Localizable", "error.save_keychain", fallback: "Error when trying save your credentials on Keychain.")
  }
  internal enum Filter {
    /// Filter
    internal static let action = L.tr("Localizable", "filter.action", fallback: "Filter")
    /// Here you have some preferences to change the order of your mangas
    internal static let byFooter = L.tr("Localizable", "filter.by_footer", fallback: "Here you have some preferences to change the order of your mangas")
    /// Filter By
    internal static let byHeader = L.tr("Localizable", "filter.by_header", fallback: "Filter By")
    /// Downloaded
    internal static let downloaded = L.tr("Localizable", "filter.downloaded", fallback: "Downloaded")
    /// Language
    internal static let language = L.tr("Localizable", "filter.language", fallback: "Language")
    /// Last Updated
    internal static let lastUpdated = L.tr("Localizable", "filter.last_updated", fallback: "Last Updated")
    /// Filter your mangas by their informations
    internal static let mangaInfoFooter = L.tr("Localizable", "filter.manga_info_footer", fallback: "Filter your mangas by their informations")
    /// Manga Information
    internal static let mangaInfoHeader = L.tr("Localizable", "filter.manga_info_header", fallback: "Manga Information")
    /// Name (A-Z)
    internal static let name = L.tr("Localizable", "filter.name", fallback: "Name (A-Z)")
    /// None
    internal static let `none` = L.tr("Localizable", "filter.none", fallback: "None")
    /// Public
    internal static let `public` = L.tr("Localizable", "filter.public", fallback: "Public")
    /// Release Year
    internal static let releaseYear = L.tr("Localizable", "filter.release_year", fallback: "Release Year")
    /// Status
    internal static let status = L.tr("Localizable", "filter.status", fallback: "Status")
    /// ------------------------------------------------------------
    internal static let title = L.tr("Localizable", "filter.title", fallback: "Filters")
    /// Year
    internal static let year = L.tr("Localizable", "filter.year", fallback: "Year")
  }
  internal enum Language {
    /// English (US)
    internal static let english = L.tr("Localizable", "language.english", fallback: "English (US)")
    /// Localizable.strings
    ///   Orochii
    /// 
    ///   Created by Douglas Henrique de Souza Pereira on 19/11/22.
    internal static let portuguese = L.tr("Localizable", "language.portuguese", fallback: "Portuguese (Brazil)")
  }
  internal enum Library {
    /// ------------------------------------------------------------
    internal static let title = L.tr("Localizable", "library.title", fallback: "Library")
    internal enum Auth {
      /// Your library is locked :(
      ///  Unlock It to see your mangas :)
      internal static let errorMessage = L.tr("Localizable", "library.auth.error_message", fallback: "Your library is locked :(\n Unlock It to see your mangas :)")
      /// You locked your library.
      ///  Click on unlock button to see your mangas :)
      internal static let message = L.tr("Localizable", "library.auth.message", fallback: "You locked your library.\n Click on unlock button to see your mangas :)")
      /// TRY AGAIN
      internal static let retry = L.tr("Localizable", "library.auth.retry", fallback: "TRY AGAIN")
      /// UNLOCK
      internal static let unlock = L.tr("Localizable", "library.auth.unlock", fallback: "UNLOCK")
    }
    internal enum Search {
      /// Search on your list
      internal static let placeholder = L.tr("Localizable", "library.search.placeholder", fallback: "Search on your list")
    }
  }
  internal enum Manga {
    /// Add to Library
    internal static let addToLibrary = L.tr("Localizable", "manga.add_to_library", fallback: "Add to Library")
    /// ------------------------------------------------------------
    internal static let author = L.tr("Localizable", "manga.author", fallback: "Author")
    /// %@ Chapter(s)
    internal static func chaptersCount(_ p1: Any) -> String {
      return L.tr("Localizable", "manga.chapters_count", String(describing: p1), fallback: "%@ Chapter(s)")
    }
    /// Chapters Of
    internal static let chaptersOf = L.tr("Localizable", "manga.chapters_of", fallback: "Chapters Of")
    /// Country
    internal static let country = L.tr("Localizable", "manga.country", fallback: "Country")
    /// Public
    internal static let demographic = L.tr("Localizable", "manga.demographic", fallback: "Public")
    /// Description
    internal static let descriptionHeader = L.tr("Localizable", "manga.description_header", fallback: "Description")
    /// Genres
    internal static let genres = L.tr("Localizable", "manga.genres", fallback: "Genres")
    /// No chapters found :(
    internal static let noChapters = L.tr("Localizable", "manga.no_chapters", fallback: "No chapters found :(")
    /// Select Chapters
    internal static let selectChapters = L.tr("Localizable", "manga.select_chapters", fallback: "Select Chapters")
    /// Selected Chapters
    internal static let selectedChapters = L.tr("Localizable", "manga.selected_chapters", fallback: "Selected Chapters")
    /// Start Reading
    internal static let startReading = L.tr("Localizable", "manga.start_reading", fallback: "Start Reading")
    /// State
    internal static let state = L.tr("Localizable", "manga.state", fallback: "State")
    /// Status
    internal static let status = L.tr("Localizable", "manga.status", fallback: "Status")
    /// Updated
    internal static let updated = L.tr("Localizable", "manga.updated", fallback: "Updated")
    /// Year
    internal static let year = L.tr("Localizable", "manga.year", fallback: "Year")
    internal enum Action {
      /// AniList
      internal static let anilist = L.tr("Localizable", "manga.action.anilist", fallback: "AniList")
      /// Library
      internal static let library = L.tr("Localizable", "manga.action.library", fallback: "Library")
      /// Remove All Downloads
      internal static let removeDownloads = L.tr("Localizable", "manga.action.remove_downloads", fallback: "Remove All Downloads")
      /// View on MangaDex.co
      internal static let viewOnMdex = L.tr("Localizable", "manga.action.view_on_mdex", fallback: "View on MangaDex.co")
    }
    internal enum Covers {
      /// No other covers available for *%@*
      internal static func notAvailable(_ p1: Any) -> String {
        return L.tr("Localizable", "manga.covers.not_available", String(describing: p1), fallback: "No other covers available for *%@*")
      }
      /// All Available Covers
      internal static let title = L.tr("Localizable", "manga.covers.title", fallback: "All Available Covers")
      internal enum Filter {
        /// Language Selection
        internal static let languages = L.tr("Localizable", "manga.covers.filter.languages", fallback: "Language Selection")
        /// Volume
        internal static let volume = L.tr("Localizable", "manga.covers.filter.volume", fallback: "Volume")
      }
    }
    internal enum Reader {
      /// %@ pages left
      internal static func pagesLeft(_ p1: Any) -> String {
        return L.tr("Localizable", "manga.reader.pages_left", String(describing: p1), fallback: "%@ pages left")
      }
    }
    internal enum Status {
      /// Completed
      internal static let completed = L.tr("Localizable", "manga.status.completed", fallback: "Completed")
      /// Dropped
      internal static let dropped = L.tr("Localizable", "manga.status.dropped", fallback: "Dropped")
      /// None
      internal static let `none` = L.tr("Localizable", "manga.status.none", fallback: "None")
      /// Paused
      internal static let paused = L.tr("Localizable", "manga.status.paused", fallback: "Paused")
      /// Planning
      internal static let planning = L.tr("Localizable", "manga.status.planning", fallback: "Planning")
      /// Reading
      internal static let reading = L.tr("Localizable", "manga.status.reading", fallback: "Reading")
      /// Rereading
      internal static let rereading = L.tr("Localizable", "manga.status.rereading", fallback: "Rereading")
    }
    internal enum SubAction {
      /// Moved
      internal static let moved = L.tr("Localizable", "manga.sub_action.moved", fallback: "Moved")
      /// Removed
      internal static let removed = L.tr("Localizable", "manga.sub_action.removed", fallback: "Removed")
    }
  }
  internal enum MangaSource {
    /// ------------------------------------------------------------
    internal static let title = L.tr("Localizable", "manga_source.title", fallback: "Source")
    internal enum Anilist {
      internal enum Cover {
        /// Extra Large
        internal static let extraLarge = L.tr("Localizable", "manga_source.anilist.cover.extraLarge", fallback: "Extra Large")
        /// Large
        internal static let large = L.tr("Localizable", "manga_source.anilist.cover.large", fallback: "Large")
        /// Medium
        internal static let medium = L.tr("Localizable", "manga_source.anilist.cover.medium", fallback: "Medium")
      }
    }
    internal enum Cover {
      /// Cover quality of the available **sources** that **Orochii** App uses
      internal static let footer = L.tr("Localizable", "manga_source.cover.footer", fallback: "Cover quality of the available **sources** that **Orochii** App uses")
      /// Manga Source Covers
      internal static let header = L.tr("Localizable", "manga_source.cover.header", fallback: "Manga Source Covers")
    }
    internal enum Language {
      /// That will be used to search your mangas
      internal static let footer = L.tr("Localizable", "manga_source.language.footer", fallback: "That will be used to search your mangas")
      /// Preferred Languages
      internal static let header = L.tr("Localizable", "manga_source.language.header", fallback: "Preferred Languages")
    }
    internal enum Mdex {
      internal enum Cover {
        /// Low
        internal static let low = L.tr("Localizable", "manga_source.mdex.cover.low", fallback: "Low")
        /// Medium
        internal static let medium = L.tr("Localizable", "manga_source.mdex.cover.medium", fallback: "Medium")
        /// Original
        internal static let original = L.tr("Localizable", "manga_source.mdex.cover.original", fallback: "Original")
      }
    }
    internal enum Site {
      /// You will be redirected to _MangaDex_ website
      internal static let footer = L.tr("Localizable", "manga_source.site.footer", fallback: "You will be redirected to _MangaDex_ website")
      /// Main Source
      internal static let header = L.tr("Localizable", "manga_source.site.header", fallback: "Main Source")
    }
  }
  internal enum Order {
    /// Ascending
    internal static let ascending = L.tr("Localizable", "order.ascending", fallback: "Ascending")
    /// Descending
    internal static let descending = L.tr("Localizable", "order.descending", fallback: "Descending")
  }
  internal enum OrderBy {
    /// Order your mangas ascending or descending
    internal static let footer = L.tr("Localizable", "orderBy.footer", fallback: "Order your mangas ascending or descending")
    /// Order By
    internal static let header = L.tr("Localizable", "orderBy.header", fallback: "Order By")
  }
  internal enum Reader {
    /// Layout
    internal static let layout = L.tr("Localizable", "reader.layout", fallback: "Layout")
    /// Quality
    internal static let manga = L.tr("Localizable", "reader.manga", fallback: "Quality")
    /// Mode
    internal static let mode = L.tr("Localizable", "reader.mode", fallback: "Mode")
    /// ------------------------------------------------------------
    internal static let title = L.tr("Localizable", "reader.title", fallback: "Reader Preferences")
    internal enum Cover {
      /// Data Saver
      internal static let dataSaver = L.tr("Localizable", "reader.cover.data_saver", fallback: "Data Saver")
      /// Original
      internal static let original = L.tr("Localizable", "reader.cover.original", fallback: "Original")
    }
    internal enum Layout {
      /// Automatic
      internal static let automatic = L.tr("Localizable", "reader.layout.automatic", fallback: "Automatic")
      /// Double Pages
      internal static let doublePage = L.tr("Localizable", "reader.layout.double_page", fallback: "Double Pages")
      /// Choose a page layout of your preference
      internal static let footer = L.tr("Localizable", "reader.layout.footer", fallback: "Choose a page layout of your preference")
      /// Page Layout
      internal static let header = L.tr("Localizable", "reader.layout.header", fallback: "Page Layout")
      /// Single Page
      internal static let singlePage = L.tr("Localizable", "reader.layout.single_page", fallback: "Single Page")
    }
    internal enum Manga {
      /// Choose the quality of your preference
      internal static let footer = L.tr("Localizable", "reader.manga.footer", fallback: "Choose the quality of your preference")
      /// Page quality
      internal static let header = L.tr("Localizable", "reader.manga.header", fallback: "Page quality")
    }
    internal enum Mode {
      /// Default
      internal static let `default` = L.tr("Localizable", "reader.mode.default", fallback: "Default")
      /// Choose the better reading mode for you
      internal static let footer = L.tr("Localizable", "reader.mode.footer", fallback: "Choose the better reading mode for you")
      /// Reading mode
      internal static let header = L.tr("Localizable", "reader.mode.header", fallback: "Reading mode")
      /// Left to Right
      internal static let leftToRight = L.tr("Localizable", "reader.mode.left_to_right", fallback: "Left to Right")
      /// Right to Left
      internal static let rightToLeft = L.tr("Localizable", "reader.mode.right_to_left", fallback: "Right to Left")
      /// Webtoon
      internal static let webtoon = L.tr("Localizable", "reader.mode.webtoon", fallback: "Webtoon")
    }
  }
  internal enum Tracker {
    /// Search
    internal static let search = L.tr("Localizable", "tracker.search", fallback: "Search")
    internal enum Action {
      /// See on AniList
      internal static let seeOnAnilist = L.tr("Localizable", "tracker.action.see_on_anilist", fallback: "See on AniList")
      /// START TRACKING
      internal static let startTracking = L.tr("Localizable", "tracker.action.start_tracking", fallback: "START TRACKING")
      /// Stop
      internal static let stop = L.tr("Localizable", "tracker.action.stop", fallback: "Stop")
      /// Stop Tracking
      internal static let stopTracking = L.tr("Localizable", "tracker.action.stop_tracking", fallback: "Stop Tracking")
      /// TRACK
      internal static let track = L.tr("Localizable", "tracker.action.track", fallback: "TRACK")
      /// TRACK LOCALLY
      internal static let trackLocally = L.tr("Localizable", "tracker.action.track_locally", fallback: "TRACK LOCALLY")
    }
    internal enum Info {
      /// CH. %@
      internal static func chapter(_ p1: Any) -> String {
        return L.tr("Localizable", "tracker.info.chapter", String(describing: p1), fallback: "CH. %@")
      }
      /// ENDED
      internal static let ended = L.tr("Localizable", "tracker.info.ended", fallback: "ENDED")
      /// PROGRESS
      internal static let progress = L.tr("Localizable", "tracker.info.progress", fallback: "PROGRESS")
      /// SCORE
      internal static let score = L.tr("Localizable", "tracker.info.score", fallback: "SCORE")
      /// STARTED
      internal static let started = L.tr("Localizable", "tracker.info.started", fallback: "STARTED")
      /// STATUS
      internal static let status = L.tr("Localizable", "tracker.info.status", fallback: "STATUS")
      /// UPDATED
      internal static let updated = L.tr("Localizable", "tracker.info.updated", fallback: "UPDATED")
    }
    internal enum Manga {
      /// AVERAGE SCORE
      internal static let averageScore = L.tr("Localizable", "tracker.manga.average_score", fallback: "AVERAGE SCORE")
      /// COUNTRY
      internal static let country = L.tr("Localizable", "tracker.manga.country", fallback: "COUNTRY")
      /// FORMAT
      internal static let format = L.tr("Localizable", "tracker.manga.format", fallback: "FORMAT")
      /// PUPULAR RANK
      internal static let popularRank = L.tr("Localizable", "tracker.manga.popular_rank", fallback: "PUPULAR RANK")
      /// RATED RANK
      internal static let ratedRank = L.tr("Localizable", "tracker.manga.rated_rank", fallback: "RATED RANK")
      /// SOURCE
      internal static let source = L.tr("Localizable", "tracker.manga.source", fallback: "SOURCE")
      /// STATUS
      internal static let status = L.tr("Localizable", "tracker.manga.status", fallback: "STATUS")
      /// YEAR
      internal static let year = L.tr("Localizable", "tracker.manga.year", fallback: "YEAR")
    }
    internal enum Search {
      /// No results found on **AniList**
      internal static let noResults = L.tr("Localizable", "tracker.search.no_results", fallback: "No results found on **AniList**")
    }
    internal enum Stop {
      internal enum Confirmation {
        /// You will not lose your AniList progress, It just remove the tracking information locally.
        internal static let message = L.tr("Localizable", "tracker.stop.confirmation.message", fallback: "You will not lose your AniList progress, It just remove the tracking information locally.")
        /// Stop Tracking Locally
        internal static let title = L.tr("Localizable", "tracker.stop.confirmation.title", fallback: "Stop Tracking Locally")
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
