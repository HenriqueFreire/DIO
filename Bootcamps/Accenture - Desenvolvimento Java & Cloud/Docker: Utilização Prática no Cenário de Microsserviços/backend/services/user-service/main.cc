#include <drogon/drogon.h>
#include "models/User.h"
#include <json/json.h>

using namespace ecommerce::models;

int main() {
    // Carregar configuração (incluindo banco de dados)
    drogon::app().loadConfigFile("config.json");

    drogon::app().registerHandler("/health",
                                  [](const drogon::HttpRequestPtr &req,
                                     std::function<void(const drogon::HttpResponsePtr &)> &&callback) {
                                      auto resp = drogon::HttpResponse::newHttpResponse();
                                      resp->setBody("User Service is running with DB (C++20)");
                                      callback(resp);
                                  });
    drogon::app().registerHandler("/register",
                                  [](const drogon::HttpRequestPtr &req,
                                     std::function<void(const drogon::HttpResponsePtr &)> &&callback) {
                                      auto json = req->getJsonObject();
                                      if (!json || !(*json).isMember("username") || !(*json).isMember("password") || !(*json).isMember("email")) {
                                          auto resp = drogon::HttpResponse::newHttpResponse();
                                          resp->setStatusCode(drogon::k400BadRequest);
                                          resp->setBody("Invalid JSON or missing fields");
                                          callback(resp);
                                          return;
                                      }

                                      std::string username = (*json)["username"].asString();
                                      std::string password = (*json)["password"].asString();
                                      std::string email = (*json)["email"].asString();

                                      auto dbClient = drogon::app().getDbClient();
                                      dbClient->execSqlAsync(
                                          "INSERT INTO users (username, password_hash, email) VALUES ($1, $2, $3)",
                                          [callback](const drogon::orm::Result &result) {
                                              auto resp = drogon::HttpResponse::newHttpResponse();
                                              resp->setBody("User registered successfully");
                                              callback(resp);
                                          },
                                          [callback](const drogon::orm::DrogonDbException &e) {
                                              auto resp = drogon::HttpResponse::newHttpResponse();
                                              resp->setStatusCode(drogon::k500InternalServerError);
                                              resp->setBody(std::string("Registration failed: ") + e.base().what());
                                              callback(resp);
                                          },
                                          username, password, email);
                                  },
                                  {drogon::Post});

    drogon::app().registerHandler("/login",
                                  [](const drogon::HttpRequestPtr &req,
                                     std::function<void(const drogon::HttpResponsePtr &)> &&callback) {
                                      auto json = req->getJsonObject();
                                      if (!json || !(*json).isMember("username") || !(*json).isMember("password")) {
                                          auto resp = drogon::HttpResponse::newHttpResponse();
                                          resp->setStatusCode(drogon::k400BadRequest);
                                          resp->setBody("Invalid JSON or missing fields");
                                          callback(resp);
                                          return;
                                      }

                                      std::string username = (*json)["username"].asString();
                                      std::string password = (*json)["password"].asString();

                                      auto dbClient = drogon::app().getDbClient();
                                      dbClient->execSqlAsync(
                                          "SELECT id, username FROM users WHERE username = $1 AND password_hash = $2",
                                          [callback](const drogon::orm::Result &result) {
                                              if (result.size() > 0) {
                                                  Json::Value ret;
                                                  ret["message"] = "Login successful";
                                                  ret["user_id"] = result[0]["id"].as<int>();
                                                  ret["token"] = "mock-jwt-token-C20"; // Placeholder for actual JWT
                                                  auto resp = drogon::HttpResponse::newHttpJsonResponse(ret);
                                                  callback(resp);
                                              } else {
                                                  auto resp = drogon::HttpResponse::newHttpResponse();
                                                  resp->setStatusCode(drogon::k401Unauthorized);
                                                  resp->setBody("Invalid credentials");
                                                  callback(resp);
                                              }
                                          },
                                          [callback](const drogon::orm::DrogonDbException &e) {
                                              auto resp = drogon::HttpResponse::newHttpResponse();
                                              resp->setStatusCode(drogon::k500InternalServerError);
                                              resp->setBody(std::string("Login failed: ") + e.base().what());
                                              callback(resp);
                                          },
                                          username, password);
                                  },
                                  {drogon::Post});
    
    drogon::app().run();
    return 0;
}
