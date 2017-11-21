# == Route Map
#
# Prefix Verb URI Pattern Controller#Action
#   root GET  /           application#ping
#

Rails.application.routes.draw do
  # use_doorkeeper
  root 'application#ping'
end
