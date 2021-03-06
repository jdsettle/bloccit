require 'rails_helper'
 
 describe Comment do
 
  include TestFactories
 
  describe "after_create" do
 
    before do
      @post = associated_post
      @user = authenticated_user
      @other_user = authenticated_user
      @comment = Comment.new(body: 'My comment is really great', post: @post, user_id: @other_user)
    end

    # We don't need to change anything for this condition;
    # The email_favorites atribute defaults to true
    context "with user's permission" do
 
      it "sends an email to users who have favorited the post" do
        @user.favorites.where(post_id: @post).create
 
        allow( FavoriteMailer )
          .to receive(:new_comment)
          .with(@user, @post, @comment)
          .and_return( double(deliver_now: true) )

          expect( FavoriteMailer )
            .to receive(:new_comment)
 
        @comment.save
      end
 
      it "does not send emails to users who haven't" do
        expect( FavoriteMailer )
          .not_to receive(:new_comment)
 
        @comment.save
      end
    end

    context "without permission" do

      before { @user.update_attribute(:email_favorites, false) }

      it "does not send emails, even to users who have favorited" do
        @user.favorites.where(post_id: @post).create

        expect( FavoriteMailer )
         .not_to receive(:new_comment)

        @comment.save
      end
    end
  end
end