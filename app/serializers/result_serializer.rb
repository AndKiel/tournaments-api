# == Schema Information
#
# Table name: results
#
#  competitor_id :uuid
#  total         :integer          is an Array
#  tournament_id :uuid
#

class ResultSerializer < ActiveModel::Serializer
  attributes :competitor_id,
             :total
end
