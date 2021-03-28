//
// Created by Sztergbaum Roman on 28/03/2021.
//

#include <QJsonObject>

#include "atomicdex/pages/common/common.trading.hpp"
#include "atomicdex/services/mm2/mm2.service.hpp"
#include "atomicdex/utilities/global.utilities.hpp"

namespace
{
    TradingError
    generate_fees_error(const atomic_dex::trading_infos& cfg)
    {
        TradingError       last_trading_error = TradingError::None;
        const auto&        mm2                = cfg.system_manager.get_system<atomic_dex::mm2_service>();
        const QVariantMap& fees               = cfg.fees;
        const auto         is_selected_order  = cfg.is_selected_order;

        //! Check taker fee only if it's a selected order
        if (is_selected_order && safe_float(fees["trading_fee"].toString().toStdString()) > cfg.max_balance_without_dust)
        {
            last_trading_error = TradingError::TradingFeesNotEnoughFunds; ///< need to have for multi ticker check
        }
        //! Check base transaction fees, we do not need to check if it's a selected order, every order even maker_order need to pay transaction fees
        else if (!mm2.do_i_have_enough_funds(
                     fees["base_transaction_fees_ticker"].toString().toStdString(), safe_float(fees["base_transaction_fees"].toString().toStdString())))
        {
            last_trading_error = TradingError::BaseTransactionFeesNotEnough; ///< need to have for multi ticker check
        }
        else if (fees.contains("rel_transaction_fees_ticker")) //! Checking rel coin if specific fees aka: ETH, QTUM, QRC-20, ERC-20 ?
        {
            const auto rel_ticker = fees["rel_transaction_fees_ticker"].toString().toStdString();
            t_float_50 rel_amount = safe_float(fees["rel_transaction_fees"].toString().toStdString());
            if (not mm2.do_i_have_enough_funds(rel_ticker, rel_amount))
            {
                last_trading_error = TradingError::RelTransactionFeesNotEnough; ///< need to have for multi ticker check
            }
        }
        else
        {
            for (auto&& cur: fees["total_fees"].toJsonArray())
            {
                auto&& cur_obj = cur.toObject();
                if (!mm2.do_i_have_enough_funds(cur_obj["coin"].toString().toStdString(), safe_float(fees["amount"].toString().toStdString())))
                {
                    last_trading_error = TradingError::TotalFeesNotEnoughFunds;
                    break;
                }
            }
        }
        return last_trading_error;
    }
} // namespace

namespace atomic_dex
{
    TradingError
    determine_trading_error(const trading_infos& cfg)
    {
        TradingError current_trading_error = TradingError::None;

        if (cfg.max_balance_without_dust < utils::minimal_trade_amount()) //<! Checking balance < minimal_trading_amount
        {
            current_trading_error = TradingError::BalanceIsLessThanTheMinimalTradingAmount;
        }
        else if (cfg.volume.isEmpty()) ///< Volume is not set correctly
        {
            current_trading_error = TradingError::VolumeFieldNotFilled;
        }
        else if (cfg.price.isEmpty() || cfg.price == "0") ///< Price is not set correctly
        {
            current_trading_error = TradingError::PriceFieldNotFilled; ///< need to have for multi ticker check
        }
        else if (cfg.base_amount < utils::minimal_trade_amount())
        {
            current_trading_error = TradingError::VolumeIsLowerThanTheMinimum;
        }
        else if (cfg.rel_amount < utils::minimal_trade_amount())
        {
            current_trading_error = TradingError::ReceiveVolumeIsLowerThanTheMinimum; ///< need to have for multi ticker check
        }
        else
        {
            if (!cfg.fees.empty())
            {
                current_trading_error = generate_fees_error(cfg);
            }
        }

        return current_trading_error;
    }
} // namespace atomic_dex