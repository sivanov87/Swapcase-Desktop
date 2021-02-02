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

namespace atomic_dex
{
    class orderbook_scanner_service final : public QObject, public ag::ecs::pre_update_system<orderbook_scanner_service>
    {
        Q_OBJECT

        ag::ecs::system_manager& m_system_manager;

      public:
        //! Constructor
        explicit orderbook_scanner_service(entt::registry& registry, ag::ecs::system_manager& system_manager, QObject* parent = nullptr);

        //! Destructor
        ~orderbook_scanner_service() noexcept final = default;

        //! Public override
        void update() noexcept final;

        //! QML API
    };
} // namespace atomic_dex

REFL_AUTO(type(atomic_dex::orderbook_scanner_service))