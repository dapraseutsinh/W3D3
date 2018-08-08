# == Schema Information
#
# Table name: visits
#
#  id              :bigint(8)        not null, primary key
#  visitor_user_id :integer
#  visited_url     :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Visit < ApplicationRecord
  validates :visited_url, presence: true

  belongs_to :user,
    primary_key: :id,
      foreign_key: :visitor_user_id,
      class_name: 'User'


  belongs_to :shortened_url,
    primary_key: :id,
    foreign_key: :short_url_id,
    class_name: 'ShortenedURL'



  def self.record_visit(user, shortened_url)
    #create new visit object
    Visit.create!(
      visitor_user_id: user.id,
      visited_url: shortened_url
    )
  end
end

#link user visits to urls
