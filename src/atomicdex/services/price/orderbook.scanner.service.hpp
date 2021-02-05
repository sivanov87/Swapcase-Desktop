/******************************************************************************
 * Copyright © 2013-2021 The Komodo Platform Developers.                      *
 *                                                                            *
 * See the AUTHORS, DEVELOPER-AGREEMENT and LICENSE files at                  *
 * the top-level directory of this distribution for the individual copyright  *
 * holder information and the developer policies on copyright and licensing.  *
 *                                                                            *
 * Unless otherwise agreed in a custom licensing agreement, no part of the    *
 * Komodo Platform software, including this file may be copied, modified,     *
 * propagated or distributed except according to the terms contained in the   *
 * LICENSE file                                                               *
 *                                                                            *
 * Removal or modification of this copyright notice is prohibited.            *
 *                                                                            *
 ******************************************************************************/

#pragma once

//! Qt
#include <QObject>

//! Deps
#include <antara/gaming/ecs/system.manager.hpp> ///< ecs

//! Project
#include "atomicdex/api/mm2/mm2.hpp" ///< t_best_orders_request

namespace atomic_dex
{
    class orderbook_scanner_service final : public QObject, public ag::ecs::pre_update_system<orderbook_scanner_service>
    {
        Q_OBJECT

        //! Properties

        /**
         * @eg:
         * {
         *      "coin": "KMD",
         *      "best_fiat_price": 0.64,
         *      "current_fiat": "$",
         *      "cex_rates": "-1.31"
         * }
         *
         */
        Q_PROPERTY(QVariant best_orders_infos READ get_best_orders_infos NOTIFY bestOrdersInfosChanged)
        Q_PROPERTY(bool best_orders_busy READ is_best_orders_busy WRITE set_best_orders_busy NOTIFY bestOrdersBusyChanged)

        using t_update_time_point = std::chrono::high_resolution_clock::time_point;
        using t_json_synchronized = boost::synchronized_value<nlohmann::json>;

        ag::ecs::system_manager& m_system_manager;
        std::atomic_bool         m_is_best_orders_busy{false};
        t_json_synchronized      m_best_orders_infos;
        t_update_time_point      m_update_clock;
        t_best_orders_request    m_current_req; ///< current best orders request - change only if process_best_orders is called

        //! Private member functions
        void process_best_orders();

      signals:
        //! Best orders signals
        void bestOrdersBusyChanged();
        void bestOrdersInfosChanged();

      public:
        //! Constructor
        explicit orderbook_scanner_service(entt::registry& registry, ag::ecs::system_manager& system_manager, QObject* parent = nullptr);

        //! Destructor
        ~orderbook_scanner_service() noexcept final = default;

        //! Public override
        void update() noexcept final;

        //! Public API
        void change_best_orders(t_best_orders_request req);

        //! Properties
        void                   set_best_orders_busy(bool status) noexcept;
        [[nodiscard]] bool     is_best_orders_busy() const noexcept;
        [[nodiscard]] QVariant get_best_orders_infos() const noexcept;
    };
} // namespace atomic_dex

REFL_AUTO(type(atomic_dex::orderbook_scanner_service))