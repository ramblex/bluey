class UserImagesController < ApplicationController

  # This also shows the upload form
  def index
    @user_profile = current_user.user_profile
    @user_images = @user_profile.user_images
    @user_image = UserImage.new
  end

  def create
    @user_profile = current_user.user_profile
    @user_images = @user_profile.user_images
    @user_image = UserImage.new(params[:user_image])
    @user_image.user_profile_id = current_user.user_profile.id
    respond_to do |format|
      if @user_image.save
        format.html { redirect_to :back, :notice => 'Successfully uploaded picture' }
        format.js
      else
        format.html { render :action => 'index' }
        format.js
      end
    end
  end

  def destroy
    @user_image = UserImage.find(params[:id])
    @user_image.destroy

    redirect_to profile_edit_path, :notice => 'Successfully deleted picture'
  end

  def update_profile_picture
    @user_image = UserImage.find(params[:id])

    if @user_image.update_attributes(:is_profile_pic => true)
      redirect_to profile_edit_path, :notice => 'Updated profile picture'
    else
      redirect_to :back, :alert => 'Could not update profile picture. Please try again.'
    end
  end
end
