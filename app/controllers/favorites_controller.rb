class FavoritesController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.build(post_id: post)
    authorize favorite
 
    if favorite.save
      flash[:notice] = "Post was favorited."
      redirect_to [post.topic, post]
      # Remember the path shortcut: [post.topic, post]
    else
      # Add code to generate a failure flash and redirect to post
      flash[:notice] = "There was an error favoriting the post."
      redirect_to [post.topic, post]
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = Favorite.find(params[post])
    authorize favorite

    if favorite.destroy
      #flash success and redirect to post
      flash[:notice] = "Favorite was removed."
      redirect_to [post.topic, post]
    else
      #flash error and redirect to post
      flash[:notice] = "There was an error removing the favorite."
      redirect_to [post.topic, post]
    end
  end
end