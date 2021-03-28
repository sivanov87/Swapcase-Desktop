//
// Created by Sztergbaum Roman on 28/03/2021.
//

#include "atomicdex/pages/qt.simple.trading.page.hpp"

namespace atomic_dex
{
    simple_trading_page::simple_trading_page(entt::registry& registry, ag::ecs::system_manager& system_manager, QObject* parent) :
        QObject(parent), system(registry), m_system_mgr(system_manager)
    {
        this->disable();
        SPDLOG_INFO("simple trading page created");
    }
} // namespace atomic_dex

namespace atomic_dex
{
    void
    simple_trading_page::update()
    {
    }
} // namespace atomic_dex

/**
    else
    {
        m_total_amount = total_amount;
        emit       totalAmountChanged();
        emit       baseAmountChanged();
        emit       relAmountChanged();
        t_float_50 price_f(0);
        t_float_50 total_amount_f(safe_float(total_amount.toStdString()));
        t_float_50 volume_f(safe_float(m_volume.toStdString()));
        if (volume_f > 0)
        {
            price_f = total_amount_f / volume_f;
        }
        this->set_price(QString::fromStdString(utils::format_float(price_f)));
    }*/