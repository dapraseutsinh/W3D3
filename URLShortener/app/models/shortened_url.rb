# == Schema Information
#
# Table name: shortened_urls
#
#  id        :bigint(8)        not null, primary key
#  user_id   :integer
#  long_url  :string
#  short_url :string
#  email     :string
#

class ShortenedURL < ActiveRecord::Base
  validates :email, presence: true

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: 'User'

  has_many :visitors,
    primary_key: :id,
    foreign_key: :visitor_user_id,
    class_name: 'User'

  def self.random_code
    #search the short_url column,
    code = SecureRandom.urlsafe_base64
    until !ShortenedURL.find_by_short_url(code)
      code = SecureRandom.urlsafe_base64
    end
    code
  end

  def self.generate_short_url(user, long_url)
    short_url = self.random_code
    ShortenedURL.create!(
      user_id: user.id,
      long_url: long_url,
      short_url: short_url,
      email: user.email
    )
  end

  def num_clicks
    # should count the number of clicks on a ShortenedUrl.
    Visit.where(visited_url: self.id).count
  end

  def num_uniques
    # should determine the number of distinct users who have clicked a link.
    Visit.visitor_user_id.uniq.count
  end

  def num_recent_uniques
  end
end


# (short_url: code)
