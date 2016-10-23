class SessionsController < ApplicationController
skip_before_action :require_login, only: [:login, :create, :welcome]

  def welcome
    # if the user is already logged in and tres to go to the root path, redirect them to tasks homepage. 
    if session[:user_id]
      redirect_to tasks_path
    end
  end

  def create
    auth_hash = request.env['omniauth.auth']
    redirect to login_failure_path unless auth_hash['uid']

    @user = User.find_by(uid: auth_hash[:uid], provider: 'github')
    if @user.nil?
      # User doesn't match anything in the DB.
      # Attempt to create a new user.
      @user = User.build_from_github(auth_hash)
      render :creation_failure unless @user.save
    end

    # Save the user ID in the session
    session[:user_id] = @user.id

    # Was trying to use the session to save the return_to, but when I wasn't logged into github yet, I was being sent to github after logging in, not the tasks page that I had clicked "log in" from.
    redirect_to tasks_path
  end

  def destroy
    session.delete(:user_id)
    session[:return_to] ||= request.referer
    redirect_to session.delete(:return_to)
  end
end
