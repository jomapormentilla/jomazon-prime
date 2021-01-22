class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :commenter, class_name: "User"
end
