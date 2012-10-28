/****************************************************************************
 * This file is part of Fluid.
 *
 * Copyright (c) 2012 Pier Luigi Fiorini
 * Copyright (c) 2011 Marco Martin
 *
 * Author(s):
 *    Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *    Marco Martin <mart@kde.org>
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

// ToolBarLayout is a container for items on a toolbar that automatically
// implements an appropriate layout for its children.

/**Documented API
Inherits:
        Row

Imports:
        QtQuick 2.0

Description:
        ToolBarLayout is a container for items on a toolbar that automatically implements an appropriate layout for its children.
**/

import QtQuick 2.0

Row {
    id: root

    visible: false

    Item {
        id: spacer
        width: 10
        height: 10
    }

    QtObject {
        id: internal
        property bool layouting: false
        function layoutChildren()
        {
            var numChildren = root.children.length
            if (layouting || parent == null ||
                root.width == 0 || numChildren < 2) {
                return
            }

            layouting = true
            spacer.parent = null

            spacer.width = root.parent.width - root.childrenRect.width -10

            var last = root.children[numChildren-2]
            last.parent = null
            spacer.parent = root
            last.parent = root
            layouting = false
        }
    }

    Component.onCompleted: internal.layoutChildren()
    onChildrenChanged: internal.layoutChildren()
    onWidthChanged: internal.layoutChildren()
}
