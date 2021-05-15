// Deps headers
#include <doctest/doctest.h>
#include <antara/app/net/http.code.hpp>

// Project headers
#include "atomicdex/api/github/github.api.hpp"
#include "atomicdex/version/version.hpp"

TEST_CASE("Fetch last GitHub release and compa²re with current")
{
    auto error_functor = [](pplx::task<void> previous_task) { handle_exception_pplx_task(previous_task, std::nullopt); };
    atomic_dex::github_api::repository_releases_request request {.owner = "KomodoPlatform", .repository = "atomicdex-desktop"};
    atomic_dex::github_api::get_repository_releases_async(request)
        .then([](web::http::http_response resp)
        {
            REQUIRE(resp.status_code() == static_cast<unsigned>(antara::app::http_code::ok));
            CHECK(atomic_dex::github_api::get_last_repository_release_from_http_response(resp).tag_name == atomic_dex::get_version());
        })
        .then(error_functor)
        .wait();
}