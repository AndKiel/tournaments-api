# == Schema Information
#
# Table name: results
#
#  total         :bigint           is an Array
#  competitor_id :uuid
#  tournament_id :uuid
#

class Result < ApplicationRecord
  belongs_to :tournament
end
