class CollegesController < ApplicationController
  layout "logged_in"
  before_action :authenticate_user!
  before_filter :college_exists
  before_filter :branch_exists_if_passed 
  # before_filter :branch_passed , :only => [:show_discussion]


  def show_content
    	college_id = params[:id]
    	@college = College.find_by_id(college_id)

      if current_user.college_branch_enrolled?
        @branch = current_user.branch        
      else      
        branches = @college.branches.order(:created_at)
        @branches_name_id = branches.map{|branch| [branch.name , branch.id] }
        branch_id = params[:branch_id]
        @branch = Branch.find_by_id(branch_id)
      end


      if @branch
          @message = "College-Branch specific buckets"
          @buckets = @college.buckets_by_branch(@branch).order(:created_at).page(params[:page])
      else
          @message = "College specific buckets"
    	   	@buckets = @college.buckets.order(:created_at).page(params[:page])
      end
  end

  def show_users
      college_id = params[:id]
      @college = College.find_by_id(college_id)


      if current_user.college_branch_enrolled?
        @branch = current_user.branch
      else
        branches = @college.branches.order(:created_at)
        @branches_name_id = branches.map{|branch| [branch.name , branch.id] }
        branch_id = params[:branch_id]
        @branch = Branch.find_by_id(branch_id)
      end

      if @branch
        @message = "College-Branch specific users"
        @users = @college.users_by_branch(@branch.id).order(:created_at).page(params[:page])
      else
        @message = "College specific users"
        @users = @college.users.order(:created_at).page(params[:page])
      end
  end


  def show_courses
      college_id = params[:id]
      @college = College.find_by_id(college_id)

      if current_user.college_branch_enrolled?
        @branch = current_user.branch
      else
        branches = @college.branches.order(:created_at)
        @branches_name_id = branches.map{|branch| [branch.name , branch.id] }
        branch_id = params[:branch_id]
        @branch = Branch.find_by_id(branch_id)
      end

      if @branch
        @message = "College-Branch specific courses"
        @courses = @college.courses_by_branch(@branch.id).page(params[:page])
      else
        @message = "College specific courses"
        @courses = @college.courses.page(params[:page])
      end
  end


  ##Branch specific discussion
  def show_discussion
      college_id = params[:id]
      @college = College.find_by_id(college_id)

      if current_user.college_branch_enrolled?
        @branch = current_user.branch
      else
        branches = @college.branches.order(:created_at)
        @branches_name_id = branches.map{|branch| [branch.name , branch.id] }
        branch_id = params[:branch_id]
        @branch = Branch.find_by_id(branch_id)
      end

      if @branch
        @message = "College-Branch specific Comments"
        @comments = @college.comments_by_branch(@branch.id).order(:created_at).page(params[:page])
        #comment responses will have also to be shown
      else
        # We dont have college specific discussion forum yet
        render_404
      end
  end



  #BEFORE FILTER methods
  private

  def college_exists
      college_exists = College.exists?(params[:id])
      if not college_exists
        render_404
        return false
      else
        return true
      end
  end

  def branch_passed
      branch_id = params[:branch_id]

      if branch_id.nil?
        render_404
        return false
      else
        return true
      end
  end

  def branch_exists_if_passed
      branch_id = params[:branch_id]
      return true if branch_id.nil?
      branch_exists = Branch.exists?(branch_id)
      if not branch_exists
        render_404
        return false
      else
        return true
      end

  end



end