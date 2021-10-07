class DiariesController < ApplicationController

  before_action :logged_in?, only: [:new, :show, :edit]
  before_action :set_diary, only:[:show, :edit, :update, :destroy]
  before_action :auth_user, only: [:show]

  def index
    @diaries = Diary.all
  end

  def new
    @diary = current_user.diaries.build
  end

  def show
    @user = User.find(@diary.user_id)
  end

  def create
    @diary = current_user.diaries.build(diary_params)
    if @diary.save
      flash[:notice] = "Diary '#{@diary.title}' is created successfully"
      redirect_to(diary_path(@diary))
    else
      flash.now[:alert] = "Diary is not saved"
      render('new')
    end
  end

  def edit
  end

  def update
    if @diary.update(diary_params)
      flash[:notice] = "Diary '#{@diary.title}' is updated successfully"
      redirect_to(diary_path)
    else
      flash.now[:alert] = "Diary is not updated"
      render('edit')
    end
  end

  def destroy
    user = User.find(@diary.user_id)
    if user == current_user
      @diary.destroy
      redirect_to(diaries_path)
    else
      flash.now[:alert] = "You can only delete your own diary"
    end
  end

  private

  def set_diary
    @diary = Diary.find(params[:id])
  end

  def diary_params
    params.require(:diary).permit(:title, :article, :date, :user_id)
  end

  def auth_user
    if current_user
      diary = Diary.find(params[:id])
      user = User.find(diary.user_id)
      unless user.id.to_s == current_user.id.to_s
        flash[:alert] = "You can only access your own diary"
        redirect_to(diaries_path)
      end
    else
      redirect_to(login_path)
    end
  end

end