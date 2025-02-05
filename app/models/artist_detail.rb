class ArtistDetail < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true, uniqueness: true

  validate :validates_social_media_link

  private

  def validates_social_media_link
    %w[instagram_link pinterest_link dribble_link behance_link etsy_link].each do |link|
      value = send(link)
      next if value.blank?

      unless valid_url?(value)
        errors.add(link.to_sym, "must be a valid URL")
      end
    end
  end

  def valid_url?(url)
    uri = URI.parse(url)
    uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
  rescue URI::InvalidURIError
    false
  end
end
