#include <drogon/drogon.h>
#include "models/Order.h"
#include <json/json.h>

using namespace ecommerce::models;

int main() {
    drogon::app().loadConfigFile("config.json");

    drogon::app().registerHandler("/health",
                                  [](const drogon::HttpRequestPtr &req,
                                     std::function<void(const drogon::HttpResponsePtr &)> &&callback) {
                                      auto resp = drogon::HttpResponse::newHttpResponse();
                                      resp->setBody("Order Service is running with DB (C++20)");
                                      callback(resp);
                                  });

    drogon::app().registerHandler("/my-orders",
                                  [](const drogon::HttpRequestPtr &req,
                                     std::function<void(const drogon::HttpResponsePtr &)> &&callback) {
                                      Json::Value ret;
                                      Json::Value o1;
                                      o1["id"] = 101;
                                      o1["total"] = 250.0;
                                      o1["status"] = "Processing";
                                      ret.append(o1);
                                      
                                      auto resp = drogon::HttpResponse::newHttpJsonResponse(ret);
                                      callback(resp);
                                  });

    drogon::app().addListener("0.0.0.0", 8080);
    drogon::app().run();
    return 0;
}
