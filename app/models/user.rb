# == Schema Information
#
# Table name: users
#
#  created_at      :datetime         not null
#  email           :string           not null
#  id              :uuid             not null, primary key
#  name            :string           default(""), not null
#  password_digest :string           not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class User < ApplicationRecord
  has_many :competitors, dependent: :destroy
  has_many :tournaments, foreign_key: 'organizer_id', dependent: :destroy
end
