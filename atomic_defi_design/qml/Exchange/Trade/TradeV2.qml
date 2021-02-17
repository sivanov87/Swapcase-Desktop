import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

import Qaterial 1.0 as Qaterial

import AtomicDEX.MarketMode 1.0

import "../../Components"
import "../../Constants"
import "../../Wallet"

Item {
    id: exchange_trade

    Component.onCompleted: {
        API.app.trading_pg.on_gui_enter_dex()
        onOpened()
        chart_object.parent = chart_view
        //chart_object.anchors.bottom = selectors.top
        //chart_object.anchors.bottomMargin = 40
        chart_object.visible = true
    }

    Component.onDestruction: {
        API.app.trading_pg.on_gui_leave_dex()
        chart_object.parent = app
        chart_object.visible = false
    }
    property bool isUltraLarge: width>1400
    readonly property bool block_everything: swap_cooldown.running || fetching_multi_ticker_fees_busy

    readonly property bool fetching_multi_ticker_fees_busy: API.app.trading_pg.fetching_multi_ticker_fees_busy
    readonly property alias multi_order_enabled: multi_order_switch.checked

    signal prepareMultiOrder()
    property bool multi_order_values_are_valid: true

    readonly property string non_null_price: backend_price === '' ? '0' : backend_price
    readonly property string non_null_volume: backend_volume === '' ? '0' : backend_volume
    readonly property bool price_is_empty: parseFloat(non_null_price) <= 0

    readonly property string backend_price: API.app.trading_pg.price
    function setPrice(v) {
        API.app.trading_pg.price = v
    }
    readonly property int last_trading_error: API.app.trading_pg.last_trading_error
    readonly property string max_volume: API.app.trading_pg.max_volume
    readonly property string backend_volume: API.app.trading_pg.volume
    function setVolume(v) {
        API.app.trading_pg.volume = v
    }

    readonly property bool sell_mode: API.app.trading_pg.market_mode == MarketMode.Sell
    function setMarketMode(v) {
        API.app.trading_pg.market_mode = v
    }

    readonly property string base_amount: API.app.trading_pg.base_amount
    readonly property string rel_amount: API.app.trading_pg.rel_amount

    Timer {
        id: swap_cooldown
        repeat: false
        interval: 1000
    }

    property var onOrderSuccess: () => {
        General.prevent_coin_disabling.restart()
        exchange.current_page = idx_exchange_orders
    }

    onSell_modeChanged: reset()

    // Local
    function inCurrentPage() {
        return  exchange.inCurrentPage() &&
                exchange.current_page === idx_exchange_trade
    }

    function reset() {
        multi_order_switch.checked = false
    }

    readonly property var preffered_order: API.app.trading_pg.preffered_order

    function selectOrder(is_asks, coin, price, quantity, price_denom, price_numer, quantity_denom, quantity_numer) {
        setMarketMode(!is_asks ? MarketMode.Sell : MarketMode.Buy)

        API.app.trading_pg.preffered_order = { coin, price, quantity, price_denom, price_numer, quantity_denom, quantity_numer }

        form_base.focusVolumeField()
    }

    // Cache Trade Info
    property bool valid_fee_info: API.app.trading_pg.fees.base_transaction_fees !== undefined
    readonly property var curr_fee_info: API.app.trading_pg.fees

    // Trade
    function onOpened(ticker="") {
        if(!General.initialized_orderbook_pair) {
            General.initialized_orderbook_pair = true
            API.app.trading_pg.set_current_orderbook(General.default_base, General.default_rel)
        }

        reset()
        setPair(true, ticker)
    }

    function setPair(is_left_side, changed_ticker) {
        swap_cooldown.restart()

        if(API.app.trading_pg.set_pair(is_left_side, changed_ticker))
            pairChanged(base_ticker, rel_ticker)
    }

    function trade(options, default_config) {
        // Will move to backend - nota, conf
        let nota = ""
        let confs = ""

        if(options.enable_custom_config) {
            if(options.is_dpow_configurable) {
                nota = options.enable_dpow_confs ? "1" : "0"
            }

            if(nota !== "1") {
                confs = options.required_confirmation_count.toString()
            }
        }
        else {
            if(General.exists(default_config.requires_notarization)) {
                nota = default_config.requires_notarization ? "1" : "0"
            }

            if(nota !== "1" && General.exists(default_config.required_confirmations)) {
                confs = default_config.required_confirmations.toString()
            }
        }

        if(sell_mode)
            API.app.trading_pg.place_sell_order(nota, confs)
        else
            API.app.trading_pg.place_buy_order(nota, confs)
    }

    readonly property bool buy_sell_rpc_busy: API.app.trading_pg.buy_sell_rpc_busy
    readonly property var buy_sell_last_rpc_data: API.app.trading_pg.buy_sell_last_rpc_data

    onBuy_sell_rpc_busyChanged: {
        if(buy_sell_rpc_busy) return

        const response = General.clone(buy_sell_last_rpc_data)

        if(response.error_code) {
            confirm_trade_modal.close()

            toast.show(qsTr("Failed to place the order"), General.time_toast_important_error, response.error_message)

            return
        }
        else if(response.result && response.result.uuid) { // Make sure there is information
            confirm_trade_modal.close()

            toast.show(qsTr("Placed the order"), General.time_toast_basic_info, General.prettifyJSON(response.result), false)

            General.prevent_coin_disabling.restart()
            exchange.current_page = idx_exchange_orders
        }
    }

    // Form
    ColumnLayout {
        id: form

        spacing: layout_margin

        anchors.fill: parent

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 15

            Item {
                id: left_section
                Layout.fillWidth: true
                Layout.fillHeight: true

                // Ticker Selectors
                DefaultFlickable {
                    id: safe_exchange_flickable
                    anchors.fill: parent
                    anchors.margins: 10
                    anchors.rightMargin: 0
                    contentHeight: _content_column.height+10
                    Column {
                        id: _content_column
                        width: safe_exchange_flickable.contentHeight>safe_exchange_flickable.height? parent.width-20 : parent.width
                        spacing: 10
                        Item {
                            id: chart_view
                            width: parent.width
                            height: chart_object.height+10
                        }
                        RowLayout {
                            id: selectors
                            width: parent.width
                            height: 60
                            spacing: 20

                            TickerSelector {
                                id: selector_left
                                left_side: true
                                ticker_list: API.app.trading_pg.market_pairs_mdl.left_selection_box
                                ticker: left_ticker
                                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                                Layout.fillWidth: true
                            }

                            // Swap button
                            SwapIcon {
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                Layout.preferredHeight: selector_left.height * 0.9

                                top_arrow_ticker: selector_left.ticker
                                bottom_arrow_ticker: selector_right.ticker
                                hovered: swap_button.containsMouse

                                DefaultMouseArea {
                                    id: swap_button
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onClicked: {
                                        if(!block_everything)
                                            setPair(true, right_ticker)
                                    }
                                }
                            }

                            TickerSelector {
                                id: selector_right
                                left_side: false
                                ticker_list: API.app.trading_pg.market_pairs_mdl.right_selection_box
                                ticker: right_ticker
                                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                Layout.fillWidth: true
                            }
                        }
                        StackLayout {
                            id: orderbook_area
                            height: isUltraLarge? 0 : 250
                            Behavior on height {
                                NumberAnimation {
                                    duration: 150
                                }
                            }
                            visible: height>0

                            width: parent.width


                            OrderBookV2 {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                            }

                        }

                        MultiOrder {
                            visible: multi_order_enabled
                            width: parent.width
                            height: 250
                        }


                        // Price
                        Column {
                            width: parent.width-10
                            height: 300
                            anchors.horizontalCenter: parent.horizontalCenter
                            Qaterial.TabBar {
                                z: 4
                                id: tabView
                                width: parent.width
                                currentIndex: swipeView.currentIndex
                                anchors.horizontalCenter: parent.horizontalCenter
                                background: FloatingBackground {
                                    black_shadow.visible: false
                                    radius: 0
                                }
                                y:5
                                leftPadding: 15
                                Qaterial.TabButton {
                                    width: 150
                                    text: "Taux d'échange"
                                    opacity: checked? 1 : .4
                                }
                                Qaterial.TabButton {
                                    width: 120
                                    text: "Ordres"
                                    opacity: checked? 1 : .4
                                }
                                Qaterial.TabButton {
                                    width: 120
                                    text: "Historique"
                                    opacity: checked? 1 : .4
                                }
                            }
                            FloatingBackground {
                                anchors.horizontalCenter: parent.horizontalCenter
                                radius: 4
                                width: parent.width
                                height: 120
                                SwipeView {
                                    id: swipeView
                                    currentIndex: tabView.currentIndex
                                    anchors.fill: parent
                                    Item {

                                        PriceLine {
                                            id: price_line_obj
                                            anchors.verticalCenter: parent.verticalCenter
                                            anchors.left: parent.left
                                            anchors.right: parent.right
                                        }
                                    }
                                }
                            }
                        }
//                        InnerBackground {
//                            id: price_line
//                            width: parent.width
//                            height: price_line_obj.height + 30
//                            PriceLine {
//                                id: price_line_obj
//                                anchors.verticalCenter: parent.verticalCenter
//                                anchors.left: parent.left
//                                anchors.right: parent.right
//                            }
//                        }
                    }


                }
                Qaterial.DebugRectangle {
                    anchors.fill: parent
                    visible: false
                }

                
            }
            OrderBookVertical { }

            Item {
                id: forms
                width: 375
                Layout.fillHeight: true

                OrderForm {
                    id: form_base

                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                }

                // Multi-Order
                FloatingBackground {
                    visible: sell_mode

                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: form_base.bottom
                    anchors.topMargin: layout_margin

                    height: column_layout.height

                    ColumnLayout {
                        id: column_layout

                        width: parent.width

                        ColumnLayout {
                            Layout.fillWidth: true
                            Layout.leftMargin: layout_margin
                            Layout.rightMargin: layout_margin
                            Layout.topMargin: layout_margin
                            Layout.bottomMargin: layout_margin
                            spacing: layout_margin

                            DefaultSwitch {
                                id: multi_order_switch
                                Layout.leftMargin: 15
                                Layout.rightMargin: Layout.leftMargin
                                Layout.fillWidth: true

                                text: qsTr("Multi-Order")
                                enabled: !block_everything && (form_base.can_submit_trade || checked)

                                checked: API.app.trading_pg.multi_order_enabled
                                onCheckedChanged: {
                                    if(checked) {
                                        setVolume(max_volume)
                                        API.app.trading_pg.multi_order_enabled = checked
                                    }
                                }
                            }

                            DefaultText {
                                id: first_text

                                Layout.leftMargin: multi_order_switch.Layout.leftMargin
                                Layout.rightMargin: Layout.leftMargin
                                Layout.fillWidth: true

                                text_value: qsTr("Select additional assets for multi-order creation.")
                                font.pixelSize: Style.textSizeSmall2
                            }

                            DefaultText {
                                Layout.leftMargin: multi_order_switch.Layout.leftMargin
                                Layout.rightMargin: Layout.leftMargin
                                Layout.fillWidth: true

                                text_value: qsTr("Same funds will be used until an order matches.")
                                font.pixelSize: first_text.font.pixelSize
                            }

                            DefaultButton {
                                text: qsTr("Submit Trade")
                                Layout.leftMargin: multi_order_switch.Layout.leftMargin
                                Layout.rightMargin: Layout.leftMargin
                                Layout.fillWidth: true
                                enabled: multi_order_enabled && form_base.can_submit_trade
                                onClicked: {
                                    multi_order_values_are_valid = true
                                    prepareMultiOrder()
                                    if(multi_order_values_are_valid)
                                        confirm_multi_order_trade_modal.open()
                                }
                            }
                        }
                    }
                }
            }
        }

        ModalLoader {
            id: confirm_trade_modal
            sourceComponent: ConfirmTradeModal {}
        }

        ModalLoader {
            id: confirm_multi_order_trade_modal
            sourceComponent: ConfirmMultiOrderTradeModal {}
        }
    }
}
