/****************************************************************************
 * This file is part of Hawaii.
 *
 * Copyright (C) 2012-2015 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * Author(s):
 *    Pier Luigi Fiorini
 *
 * $BEGIN_LICENSE:GPL2+$
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * $END_LICENSE$
 ***************************************************************************/

import QtQuick 2.0
import Hawaii.Components 1.0 as Components
import Hawaii.Themes 1.0 as Themes
import org.hawaiios.launcher 0.1 as CppLauncher

Item {
    property real iconSize
    property real itemSize
    readonly property real itemPadding: Themes.Units.smallSpacing * 2
    property alias orientation: listView.orientation
    property alias viewWidth: listView.width
    property alias viewHeight: listView.height
    readonly property alias currentItem: listView.currentItem

    id: launcher

    ListView {
        id: listView
        anchors.centerIn: parent
        spacing: Themes.Units.smallSpacing
        interactive: false
        add: Transition {
            NumberAnimation { properties: "scale"; from: 0.1; to: 1.0; duration: Themes.Units.shortDuration }
        }
        populate: Transition {
            NumberAnimation { properties: "scale"; from: 0.1; to: 1.0; duration: Themes.Units.longDuration }
        }
        model: CppLauncher.LauncherModel {
            id: launcherModel
            applicationManager: hawaiiCompositor.applicationManager
        }
        delegate: LauncherDelegate {}
    }
}
