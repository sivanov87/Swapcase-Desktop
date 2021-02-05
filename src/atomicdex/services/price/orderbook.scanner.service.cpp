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

//! QT
#include <QJsonDocument>

//! Deps
#include <nlohmann/json.hpp> ///< nlohmann::json::object();

//! Project
#include "atomicdex/services/mm2/mm2.service.hpp"
#include "atomicdex/services/price/orderbook.scanner.service.hpp"

/**
 * TODO:
 * - API best_orders [x]
 * - Property QVariantMap with Coin, Best Fiat Price and CEX Rates inside [x]
 * - Property fetching busy in orderbook_scanner_widget to spin [x]
 * - orderbook_scanner_widget class that will get value from this service [] ~not sure
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

//! Constructor
namespace atomic_dex
{
    orderbook_scanner_service::orderbook_scanner_service(entt::registry& registry, ag::ecs::system_manager& system_manager, QObject* parent) :
        QObject(parent), system(registry), m_system_manager(system_manager)
    {
        SPDLOG_INFO("orderbook_scanner_service created");
        m_update_clock      = std::chrono::high_resolution_clock::now();
        m_best_orders_infos = nlohmann::json::object();
    }
} // namespace atomic_dex

//! Private member functions
namespace atomic_dex
{
    void
    orderbook_scanner_service::process_best_orders()
    {
        if (m_system_manager.has_system<mm2_service>())
        {
            auto& mm2_system = m_system_manager.get_system<mm2_service>();
            if (mm2_system.is_mm2_running())
            {
                this->set_best_orders_busy(true);

                //! Prepare request
                nlohmann::json batch = nlohmann::json::array();
                nlohmann::json best_orders_req_json;
                to_json(best_orders_req_json, m_current_req);
                batch.push_back(best_orders_req_json);


                //! Treat answer
                auto answer_functor = [this]([[maybe_unused]] web::http::http_response resp) {
                    SPDLOG_WARN("Best Orders is Not implemented yet");
                    this->set_best_orders_busy(false);
                };

                ::mm2::api::async_rpc_batch_standalone(batch, mm2_system.get_mm2_client(), mm2_system.get_cancellation_token())
                    .then(answer_functor)
                    .then(&handle_exception_pplx_task);
            }
            else
            {
                SPDLOG_WARN("MM2 Service not launched yet - skipping");
            }
        }
        else
        {
            SPDLOG_WARN("MM2 Service not created yet - skipping");
        }
    }
} // namespace atomic_dex

//! Public override
namespace atomic_dex
{
    void
    orderbook_scanner_service::update() noexcept
    {
        using namespace std::chrono_literals;

        const auto now = std::chrono::high_resolution_clock::now();
        const auto s   = std::chrono::duration_cast<std::chrono::seconds>(now - m_update_clock);
        if (s >= 30s)
        {
            process_best_orders();
            m_update_clock = std::chrono::high_resolution_clock::now();
        }
    }
} // namespace atomic_dex

namespace atomic_dex
{
    void
    orderbook_scanner_service::change_best_orders(t_best_orders_request req)
    {
        m_current_req = req;
        process_best_orders();
    }
} // namespace atomic_dex

//! Properties
namespace atomic_dex
{
    void
    orderbook_scanner_service::set_best_orders_busy(bool status) noexcept
    {
        if (m_is_best_orders_busy != status)
        {
            m_is_best_orders_busy = status;
            emit bestOrdersBusyChanged();
        }
    }

    bool
    orderbook_scanner_service::is_best_orders_busy() const noexcept
    {
        return m_is_best_orders_busy.load();
    }

    QVariant
    orderbook_scanner_service::get_best_orders_infos() const noexcept
    {
        nlohmann::json status = *m_best_orders_infos;
        QJsonDocument  doc    = QJsonDocument::fromJson(QString::fromStdString(status.dump()).toUtf8());
        return doc.toVariant();
    }
} // namespace atomic_dex