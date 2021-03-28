#pragma once

//! Qt
#include <QVariantMap>

//! Deps
#include <antara/gaming/ecs/system.manager.hpp>

//! Project Headers
#include <atomicdex/constants/qt.trading.enums.hpp>
#include <atomicdex/utilities/safe.float.hpp>

namespace atomic_dex
{
    struct trading_infos
    {
        t_float_50                           max_balance_without_dust;
        const QString&                       volume;
        const QString&                       price;
        t_float_50                           base_amount;
        t_float_50                           rel_amount;
        QVariantMap                          fees;
        antara::gaming::ecs::system_manager& system_manager;
        bool                                 is_selected_order{false};
        TradingMode                          current_trading_mode;
    };

    TradingError determine_trading_error(const trading_infos& cfg);
} // namespace atomic_dex