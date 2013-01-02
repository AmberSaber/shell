/****************************************************************************
 * This file is part of Fluid.
 *
 * Copyright (C) 2012-2013 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 * Copyright (C) 2011 Daker Fernandes Pinheiro <dakerfp@gmail.com>
 *
 * Author(s):
 *    Pier Luigi Fiorini
 *    Daker Fernandes Pinheiro
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

/**Documented API
Inherits:
        Item

Imports:
        QtQuick 2.0
        FluidCore
        FluidExtra

Description:
            It is a simple progressBar which is using the plasma theme.
            Some operations take a period of time to be performed and the user needs a confirmation that the operation is still ongoing. If the user does not get any confirmation, they might suspect that they did something wrong or that the device has broken. A progress bar is one of available mechanisms for providing this reassurance to the user.

Properties:
          * real minimumValue:
            Minimum Value for the progressBar

          * real maximumValue:
            Maximum value for the progressBar

            real value:
            Current value of the progressBar

          * bool indeterminate:
            Indicates whether the operation's duration is known or not. The property can have the following values:
            true - the operation's duration is unknown, so the progress bar is animated. The value, minimum, and maximum properties are ignored.
            false - the operation's duration is known, so the progress bar is drawn to indicate progress between the minimum and maximum values.
            The default value is false.

          * int orientation:
            Orientation of the progressBar:
            Qt.Horizontal or
            Qt.Vertical
**/

import QtQuick 2.0
import FluidCore 1.0 as FluidCore
import FluidExtra 1.0 as FluidExtra

Item {
    id: progressBar

    // Common API
    property alias minimumValue: range.minimumValue
    property alias maximumValue: range.maximumValue
    property alias value: range.value
    property alias indeterminate: indeterminateAnimation.running

    // Plasma API
    property int orientation: Qt.Horizontal

    width: 100
    height: 20
    opacity: enabled ? 1.0 : 0.5

    FluidCore.RangeModel {
        id: range

        // default values
        minimumValue: 0.0
        maximumValue: 1.0
        value: 0

        positionAtMinimum: 0
        positionAtMaximum: backgroundPixmapItem.width
    }

    Item {
        id: contents

        property bool _isVertical: orientation == Qt.Vertical
        property int _tileWidth: width

        width: _isVertical ? progressBar.height : progressBar.width
        height: _isVertical ? progressBar.width : progressBar.height
        rotation: _isVertical ? 90 : 0
        anchors.centerIn: parent

        Timer {
            id: resizeTimer
            repeat: false
            interval: 0
            running: false
            onTriggered: {
                contents._tileWidth = Math.floor(contents.width/(Math.floor(contents.width/(contents.height/1.6))))


                if (barFrameSvg.hasElement("hint-bar-stretch")) {
                    barFrameSvg.resizeFrame(Qt.size(barPixmapItem.width, barPixmapItem.height))
                } else {
                    barFrameSvg.resizeFrame(Qt.size(contents._tileWidth, contents.height))
                }
                barPixmapItem.pixmap = barFrameSvg.framePixmap()

                if (backgroundFrameSvg.hasElement("hint-bar-stretch")) {
                    backgroundFrameSvg.resizeFrame(Qt.size(backgroundPixmapItem.width, backgroundPixmapItem.height))
                } else {
                    backgroundFrameSvg.resizeFrame(Qt.size(contents._tileWidth, contents.height))
                }
                backgroundPixmapItem.pixmap = backgroundFrameSvg.framePixmap()
            }
        }
        FluidCore.FrameSvg {
            id: barFrameSvg
            Component.onCompleted: {
                barFrameSvg.setImagePath("widgets/bar_meter_horizontal")
                barFrameSvg.setElementPrefix("bar-active")
                resizeTimer.restart()
            }
        }
        FluidCore.FrameSvg {
            id: backgroundFrameSvg
            Component.onCompleted: {
                backgroundFrameSvg.setImagePath("widgets/bar_meter_horizontal")
                backgroundFrameSvg.setElementPrefix("bar-inactive")
                resizeTimer.restart()
            }
        }
        FluidExtra.PixmapItem {
            id: backgroundPixmapItem
            anchors.fill: parent
            fillMode: FluidExtra.PixmapItem.TileHorizontally
            onWidthChanged: resizeTimer.restart()
            onHeightChanged: resizeTimer.restart()
        }

        FluidExtra.PixmapItem {
            id: barPixmapItem
            fillMode: FluidExtra.PixmapItem.TileHorizontally
            width: indeterminate ? contents._tileWidth*2 : range.position
            height: contents.height

            visible: indeterminate || value > 0
            onWidthChanged: resizeTimer.restart()

            SequentialAnimation {
                id: indeterminateAnimation

                loops: Animation.Infinite

                onRunningChanged: {
                    if (!running) {
                        barPixmapItem.x = 0
                    }
                }

                PropertyAnimation {
                    target: barPixmapItem
                    property: "x"
                    duration: 800
                    to: 0
                }
                PropertyAnimation {
                    target: barPixmapItem
                    property: "x"
                    duration: 800
                    to: backgroundPixmapItem.width - barPixmapItem.width
                }
            }
        }
    }
}
