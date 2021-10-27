import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

import QtGraphicalEffects 1.0
import "../Components"
import "../Constants"

Item {
    id: root

    property string link
    property bool section_enabled: true
    property alias mouse_area: mouse_area

    property int dashboard_index
    property alias image: img.source
    property alias text_value: txt.text
    property alias separator: separator.visible
    property alias checked: switch_input.checked
    readonly property bool selected: dashboard.current_page === dashboard_index

    function toggleDarkUI() {
        Style.dark_theme = !Style.dark_theme
    }

    function togglePrivacyMode() {
        General.privacy_mode = !General.privacy_mode
    }

    height: Style.sidebarLineHeight

    DefaultSwitch {
        id: switch_input
        visible: dashboard_index === idx_dashboard_light_ui ||
                 dashboard_index === idx_dashboard_privacy_mode
        anchors.left: parent.left
        anchors.leftMargin: 7
        anchors.verticalCenter: img.verticalCenter
        scale: 0.75
    }

    DefaultImage {
        id: img
        height: txt.font.pixelSize * 1.4
        anchors.left: parent.left
        anchors.leftMargin: 30
        scale: 1.2
        anchors.verticalCenter: parent.verticalCenter
        visible: false
    }
    DropShadow {
        visible: selected
        anchors.fill: img
        source: img
        cached: false
        horizontalOffset: 0
        verticalOffset: 3
        radius: 3
        //scale: 
        samples: 6
        antialiasing: true
        spread: 0
        color: "#40000000"
        smooth: true
    }
    DefaultColorOverlay {
        id: img_color
        visible: img.source != ""
        anchors.fill: img
        source: img
        color: txt.font.weight === Font.Medium ? Style.colorSidebarIconHighlighted : txt.color
    }

    DexLabel {
        id: txt
        anchors.left: parent.left
        anchors.leftMargin: 70
        anchors.verticalCenter: parent.verticalCenter
        scale: Qt.platform.os==="windows"? 1.2 : API.app.settings_pg.lang=="fr"? 0.85 : 1
        font: Qt.font({
            pixelSize: 16*_font.fontDensity*_font.languageDensity,
            letterSpacing: 0.5,
            family: _font.fontFamily,
            weight: Font.Normal
        })
        color: !section_enabled ? Style.colorTextDisabled :
                selected ? Style.colorSidebarSelectedText :
                mouse_area.containsMouse ? Style.colorThemePassiveLight :
                                           Style.colorThemePassive
    }
    DropShadow {
        visible: selected
        anchors.fill: txt
        source: txt
        cached: false
        horizontalOffset: 0
        verticalOffset: 3
        radius: 3
        samples: 4
        spread: 0
        scale: Qt.platform.os==="windows"? 1.2 : API.app.settings_pg.lang=="fr"? 0.85 : 1
        color: "#40000000"
        smooth: true
    }

    DefaultMouseArea {
        id: mouse_area
        hoverEnabled: true
        width: parent.width
        height: parent.height
        onClicked: Qt.openUrlExternally(link)
    }

    Separator {
        id: separator
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width - 10
    }
}




