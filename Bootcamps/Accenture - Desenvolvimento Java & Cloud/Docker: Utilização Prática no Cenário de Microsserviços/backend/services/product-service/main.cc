#include <drogon/drogon.h>
#include "models/Product.h"
#include <vector>
#include <json/json.h>

using namespace ecommerce::models;

int main() {
    drogon::app().loadConfigFile("config.json");

    drogon::app().registerHandler("/health",
                                  [](const drogon::HttpRequestPtr &req,
                                     std::function<void(const drogon::HttpResponsePtr &)> &&callback) {
                                      auto resp = drogon::HttpResponse::newHttpResponse();
                                      resp->setBody("Product Service is running with DB (C++20)");
                                      callback(resp);
                                  });

    drogon::app().registerHandler("/products",
                                  [](const drogon::HttpRequestPtr &req,
                                     std::function<void(const drogon::HttpResponsePtr &)> &&callback) {
                                      auto dbClient = drogon::app().getDbClient();
                                      dbClient->execSqlAsync(
                                          "SELECT id, name, price, stock_quantity FROM products",
                                          [callback](const drogon::orm::Result &result) {
                                              Json::Value ret(Json::arrayValue);
                                              for (auto row : result) {
                                                  Json::Value p;
                                                  p["id"] = row["id"].as<int>();
                                                  p["name"] = row["name"].as<std::string>();
                                                  p["price"] = row["price"].as<double>();
                                                  p["stock"] = row["stock_quantity"].as<int>();
                                                  ret.append(p);
                                              }
                                              auto resp = drogon::HttpResponse::newHttpJsonResponse(ret);
                                              callback(resp);
                                          },
                                          [callback](const drogon::orm::DrogonDbException &e) {
                                              auto resp = drogon::HttpResponse::newHttpResponse();
                                              resp->setStatusCode(drogon::k500InternalServerError);
                                              resp->setBody(std::string("Database error: ") + e.base().what());
                                              callback(resp);
                                          });
                                  });

    drogon::app().addListener("0.0.0.0", 8080);
    drogon::app().run();
    return 0;
}
