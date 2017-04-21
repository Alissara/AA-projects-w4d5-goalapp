# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  title      :string           not null
#  details    :text
#  visibility :string           default("private"), not null
#  status     :string           default("ongoing"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Goal < ApplicationRecord
  validates :user_id, :title, :visibility, :status, presence: true
  validates :visibility, inclusion: { in: ['public', 'private'] }
  validates :status, inclusion: { in: ['ongoing', 'complete'] }

  belongs_to :user

end
