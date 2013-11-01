/****************************************************************************
 * This file is part of Hawaii Shell.
 *
 * Copyright (C) 2012-2013 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * Author(s):
 *    Pier Luigi Fiorini
 *
 * $BEGIN_LICENSE:LGPL2.1+$
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 2.1 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * $END_LICENSE$
 ***************************************************************************/

import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import FluidUi 0.2 as FluidUi

Item {
    id: root

    property alias label: labelItem.text
    property alias iconName: iconItem.iconName
    property int orientation

    ColumnLayout {
        anchors {
            fill: parent
            margins: 6
        }

        FluidUi.Icon {
            id: iconItem
            width: 48
            height: 48
            color: "white"
            visible: iconName !== ""

            Layout.alignment: orientation == ListView.Horizontal ? Qt.AlignLeft : Qt.AlignCenter
        }

        Label {
            id: labelItem
            color: "white"
            visible: text != ""

            Layout.alignment: orientation == ListView.Horizontal ? Qt.AlignLeft : Qt.AlignCenter
        }
    }
}
