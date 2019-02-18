class User < ApplicationRecord
  has_many :tasks, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  validates :email, presence: true

  before_update :update_last_administrator
  before_destroy :destroy_last_administrator

  private

  def update_last_administrator
    errors.add(:base, "だって最後のadmin userですもの😲")
    throw(:abort) if (self.admin == false && User.where(admin: true).size == 1) && self == User.find_by(admin: true)
  end

  def destroy_last_administrator
    if self.admin == true && User.where(admin: true).count == 1
      throw(:abort)
    end
  end

end
