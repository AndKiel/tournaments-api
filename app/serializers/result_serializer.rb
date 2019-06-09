# == Schema Information
#
# Table name: results
#
#  total         :bigint           is an Array
#  competitor_id :uuid
#  tournament_id :uuid
#

class ResultSerializer < ActiveModel::Serializer
  attributes :competitor_id,
             :total
end
