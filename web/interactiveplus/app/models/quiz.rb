class Quiz < ActiveRecord::Base
    has_many :questions, dependent: :destroy
    accepts_nested_attributes_for :questions, allow_destroy: true
    belongs_to :user
    default_scope -> { order(created_at: :desc) }
    validates :user_id, presence: true
    validates :name, presence: true
end
