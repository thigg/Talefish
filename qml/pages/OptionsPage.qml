/*

Talefish Audiobook Player
Copyright (C) 2016-2019  John Gibbon

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

*/
import QtQuick 2.6
import Sailfish.Silica 1.0

import QtMultimedia 5.0


import "../lib/"
import "../visual/"


import harbour.talefish.folderlistmodel 1.0

Page {
    id: page
    allowedOrientations: Orientation.All
    property var loadComponents:(['OptionsPlayback', 'OptionsCommands', 'OptionsFiles', 'OptionsAppearance', 'OptionsSleepTimer', 'OptionsMisc'])
    property var areas: ([]);

    function setActiveArea(activeArea) {
        areas.forEach(function(area){
            area.expanded = (area === activeArea)
        });
    }

    SilicaFlickable {
        id: listView

        VerticalScrollDecorator{
            flickable: listView
        }

        anchors.fill: parent
        contentHeight: mainColumn.height

        PullDownMenu {
            id: pulleyTop

            MenuItem {
                text: qsTr('About', 'pulley')
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("AboutPage.qml"), {});
                }
            }
        }

        Column {
            width: parent.width
            id: mainColumn
            PageHeader { title: qsTr("Options", 'header') }

            Repeater {
                model: page.loadComponents
                delegate: Component {
                    Loader {
                        width: parent.width
                        onStatusChanged: {
                            if(status === Loader.Ready) {
                                page.areas.push(item);
                                item.expandedChanged.connect(function(){
                                    if(item.expanded) {
                                        page.setActiveArea(item);
                                    }
                                });
                            }
                        }
                        Component.onCompleted: {
                            setSource('../visual/silica/'+modelData+'.qml', {expanded: index === 0, staticMode: page.loadComponents.length === 1});
                        }
                    }
                }
            }
        }
    }

    Component.onDestruction: {
        //save defaults even if !doPersist?
        app.options.save()
    }

}
