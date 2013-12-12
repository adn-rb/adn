# encoding: UTF-8

%w{broadcast_message_builder}.each do |f|
  require_relative "recipes/#{f}"
end
