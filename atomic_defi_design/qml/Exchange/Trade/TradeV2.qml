import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.0

import AtomicDEX.MarketMode 1.0
import Qaterial 1.0 as Qaterial

import "../../Components"
import "../../Constants"
import "../../Wallet"

Item {
    id: exchange_trade
    property bool debug: false
    property var model1:  [
        { "price": 0.0088152, "qty": 1547752.5511250, "percent_depth": 60, "total": 5556950.05585998, "is_mine":false },
        { "price": 0.0088152, "qty": 1547752.5511250, "percent_depth": 57, "total": 5556950.05585998, "is_mine":false },
        { "price": 0.0088152, "qty": 1547752.5511250, "percent_depth": 56, "total": 5556950.05585998, "is_mine":false },
        { "price": 0.0088152, "qty": 1547752.5511250, "percent_depth": 50, "total": 5556950.05585998, "is_mine":false },
        { "price": 0.0088152, "qty": 1547752.5511250, "percent_depth": 45, "total": 5556950.05585998, "is_mine":false },
        { "price": 0.0088152, "qty": 1547752.5511250, "percent_depth": 40, "total": 5556950.05585998, "is_mine":false },
        { "price": 0.0088152, "qty": 1547752.5511250, "percent_depth": 35, "total": 5556950.05585998, "is_mine":false },
        { "price": 0.0088152, "qty": 1547752.5511250, "percent_depth": 30, "total": 5556950.05585998, "is_mine":false },
        { "price": 0.0088152, "qty": 1547752.5511250, "percent_depth": 25, "total": 5556950.05585998, "is_mine":false },
        { "price": 0.0088152, "qty": 1547752.5511250, "percent_depth": 20, "total": 5556950.05585998, "is_mine":false },
        { "price": 0.0088152, "qty": 1547752.5511250, "percent_depth": 10, "total": 5556950.05585998, "is_mine":false },
        { "price": 0.0088152, "qty": 1547752.5511250, "percent_depth": 5, "total": 5556950.05585998, "is_mine":false },

    ]
    property var model2: [
        { "price": 0.008124, "qty": 21.269, "percent_depth": 5, "total": 1.2778, "is_mine":false },
        { "price": 0.008122, "qty": 0.214, "percent_depth": 10, "total": 0.1872, "is_mine":false },
        { "price": 0.008120, "qty": 1.247, "percent_depth": 15, "total": 2.1928, "is_mine":false },
        { "price": 0.008118, "qty": 2.589, "percent_depth": 20, "total": 1.2918, "is_mine":false },
        { "price": 0.008117, "qty": 12.154, "percent_depth": 25, "total": 0.0050, "is_mine":false },
        { "price": 0.008115, "qty": 545100.158, "percent_depth": 30, "total": 0.082, "is_mine":false },
        { "price": 0.008115, "qty": 0.057, "percent_depth": 35, "total": 0.1892, "is_mine":true },
        { "price": 0.008114, "qty": 0.047, "percent_depth": 43, "total": 1.2918, "is_mine":false },
        { "price": 0.008111, "qty": 545100.014, "percent_depth": 50, "total": 10.8769, "is_mine":true },
        { "price": 0.008110, "qty": 0.057, "percent_depth": 55, "total": 22.1928, "is_mine":false },
        { "price": 0.008109, "qty": 54510.586, "percent_depth": 60, "total": 0.1921, "is_mine":true },
        { "price": 0.008108, "qty": 8.476, "percent_depth": 65, "total": 12.1921, "is_mine":true },
    ]
    property bool isUltraLarge: width>1400
    RowLayout {
        anchors.fill: parent
        spacing: 0
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            DefaultFlickable {
              anchors.fill: parent
              contentHeight: _main_column.height
              Column {
                  id: _main_column
                  topPadding: 90
                  width: parent.width-10
                  anchors.horizontalCenterOffset: 5
                  spacing: 0
                  Item {
                      height: 500
                      width: parent.width
                      InnerBackground {
                          anchors.horizontalCenterOffset: 1
                          anchors.fill: parent
                          anchors.margins: 10
                          radius: 10
                      }
                  }
                  Item {
                      height: isUltraLarge? 0 : 320
                      Behavior on height {
                          NumberAnimation {
                              duration: 200
                          }
                      }

                      width: parent.width
                      visible: height>0
                      InnerBackground {
                          width: parent.width-20
                          height: parent.height-20
                          anchors.horizontalCenter: parent.horizontalCenter
                          anchors.verticalCenter: parent.verticalCenter
                          radius: 6
                          RowLayout {
                              anchors.fill: parent
                              spacing: 5

                              Item {
                                  Layout.fillHeight: true
                                  Layout.fillWidth: true
                                  ListView {
                                      id: listView4
                                      anchors.fill: parent
                                      model: exchange_trade.model1
                                      clip: true
                                      snapMode: ListView.SnapToItem
                                      headerPositioning: ListView.OverlayHeader
                                      header: Rectangle {
                                          height: 34
                                          width: listView4.width
                                          color: "#15182A"
                                          radius: 100
                                          z: 2
                                          RowLayout {
                                              width: parent.width-30
                                              height: parent.height
                                              anchors.horizontalCenter: parent.horizontalCenter
                                              DefaultText {
                                                  Layout.alignment: Qt.AlignVCenter
                                                  Layout.preferredWidth: 60
                                                  text: "Price"
                                                  font.family: 'Montserrat'
                                                  font.pixelSize: 13
                                                  font.bold: true
                                                  font.weight: Font.Bold
                                              }
                                              DefaultText {
                                                  Layout.alignment: Qt.AlignVCenter
                                                  Layout.preferredWidth: 50
                                                  text: "Qty"
                                                  font.family: 'Montserrat'
                                                  font.pixelSize: 13
                                                  font.bold: true
                                                  font.weight: Font.Bold
                                                  horizontalAlignment: Label.AlignRight
                                              }
                                              Item {
                                                  Layout.fillWidth: true
                                                  Layout.fillHeight: true
                                              }
                                              DefaultText {
                                                  Layout.alignment: Qt.AlignVCenter
                                                  Layout.preferredWidth: 70
                                                  text: "Total"
                                                  horizontalAlignment: Label.AlignRight
                                                  font.family: 'Montserrat'
                                                  font.pixelSize: 13
                                                  font.bold: true
                                                  font.weight: Font.Bold
                                              }
                                          }
                                          Separator {

                                          }
                                      }
                                      Component.onCompleted: positionViewAtEnd()
                                      delegate: Item {
                                          width: listView4.width
                                          height: 34
                                          RowLayout {
                                              width: parent.width-30
                                              height: parent.height
                                              anchors.horizontalCenter: parent.horizontalCenter
                                              spacing: 10
                                              DefaultText {
                                                  Layout.alignment: Qt.AlignVCenter
                                                  Layout.preferredWidth: 60
                                                  text: exchange_trade.model1[index].price
                                                  font.pixelSize: Style.textSizeSmall1
                                                  color: "#E31A93"
                                                  opacity: 1
                                                  Qaterial.DebugRectangle {
                                                      anchors.fill: parent
                                                      visible: exchange_trade.debug
                                                  }
                                              }
                                              DefaultText{
                                                  Layout.alignment: Qt.AlignVCenter
                                                  Layout.preferredWidth: 50
                                                  text:  General.nFormatter(exchange_trade.model1[index].qty, 3)
                                                  font.pixelSize: Style.textSizeSmall1
                                                  horizontalAlignment: Label.AlignRight
                                                  opacity: 1
                                                  Qaterial.DebugRectangle {
                                                      anchors.fill: parent
                                                      visible: exchange_trade.debug
                                                  }
                                              }
                                              Item {
                                                  Layout.fillWidth: true
                                                  Layout.fillHeight: true
                                                  Rectangle {
                                                      height: 10
                                                      radius: 101
                                                      color: "#E31A93"
                                                      width: (exchange_trade.model1[index].percent_depth*(parent.width+40))/100
                                                      opacity:  (index+1)/11
                                                      Behavior on width {
                                                          NumberAnimation {
                                                              duration: 1000
                                                          }
                                                      }
                                                      anchors.verticalCenter: parent.verticalCenter
                                                  }
                                                  Qaterial.DebugRectangle {
                                                      anchors.fill: parent
                                                      visible: exchange_trade.debug
                                                  }
                                              }
                                              DefaultText {
                                                  Layout.alignment: Qt.AlignVCenter
                                                  Layout.preferredWidth: 60
                                                  text: General.nFormatter(exchange_trade.model1[index].total,3)
                                                  horizontalAlignment: Label.AlignRight
                                                  font.pixelSize: Style.textSizeSmall1
                                                  opacity: 1
                                                  Qaterial.DebugRectangle {
                                                      anchors.fill: parent
                                                      visible: exchange_trade.debug
                                                  }
                                              }
                                          }
                                          Separator {
                                              width: listView.width
                                          }
                                      }
                                  }
                              }
                              Item {
                                  Layout.fillHeight: true
                                  Layout.fillWidth: true
                                  ListView {
                                      id: listView3
                                      anchors.fill: parent
                                      model: exchange_trade.model2
                                      clip: true
                                      snapMode: ListView.SnapToItem
                                      headerPositioning: ListView.OverlayHeader
                                      header: Rectangle {
                                          height: 34
                                          width: listView4.width
                                          color: "#15182A"
                                          radius: 100
                                          z: 2
                                          RowLayout {
                                              width: parent.width-30
                                              height: parent.height
                                              anchors.horizontalCenter: parent.horizontalCenter
                                              DefaultText {
                                                  Layout.alignment: Qt.AlignVCenter
                                                  Layout.preferredWidth: 60
                                                  text: "Price"
                                                  font.family: 'Montserrat'
                                                  font.pixelSize: 13
                                                  font.bold: true
                                                  font.weight: Font.Bold
                                              }
                                              DefaultText {
                                                  Layout.alignment: Qt.AlignVCenter
                                                  Layout.preferredWidth: 50
                                                  text: "Qty"
                                                  font.family: 'Montserrat'
                                                  font.pixelSize: 13
                                                  font.bold: true
                                                  font.weight: Font.Bold
                                                  horizontalAlignment: Label.AlignRight
                                              }
                                              Item {
                                                  Layout.fillWidth: true
                                                  Layout.fillHeight: true
                                              }
                                              DefaultText {
                                                  Layout.alignment: Qt.AlignVCenter
                                                  Layout.preferredWidth: 70
                                                  text: "Total"
                                                  horizontalAlignment: Label.AlignRight
                                                  font.family: 'Montserrat'
                                                  font.pixelSize: 13
                                                  font.bold: true
                                                  font.weight: Font.Bold
                                              }
                                          }
                                          Separator {

                                          }
                                      }
                                      delegate: Item {
                                          width: listView3.width
                                          height: 34

                                          RowLayout {
                                              width: parent.width-30
                                              height: parent.height
                                              anchors.horizontalCenter: parent.horizontalCenter
                                              spacing: 10
                                              DefaultText {
                                                  Layout.alignment: Qt.AlignVCenter
                                                  Layout.preferredWidth: 60
                                                  text: exchange_trade.model2[index].price
                                                  font.family: 'Montserrat'
                                                  font.pixelSize: Style.textSizeSmall1
                                                  color: "#0AFFEF"
                                              }
                                              DefaultText {
                                                  Layout.alignment: Qt.AlignVCenter
                                                  Layout.preferredWidth: 50
                                                  text:  exchange_trade.model2[index].qty
                                                  font.pixelSize: Style.textSizeSmall1
                                                  horizontalAlignment: Label.AlignRight
                                              }
                                              Item {
                                                  Layout.fillWidth: true
                                                  Layout.fillHeight: true
                                                  Rectangle {
                                                      height: 10
                                                      radius: 101
                                                      color: "#0AFFEF"
                                                      opacity:  1-(index+1)/13
                                                      width:(exchange_trade.model2[index].percent_depth*(parent.width+40))/100
                                                      Behavior on width {
                                                          NumberAnimation {
                                                              duration: 1000
                                                          }
                                                      }

                                                      anchors.verticalCenter: parent.verticalCenter
                                                  }

                                              }
                                              DefaultText {
                                                  Layout.minimumWidth: 50
                                                  Layout.alignment: Qt.AlignVCenter
                                                  Layout.preferredWidth: 50
                                                  text: exchange_trade.model2[index].total
                                                  horizontalAlignment: Label.AlignRight
                                                  font.pixelSize: Style.textSizeSmall1
                                              }
                                          }
                                          Separator {

                                          }
                                      }
                                  }
                              }
                          }
                      }
                      Qaterial.DebugRectangle {
                          anchors.fill: parent
                          visible: false
                      }
                  }

                  Item {
                      height: 350
                      width: parent.width
                      InnerBackground {
                          anchors.horizontalCenterOffset: 1
                          anchors.fill: parent
                          anchors.margins: 10
                          radius: 10
                      }
                  }
              }
            }
            Item {
                height: 90
                width: parent.width-15
                FloatingBackground {
                    anchors.horizontalCenterOffset: 1
                    anchors.fill: parent
                    anchors.margins: 10
                    radius: 10
                    RowLayout {
                        anchors.fill: parent
                        Item {
                            Layout.preferredWidth: 250
                            Layout.fillHeight: true
                            Qaterial.FlatButton {
                                width: 230
                                height: parent.height-10
                                x: 10
                                anchors.verticalCenter: parent.verticalCenter
                                Row {
                                    anchors.centerIn: parent
                                    Image {
                                          height: 36
                                          width: 36
                                        source: "qrc:/atomic_defi_design/assets/images/coins/dash.png"
                                    }
                                    spacing: 10
                                    DefaultText {
                                        text: "DASH / BTC"
                                        font.family: Style.font_family
                                        anchors.verticalCenter: parent.verticalCenter
                                        font.pixelSize: 26
                                        anchors.verticalCenterOffset: -2
                                    }
                                    Qaterial.ColorIcon {
                                        source: Qaterial.Icons.menuDown
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }
                            }
                        }
                        VerticalLine {
                            Layout.fillHeight: true
                        }
                        Item {
                            Layout.preferredWidth: 120
                            Layout.fillHeight: true
                            Column {
                                anchors.verticalCenter: parent.verticalCenter
                                leftPadding: 20
                                spacing: 5
                                DefaultText {
                                    text: "Last Price"
                                    font.family: Style.font_family
                                    font.pixelSize: Style.textSize

                                }
                                DefaultText {
                                    text: "0.008091 BTC"
                                    font.family: Style.font_family
                                    font.pixelSize: Style.textSizeSmall2
                                }
                            }
                        }
                        VerticalLine {
                            Layout.fillHeight: true
                        }
                        Item {
                            Layout.preferredWidth: 100
                            Layout.fillHeight: true
                            Column {
                                anchors.verticalCenter: parent.verticalCenter
                                leftPadding: 20
                                spacing: 5
                                DefaultText {
                                    text: "Last Price"
                                    font.family: Style.font_family
                                    font.pixelSize: Style.textSize

                                }
                                DefaultText {
                                    text: "0.008091 BTC"
                                    font.family: Style.font_family
                                    font.pixelSize: Style.textSizeSmall2
                                }
                            }
                        }


                        Item {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                        }
                    }
                }
            }
        }

        Item {
            Layout.fillHeight: true
            Layout.preferredWidth: isUltraLarge? 320 : 0
            Behavior on Layout.preferredWidth {
                NumberAnimation {
                    duration: 100
                }
            }
            visible: Layout.preferredWidth>0
            InnerBackground {
                width: 280
                height: parent.height-20
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                radius: 6
                ColumnLayout {
                    anchors.fill: parent
                    spacing: 5
                    Item {
                        Layout.fillWidth: true
                        height: 34
                        RowLayout {
                            width: parent.width-30
                            height: parent.height
                            anchors.horizontalCenter: parent.horizontalCenter
                            DefaultText {
                                Layout.alignment: Qt.AlignVCenter
                                Layout.preferredWidth: 60
                                text: "Price"
                                font.family: 'Montserrat'
                                font.pixelSize: 13
                                font.bold: true
                                font.weight: Font.Bold
                            }
                            DefaultText {
                                Layout.alignment: Qt.AlignVCenter
                                Layout.preferredWidth: 50
                                text: "Qty"
                                font.family: 'Montserrat'
                                font.pixelSize: 13
                                font.bold: true
                                font.weight: Font.Bold
                                horizontalAlignment: Label.AlignRight
                            }
                            Item {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                            }
                            DefaultText {
                                Layout.alignment: Qt.AlignVCenter
                                Layout.preferredWidth: 70
                                text: "Total"
                                horizontalAlignment: Label.AlignRight
                                font.family: 'Montserrat'
                                font.pixelSize: 13
                                font.bold: true
                                font.weight: Font.Bold
                            }
                        }
                        Separator {

                        }
                    }
                    Item {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        ListView {
                            id: listView
                            anchors.fill: parent
                            model: exchange_trade.model1
                            clip: true
                            Component.onCompleted: positionViewAtEnd()
                            delegate: Item {
                                width: listView.width
                                height: 34
                                RowLayout {
                                    width: parent.width-30
                                    height: parent.height
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    spacing: 10
                                    DefaultText {
                                        Layout.alignment: Qt.AlignVCenter
                                        Layout.preferredWidth: 60
                                        text: exchange_trade.model1[index].price
                                        font.pixelSize: Style.textSizeSmall1
                                        color: "#E31A93"
                                        opacity: 1
                                        Qaterial.DebugRectangle {
                                            anchors.fill: parent
                                            visible: exchange_trade.debug
                                        }
                                    }
                                    DefaultText{
                                        Layout.alignment: Qt.AlignVCenter
                                        Layout.preferredWidth: 50
                                        text:  General.nFormatter(exchange_trade.model1[index].qty, 3)
                                        font.pixelSize: Style.textSizeSmall1
                                        horizontalAlignment: Label.AlignRight
                                        opacity: 1
                                        Qaterial.DebugRectangle {
                                            anchors.fill: parent
                                            visible: exchange_trade.debug
                                        }
                                    }
                                    Item {
                                        Layout.fillWidth: true
                                        Layout.fillHeight: true
                                        Rectangle {
                                            height: 10
                                            radius: 101
                                            color: "#E31A93"
                                            width: (exchange_trade.model1[index].percent_depth*(parent.width+40))/100
                                            opacity:  (index+1)/11
                                            Behavior on width {
                                                NumberAnimation {
                                                    duration: 1000
                                                }
                                            }
                                            anchors.verticalCenter: parent.verticalCenter
                                        }
                                        Qaterial.DebugRectangle {
                                            anchors.fill: parent
                                            visible: exchange_trade.debug
                                        }
                                    }
                                    DefaultText {
                                        Layout.alignment: Qt.AlignVCenter
                                        Layout.preferredWidth: 60
                                        text: General.nFormatter(exchange_trade.model1[index].total,3)
                                        horizontalAlignment: Label.AlignRight
                                        font.pixelSize: Style.textSizeSmall1
                                        opacity: 1
                                        Qaterial.DebugRectangle {
                                            anchors.fill: parent
                                            visible: exchange_trade.debug
                                        }
                                    }
                                }
                                Separator {
                                    width: listView.width
                                }
                            }
                        }
                    }
                    Item {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 30
                    }

                    Item {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        ListView {
                            id: listView2
                            anchors.fill: parent
                            model: exchange_trade.model2
                            clip: true
                            delegate: Item {
                                width: listView2.width
                                height: 34

                                RowLayout {
                                    width: parent.width-30
                                    height: parent.height
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    spacing: 10
                                    DefaultText {
                                        Layout.alignment: Qt.AlignVCenter
                                        Layout.preferredWidth: 60
                                        text: exchange_trade.model2[index].price
                                        font.family: 'Montserrat'
                                        font.pixelSize: Style.textSizeSmall1
                                        color: "#0AFFEF"
                                    }
                                    DefaultText {
                                        Layout.alignment: Qt.AlignVCenter
                                        Layout.preferredWidth: 50
                                        text:  exchange_trade.model2[index].qty
                                        font.pixelSize: Style.textSizeSmall1
                                        horizontalAlignment: Label.AlignRight
                                    }
                                    Item {
                                        id: pparent
                                        Layout.fillWidth: true
                                        Layout.fillHeight: true
                                        Rectangle {
                                            height: 10
                                            radius: 101
                                            color: "#0AFFEF"
                                            opacity:  1-(index+1)/13
                                            width:(exchange_trade.model2[index].percent_depth*(parent.width+40))/100
                                            Behavior on width {
                                                NumberAnimation {
                                                    duration: 1000
                                                }
                                            }

                                            anchors.verticalCenter: parent.verticalCenter
                                        }

                                    }
                                    DefaultText {
                                        id: lb
                                        Layout.minimumWidth: 50
                                        Layout.alignment: Qt.AlignVCenter
                                        Layout.preferredWidth: 50
                                        text: exchange_trade.model2[index].total
                                        horizontalAlignment: Label.AlignRight
                                        font.pixelSize: Style.textSizeSmall1
                                    }
                                }
                                Separator {

                                }
                            }
                        }
                    }
                }
            }
            Qaterial.DebugRectangle {
                anchors.fill: parent
                visible: false
            }
        }

        Item {
            Layout.preferredWidth: 270
            Layout.fillHeight: true
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 80
                Item {
                    width: 250
                    height: 400
                    FloatingBackground {
                        anchors.fill: parent
                        border.width: 3
                        radius: 5
                        ColumnLayout {
                            anchors.fill: parent
                            spacing: 0
                            anchors.topMargin: 10
                            Row {
                                width: parent.width-60
                                height: 60
                                spacing: -1
                                Layout.alignment: Qt.AlignHCenter
                                DefaultButton {
                                    width: 120
                                    Layout.preferredHeight: 48
                                    color: !enabled ? colorDisabled : containsMouse ? Qaterial.Colors.green500 : Qaterial.Colors.green500
                                    text: "BUY"
                                    radius: 2
                                    showShadow: false
                                    verticalShadow: false
                                    font.pixelSize: Style.textSizeMid1


                                }

                                DefaultButton {
                                    radius: 2
                                    width: 120
                                    height: 53
                                    color: !enabled ? colorDisabled : containsMouse ? Qaterial.Colors.red500 : "#0E1021"//Qaterial.Colors.red500
                                    text: "SELL"
                                    showShadow: false
                                    verticalShadow: false
                                    font.pixelSize: Style.textSizeMid1
                                }
                            }

                            Item {
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                            }
                        }
                    }
                }

                Item {
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                }
            }

        }

    }
}
