class UserProfilesController < ApplicationController
  before_filter :authenticate_user!
  can_edit_on_the_spot

  def show
    @user_profile = UserProfile.find(params[:id])
  end

  def edit
    @user_profile = current_user.user_profile
    @user_profile_picture = @user_profile.user_images.find(:first, :conditions => {:is_profile_picture => true})
    @user_profile_picture ||= UserImage.new(:picture_file_name => 'default-user.png');
  end

  def create
    @user_profile = UserProfile.new(params[:user_profile])

    if @user_profile.save
      redirect_to(@user_profile, :notice => 'User profile was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @user_profile = current_user.user_profile

    if @user_profile.update_attributes(params[:user_profile])
      redirect_to(profile_edit_path, :notice => 'User profile was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /user_profiles/1
  # DELETE /user_profiles/1.xml
  def destroy
    @user_profile = UserProfile.find(params[:id])
    @user_profile.destroy

    format.html { redirect_to(user_profiles_url) }
  end
end
