#pragma once

namespace atomic_dex
{
    class simple_trading_page final : public QObject, public ag::ecs::pre_update_system<simple_trading_page>
    {
        Q_OBJECT

        //! Private member fields
        ag::ecs::system_manager& m_system_mgr;
      public:
        simple_trading_page(entt::registry& registry, ag::ecs::system_manager& system_manager, QObject* parent = nullptr);
        ~simple_trading_page() final = default;

        //! Public override
        void update() final;
    };
}

REFL_AUTO(type(atomic_dex::simple_trading_page))