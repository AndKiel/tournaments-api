# == Schema Information
#
# Table name: users
#
#  created_at      :datetime         not null
#  email           :string           not null
#  id              :uuid             not null, primary key
#  password_digest :string           not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class User < ApplicationRecord
  include Authenticable

  has_many :competitors, dependent: :destroy
  has_many :tournaments, through: :competitors

  has_many :organised_tournaments,
           class_name: 'Tournament', foreign_key: 'organiser_id', inverse_of: :organiser, dependent: :destroy
  has_many :tournament_competitors, through: :organised_tournaments, source: :competitors
  has_many :tournament_rounds, through: :organised_tournaments, source: :rounds
  has_many :tournament_players, through: :tournament_rounds, source: :players
end
