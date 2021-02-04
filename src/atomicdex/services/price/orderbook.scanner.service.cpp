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

//! Deps
#include "atomicdex/services/price/orderbook.scanner.service.hpp"

//! Constructor
namespace atomic_dex
{
    orderbook_scanner_service::orderbook_scanner_service(entt::registry& registry, ag::ecs::system_manager& system_manager, QObject* parent) :
        QObject(parent), system(registry), m_system_manager(system_manager)
    {
        SPDLOG_INFO("orderbook_scanner_service created");
    }
} // namespace atomic_dex

//! Public override
namespace atomic_dex
{
    void
    orderbook_scanner_service::update() noexcept
    {
        /**
         * TODO:
         * - API best_orders [x]
         * - Property QVariantMap with Coin, Best Fiat Price and CEX Rates inside []
         * - Property fetching busy in orderbook_scanner_widget to spin
         * - orderbook_scanner_widget class that will get value from this service []
         * - emit event here when the update is finished so we can update data in frontend []
         *
         * Workflow (Advanced view) :
         *
         * Clear when switching between Buy / Sell
         * Clear when changing coin
         * Spin when changing volume (force an update)
         *
         * Workflow (Simple view) :
         *
         * Spin when changing volume of the desired coin to buy/sell
         * Don't spin when changing coin until we change the volume
         *
         * Requirements for the widget:
         *
         * - Should have a message when volume is 0 or empty (please enter a valid volume to find best offers)
         * - If there is no best offers for the coin show a message
         * - Spinner when fetching is busy
         * - Fetch best price every 30seconds or if we click on the reload button
         */
    }
} // namespace atomic_dex
