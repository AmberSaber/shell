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

import QtQuick 2.0
import QtQuick.Window 2.0

Item {
    id: container

    property variant child: null
    property variant chrome: null

    // This effect is used just to invert Y when necessary
    ContrastEffect {
        id: effect
        source: child
        anchors.fill: child
        opacity: 1.0
        blend: 0.0
        z: 1
    }

    // Change container geometry and z-index according to child
    /*
    Connections {
        target: child
        onXChanged: container.pos.x = x
        onYChanged: container.pos.y = y
        onZChanged: container.z = z
        onWidthChanged: container.width = width
        onHeightChanged: container.height = height
    }
    */
}
