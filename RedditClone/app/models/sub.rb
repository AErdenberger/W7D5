# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  title        :string           not null
#  description  :text
#  moderator_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Sub < ApplicationRecord
    validates :title, presence: true, uniqueness: true
    validates :moderator_id, presence: true
    validates :description, allow_nil: true

    belongs_to :moderator,
    primary_key: :id,
    foreign_key: :moderator_id,
    class_name: :User
end
