# frozen_string_literal: true

require "sinatra/base"

class Sandbox < Sinatra::Base
  get("/") { "<h1>Hello world!</h1>" }
end
