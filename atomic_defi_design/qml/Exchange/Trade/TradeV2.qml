import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15


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
    RowLayout {
        anchors.fill: parent

        Item {
          Layout.fillWidth: true
          Layout.fillHeight: true
          ColumnLayout {
              anchors.fill: parent
              Item {
                  Layout.fillHeight: true
                  Layout.fillWidth: true
              }

              Item {
                  Layout.preferredHeight: 350
                  Layout.fillWidth: true
                  RowLayout {
                      anchors.fill: parent
                      spacing: 40

                      Item {
                          Layout.fillHeight: true
                          Layout.fillWidth: true
                          Image {
                              anchors.verticalCenter: parent.verticalCenter
                              width: parent.width+20
                              source: "file:///C:/Users/MSI/Desktop/test.svg"
                          }
                          Qaterial.DebugRectangle {
                              anchors.fill: parent
                              visible: exchange_trade.debug
                          }
                      }
                      Item {
                          Layout.fillHeight: true
                          Layout.fillWidth: true
                          Image {
                              anchors.verticalCenter: parent.verticalCenter
                              width: parent.width+20
                              x:-15
                              source: "file:///C:/Users/MSI/Desktop/test2.svg"
                          }
                          Qaterial.DebugRectangle {
                              anchors.fill: parent
                              visible: exchange_trade.debug
                          }
                      }
                  }
                  DefaultButton {
                      anchors.centerIn: parent
                      width: 74
                      height: 74
                      radius: 50
                      font.pixelSize: Style.textSize
                      text: qsTr("")
                      color: Style.colorButtonEnabled.default
                      colorTextEnabled: sell_mode ? Style.colorButtonEnabled.danger : Style.colorButtonDisabled.danger
                      font.weight: Font.Medium
                      onClicked: setMarketMode(MarketMode.Sell)
                  }
              }
          }
        }
        Item {
            Layout.fillHeight: true
            Layout.preferredWidth: 400
            InnerBackground {
                width: 340
                height: parent.height-20
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                radius: 10
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
                                Layout.preferredWidth: 80
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
                                        Layout.preferredWidth: 80
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
                                        Layout.preferredWidth: 80
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
    }
}
