# frozen_string_literal: true

# == Schema Information
#
# Table name: results
#
#  total         :bigint           is an Array
#  competitor_id :uuid
#  tournament_id :uuid
#

class ResultSerializer < Blueprinter::Base
  fields :competitor_id,
         :total
end
