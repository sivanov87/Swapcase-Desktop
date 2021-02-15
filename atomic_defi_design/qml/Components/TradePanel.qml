import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.0

import AtomicDEX.MarketMode 1.0
import Qaterial 1.0 as Qaterial

import "../Constants"
import "../Wallet"

Item {
    id: root
    width: 250
    height: 200
    property alias rect: im
    property double border_gradient_start_pos: 0.35
    property double border_gradient_end_pos: 0.65
    property color border_color_start: Style.colorRectangleBorderGradient1
    property color border_color_end: Style.colorRectangleBorderGradient2
    property bool verticalShadow: false
    property bool opacity_mask_enabled: false
    property bool auto_set_size: true
    property bool reverse: false

    Image {
        id: im
        source: "file:///C:/Users/MSI/Desktop/test3_blank.png"
        anchors.horizontalCenter: parent.horizontalCenter

        ColumnLayout {
            anchors.fill: parent
        }
    }

    DropShadow {
        anchors.fill: im
        source: im
        cached: false
        horizontalOffset: root.reverse? 2 : -1
        verticalOffset:  root.reverse? 5 : -1
        radius: true ? 25 : 15
        samples: 32
        spread: 0
        color: true ? Style.colorDropShadowLight2 : Style.colorDropShadowLight
        smooth: true
        z: -2
    }

    DropShadow {
        anchors.fill: im
        source: im
        cached: false
        horizontalOffset:  root.reverse? -6 : 6
        verticalOffset: root.reverse? -3 : 10
        radius: true ? 25 : 20
        samples: 32
        spread: 0
        color: Style.colorDropShadowDark
        smooth: true
        z: -2
    }

    Qaterial.DebugRectangle {
        anchors.fill: parent
        visible: exchange_trade.debug
    }
}
