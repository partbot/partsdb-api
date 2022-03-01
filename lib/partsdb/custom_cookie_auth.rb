# frozen_string_literal: true

require "faraday"

module Partsdb
  class CustomCookieAuth < Faraday::Middleware
    def initialize(app, api_key)
      @app = app
      @auth_cookie = {}
      @api_key = api_key
    end

    def call(request_env)
      handle_request request_env
      app.call(request_env)
    end

    private

    def handle_request(request_env)
      if @auth_cookie.nil? || @auth_cookie.empty?
        new_env = request_env.dup
        new_env.url = request_env.url.dup
        new_env.url.path = "/v1.1/Authentication/Login"

        new_env.method = :post
        new_env.body = { "apiKey": @api_key }.to_json
        new_env.request_headers = { "Content-Type": "application/json" }

        @app.call(new_env).on_complete do |response_env|
          @auth_cookie = parse_set_cookie(response_env.response_headers["set-cookie"])
          handle_request(request_env)
        end
      else
        @auth_cookie.each do |k, v|
          request_env.request_headers["cookie"] = "#{k}=#{v}"
        end
      end
    end

    def parse_set_cookie(all_cookies_string)
      cookies = {}

      unless all_cookies_string.nil? || all_cookies_string.empty?
        # single cookies are devided with comma
        all_cookies_string.split(",").each do |single_cookie_string|
          # parts of single cookie are seperated by semicolon; first part is key and value of this cookie
          # @type [String]
          cookie_part_string  = single_cookie_string.strip.split(";")[0]
          # remove whitespaces at beginning and end in place and split at '='
          # @type [Array]
          cookie_part         = cookie_part_string.strip.split("=")
          # @type [String]
          key                 = cookie_part[0]
          # @type [String]
          value               = cookie_part[1]

          # add cookie to Hash
          cookies[key] = value
        end
      end

      cookies
    end
  end

  Faraday::Middleware.register_middleware custom_cookie_auth: -> { CustomCookieAuth }
end
