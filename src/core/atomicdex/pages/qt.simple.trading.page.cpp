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