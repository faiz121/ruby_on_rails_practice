class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :destroy, :show]
  
  def index
    @articles = Article.all
  end
  
  def new
    @article = Article.new #This article variable is what is available in view
  end
  
  def edit
  end
  
  def create
    # render plain: params[:article].inspect #This is just to print on browser the values being submitted
    @article = Article.new(article_params)  #this is how we create an instance of article and send values entered by user
    if @article.save
      flash[:notice] = "Article was successfully created" #this will be applied in application.html.erb
      redirect_to article_path(@article)
    else 
      render "new" #If article was not saved because of errors, render new_article view again
    end
  end
  
  def update
    if @article.update(article_params)
      flash[:notice] = "Article was successfully updated"
      redirect_to article_path(@article)
    else 
      render 'edit'
    end
  end
  
  def show
  end
  
  def destroy
    @article.destroy
    flash[:notice] = "Article was successfully destroyed"
    redirect_to articles_path
  end
  
  private
    def set_article
      @article = Article.find(params[:id])
    end
    
    def article_params
      params.require(:article).permit(:title, :description) #we take title and description from the params with article hash.
    end
end