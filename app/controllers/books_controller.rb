class BooksController < ApplicationController
  before_action :move_to_login

  def index
    @book = Book.new
    @books = Book.all
    @user = User.find(current_user.id)
  end

  def show
    @book = Book.new
    @books = Book.find(params[:id])
    @user = @books.user
  end

  def create
    @user = User.find(current_user.id)
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:success] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:success] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      redirect_to books_path
    else
      render :show
    end
  end

  private

    def move_to_login
      unless user_signed_in?
        redirect_to new_user_session_path
      end
    end

   def book_params
    params.require(:book).permit(:title, :body)
   end

end
