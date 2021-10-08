class DiariesController < ApplicationController

  before_action :login_redirect, only:[:index, :new, :create]
  before_action :set_diary, :auth_user, only:[:show, :edit, :update, :destroy]

  def index
    @diaries = current_user.diaries.order(:date)
  end

  def new
    @diary = current_user.diaries.build
  end

  def show
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
    @diary.destroy
    redirect_to(diaries_path)
  end

  private

  def diary_params
    params.require(:diary).permit(:title, :article, :date, :user_id)
  end

  def login_redirect
    redirect_to(login_path) if current_user.nil?
  end

  def set_diary
    @diary = Diary.find(params[:id])
  end

  def auth_user
    if current_user
      diary = Diary.find(params[:id])
      unless diary.user_id.to_s == current_user.id.to_s
        flash[:alert] = "You can only access your own diary"
        redirect_to(diaries_path)
      end
    else
      redirect_to(login_path)
    end
  end

end