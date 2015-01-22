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
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1
import Hawaii.Components 1.0 as Components
import Hawaii.Themes 1.0 as Themes
import org.kde.kquickcontrolsaddons 2.0 as KQuickControls
import org.hawaii.launcher 0.1 as Launcher
import "components" as CustomComponents

Item {
    property real iconSize: Themes.Units.iconSizes.large
    readonly property real itemSize: iconSize + (iconSize * 0.25)
    readonly property real itemPadding: Themes.Units.smallSpacing * 2
    property alias orientation: listView.orientation

    id: launcher

    Component {
        id: iconDelegate

        Item {
            property int badgeCount: 1

            id: root
            width: itemSize
            height: width

            Behavior on width {
                NumberAnimation {
                    easing.type: Easing.Linear
                    duration: Themes.Units.shortDuration
                }
            }

            Behavior on height {
                NumberAnimation {
                    easing.type: Easing.Linear
                    duration: Themes.Units.shortDuration
                }
            }

            Components.Icon {
                anchors.centerIn: parent
                iconName: model.iconName
                width: iconSize
                height: width
            }

            Rectangle {
                id: badge
                anchors {
                    top: parent.top
                    right: parent.right
                    topMargin: -(Themes.Units.smallSpacing * 0.35)
                    rightMargin: -(Themes.Units.largeSpacing * 0.35)
                }
                width: Themes.Units.iconSizes.smallMedium
                height: width
                radius: width * 0.5
                color: "orangered"
                opacity: model.hasCount > 0 ? 1.0 : 0.0

                Behavior on opacity {
                    NumberAnimation {
                        easing.type: Easing.OutQuad
                        duration: Themes.Units.shortDuration
                    }
                }

                Label {
                    anchors.centerIn: parent
                    font.pixelSize: parent.width - Themes.Units.smallSpacing
                    color: "white"
                    text: model.count
                }
            }

            CustomComponents.Tooltip {
                id: tooltip
                text: model.name
                visualParent: root
            }

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                hoverEnabled: true
                onPositionChanged: tooltip.open()
                onExited: tooltip.close()
            }
        }
    }

    ListView {
        id: listView
        anchors.centerIn: parent
        orientation: ListView.Horizontal
        spacing: Themes.Units.smallSpacing
        interactive: false
        add: Transition {
            NumberAnimation { properties: "scale"; from: 0.1; to: 1.0; duration: Themes.Units.shortDuration }
        }
        populate: Transition {
            NumberAnimation { properties: "scale"; from: 0.1; to: 1.0; duration: Themes.Units.longDuration }
        }
        model: Launcher.LauncherModel {
            id: launcherModel
            applicationManager: compositor.applicationManager
        }
        delegate: iconDelegate
        width: calcWidth()
        height: calcHeight()

        function calcWidth() {
            if (orientation == ListView.Horizontal)
                return contentWidth;
            return itemSize + (itemPadding / 2);
        }

        function calcHeight() {
            if (orientation == ListView.Vertical)
                return contentHeight;
            return itemSize + (itemPadding / 2);
        }
    }
}
