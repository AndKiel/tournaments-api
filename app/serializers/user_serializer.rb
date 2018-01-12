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

class UserSerializer < ActiveModel::Serializer
  attributes :email,
             :id
end
