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

namespace atomic_dex
{
    void
    atomic_dex::simple_trading_page::set_from(QString from)
    {
        if (m_from != from)
        {
            m_from = std::move(from);
            emit fromChanged();
        }
    }

    void
    atomic_dex::simple_trading_page::set_to(QString to)
    {
        if (m_to != to)
        {
            m_to = std::move(to);
            emit toChanged();
        }
    }

    void
    atomic_dex::simple_trading_page::set_price(QString price)
    {
        if (m_price != price)
        {
            m_price = std::move(price);
            emit priceChanged();
        }
    }

    QString
    simple_trading_page::get_to() const
    {
        return m_to;
    }

    QString
    simple_trading_page::get_from() const
    {
        return m_from;
    }

    QString
    simple_trading_page::get_price() const
    {
        return m_price;
    }
} // namespace atomic_dex