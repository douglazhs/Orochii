//
//  Orochii_WidgetLiveActivity.swift
//  Orochii Widget
//
//  Created by Douglas Henrique de Souza Pereira on 19/07/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct Orochii_WidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct Orochii_WidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: Orochii_WidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension Orochii_WidgetAttributes {
    fileprivate static var preview: Orochii_WidgetAttributes {
        Orochii_WidgetAttributes(name: "World")
    }
}

extension Orochii_WidgetAttributes.ContentState {
    fileprivate static var smiley: Orochii_WidgetAttributes.ContentState {
        Orochii_WidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: Orochii_WidgetAttributes.ContentState {
         Orochii_WidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: Orochii_WidgetAttributes.preview) {
   Orochii_WidgetLiveActivity()
} contentStates: {
    Orochii_WidgetAttributes.ContentState.smiley
    Orochii_WidgetAttributes.ContentState.starEyes
}
