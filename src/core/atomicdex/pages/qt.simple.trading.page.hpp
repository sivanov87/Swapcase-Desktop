#pragma once

namespace atomic_dex
{
    class simple_trading_page final : public QObject, public ag::ecs::pre_update_system<simple_trading_page>
    {
        Q_OBJECT

        Q_PROPERTY(QString from READ get_from NOTIFY fromChanged)
        Q_PROPERTY(QString to READ get_to NOTIFY toChanged)
        Q_PROPERTY(QString price READ get_price NOTIFY priceChanged)

        //! Private member fields
        ag::ecs::system_manager& m_system_mgr;

        //! Property private fields
        QString m_from{""};
        QString m_to{""};
        QString m_price{""};

        //! Private property setter
        void set_from(QString from);
        void set_to(QString to);
        void set_price(QString price);

      public:
        simple_trading_page(entt::registry& registry, ag::ecs::system_manager& system_manager, QObject* parent = nullptr);
        ~simple_trading_page() final = default;

        //! Public override
        void update() final;

        //! Property
        [[nodiscard]] QString get_from() const;
        [[nodiscard]] QString get_to() const;
        [[nodiscard]] QString get_price() const;

      signals:
        void fromChanged();
        void toChanged();
        void priceChanged();
    };
} // namespace atomic_dex

REFL_AUTO(type(atomic_dex::simple_trading_page))