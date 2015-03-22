class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  validates :title, :estimate, :user, presence: true
  acts_as_taggable

  include AASM

  aasm skip_validation_on_save: true do
    state :begin, initial: true
    state :sent_for_review
    state :sent_back_for_revision
    state :accepted
    state :complete

    event :send_for_review do
      transitions from: [:begin, :sent_back_for_revision], to: :sent_for_review
    end

    event :send_back do
      transitions from: :sent_for_review, to: :sent_back_for_revision
    end

    event :accept do
      transitions from: [:sent_for_review, :sent_back_for_revision],
                  to: :accepted
    end

    event :end_up do
      transitions from: :accepted, to: :complete
    end
  end

  def send_forward
    case aasm_state
    when "begin" then self.send_for_review!
    when "sent_for_review" then self.accept!
    when "sent_back_for_revision" then self.send_for_review!
    when "accepted" then self.end_up!
    end
  end
end
