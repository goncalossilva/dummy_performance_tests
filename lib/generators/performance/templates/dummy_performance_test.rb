require File.expand_path('../test_helper', __FILE__)
require 'rails/performance_test_help'

class <%= @model_name.camelcase %>Test < ActionDispatch::PerformanceTest
  <% @routes.each do |request, data| %>
  def test_<%= request %>
    <%= data["type"] %>_via_redirect "<%= data['url'] %>"<%= (", " + data["params"].inspect) if data["params"] %>
  end
  <% end %>
end
