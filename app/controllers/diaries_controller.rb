class DiariesController < ApplicationController

  before_action :logged_in?, only: [:show]
  before_action :set_diary, only:[:show, :edit, :update]

  def index
    @diaries = Diary.all
  end

  def new
    @diary = Diary.new
  end

  def show
  end

  def create
    @diary = Diary.new(diary_params)
    if @diary.save
      flash[:notice] = "Diary '#{@diary.title}' is created successfully"
      redirect_to(diary_path)
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
    user = User.find_by(email: params[:session][:email])
    diary = user&.diary
    diary.destroy if user == current_user
    redirect_to(diaries_path)
  end

  private

  def set_diary
    @diary = Diary.find(params[:id])
  end

  def diary_params
    params.require(:diary).permit(:title, :article, :date)
  end

end