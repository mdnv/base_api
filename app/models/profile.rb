class Profile < ApplicationRecord
  belongs_to :user, class_name: "User", foreign_key: "user_id", optional: true

  has_attached_file :avatar, styles: {medium: "300x300#", thumb: "100x100#", small: "30x30#"},
                    default_url: ->(attachment) {ActionController::Base.helpers.asset_path("avatar-default.png")}
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  validate :avatar_size
  validate :birthday_future

  private

  def avatar_size
    if avatar.present? && avatar_file_size > 2.megabytes
      errors.add(:file_size, "must be between 0 and 2 megabytes.")
    end
  end

  def birthday_future
    if birthday.present? && birthday > Time.now.to_date
      errors.add(:birthday, "invalid")
    end
  end
end
