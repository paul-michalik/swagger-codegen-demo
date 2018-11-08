#include "ApiClient.h"
#include "ApiConfiguration.h"
#include "AgentsApi.h"
#include "AgentDataApi.h"
#include "MapDataApi.h"

#include <cpprest/asyncrt_utils.h>
#include <exception>
#include <iostream>
#include <memory>
#include <cstdlib>

int main(int const argc, char const* argv[]) {
  using namespace ::utility::conversions;
  using namespace ::io::swagger::client::api;

  // TODO: Use this template from routing as agent client
  /*
  try {
    std::string const url = argv[1];
    auto waypoints = [](char const* const* begin,
                        char const* const* const end) {
      ::utility::string_t joined = to_string_t(*begin);
      while (++begin != end) {
        joined.append(U(";"));
        joined.append(to_string_t(*begin));
      }
      return joined;
    }(argv + 2, argv + argc);

    auto conf = std::make_shared<ApiConfiguration>();
    conf->setBaseUrl(to_string_t(url));

    auto const sslCaCert = std::getenv("DEMO_CLIENT_CACERT");
    auto const sslCert = std::getenv("DEMO_CLIENT_CERT");
    auto const sslKey = std::getenv("DEMO_CLIENT_KEY");
    if (sslCaCert || sslCert || sslKey) {
      using namespace ::boost::asio::ssl;
      std::cout << "Setting SSL certificate files...\n";
      conf->getHttpConfig().set_ssl_context_callback([&](context& c) {
        if (sslCaCert) {
          c.load_verify_file(sslCaCert);
        }
        if (sslCert) {
          c.use_certificate_file(sslCert, context_base::pem);
        }
        if (sslKey) {
          c.use_private_key_file(sslKey, context_base::pem);
        }
      });
    }

    auto client = std::make_shared<ApiClient>(std::move(conf));

    std::cout << "Executing API call...\n";
    RouteApi routeApi{std::move(client)};
    routeApi
        .calculateRoute(std::move(waypoints), U("json"), {}, {3}, {}, {}, {},
                        {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {},
                        {{U("summary")}})
        .then([](std::shared_ptr<RouteResponse> const resp) {
          for (auto const& route : resp->getRoutes()) {
            std::cout << "Alternative " << route->getAlternativeId() << ":\n";
            for (auto const& leg : route->getLegs()) {
              std::cout << "  Leg " << leg->getLegId() << " is ";
              std::cout << leg->getSummary()->getDistance() * 1e-5
                        << " km long and takes ";
              std::cout << (leg->getSummary()->getDuration() * 1e-3) / 60.0
                        << " min\n";
            }
            std::cout << '\n';
          }
        })
        .wait();

  } catch (std::exception const& e) {
    std::cerr << "Caught exception: " << e.what() << '\n';
  }
  */
  return 0;
}