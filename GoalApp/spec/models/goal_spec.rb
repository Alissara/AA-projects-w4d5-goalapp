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

require 'rails_helper'

RSpec.describe Goal, type: :model do
  describe 'validation' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:visibility) }
    it { should validate_presence_of(:status) }

    it do
      should validate_inclusion_of(:visibility)
      .in_array(['public', 'private'])
    end

    it do
      should validate_inclusion_of(:status)
      .in_array(['ongoing', 'complete'])
    end

  describe "associations" do
    it {should belong_to(:user)}
  end

  end
end
