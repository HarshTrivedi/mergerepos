class CollegeBranchPair < ActiveRecord::Base
  belongs_to :college
  belongs_to :branch
  has_many :courses
  has_many :comments, as: :commentable
  has_many :user_college_branch_enrollments
  has_many :users, through: :user_college_branch_enrollments


  def add(college_id , branch_id)

  end

end
