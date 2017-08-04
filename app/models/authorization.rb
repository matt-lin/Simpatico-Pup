class Authorization < ActiveAdmin::AuthorizationAdapter

    def authorized?(action, subject = nil)
      case subject
      when normalize(Post)
        # Only let the author update and delete posts
        if action == :update || action == :destroy || action == :edit || action == :view
          subject.author == user
        else
          true
        end
      else
        true
      end
    end
    
end