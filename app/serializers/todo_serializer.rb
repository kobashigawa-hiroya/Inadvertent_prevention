class TodoSerializer < ActiveModel::Serializer
  attributes :id, :body, :done
end
