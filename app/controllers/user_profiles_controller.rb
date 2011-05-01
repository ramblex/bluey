class UserProfilesController < ApplicationController

  before_filter :authenticate_user!, :except => [:update_attribute_on_the_spot]

  can_edit_on_the_spot

  # GET /user_profiles/1
  # GET /user_profiles/1.xml
  def show
    @user_profile = UserProfile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user_profile }
    end
  end

  # GET /user_profiles/1/edit
  def edit
    @user_profile = UserProfile.find(current_user.id)
    @user_profile_picture = @user_profile.user_images.find(:first, :conditions => {:is_profile_picture => true})
    @user_profile_picture ||= UserImage.new(:picture_file_name => 'default-user.png');
  end

  # POST /user_profiles
  # POST /user_profiles.xml
  def create
    @user_profile = UserProfile.new(params[:user_profile])

    respond_to do |format|
      if @user_profile.save
        format.html { redirect_to(@user_profile, :notice => 'User profile was successfully created.') }
        format.xml  { render :xml => @user_profile, :status => :created, :location => @user_profile }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user_profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /user_profiles/1
  # PUT /user_profiles/1.xml
  def update
    @user_profile = UserProfile.find(current_user)

    respond_to do |format|
      if @user_profile.update_attributes(params[:user_profile])
        format.html { redirect_to(profile_edit_path, :notice => 'User profile was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /user_profiles/1
  # DELETE /user_profiles/1.xml
  def destroy
    @user_profile = UserProfile.find(params[:id])
    @user_profile.destroy

    respond_to do |format|
      format.html { redirect_to(user_profiles_url) }
      format.xml  { head :ok }
    end
  end
end
