/****************************************************************************
 * This file is part of Liri.
 *
 * Copyright (C) 2017 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * $BEGIN_LICENSE:GPL3+$
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
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

Grid {
    columns: 3
    spacing: iconSize/5

    property color lightColor: Qt.rgba(1,1,1,0.40)
    property color mediumColor: Qt.rgba(1,1,1,0.70)
    property color darkColor: Qt.rgba(1,1,1,1)

    Dot { color: lightColor }
    Dot { color: mediumColor }
    Dot { color: lightColor }

    Dot { color: mediumColor }
    Dot { color: darkColor }
    Dot { color: mediumColor }

    Dot { color: lightColor }
    Dot { color: mediumColor }
    Dot { color: lightColor }
}
