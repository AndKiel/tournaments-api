# == Schema Information
#
# Table name: results
#
#  competitor_id :uuid
#  total         :integer          is an Array
#  tournament_id :uuid
#

class Result < ApplicationRecord
  belongs_to :tournament
end
