module UsersDoc
  extend BaseDoc
  resource :users

  doc_for :sign_up do
    api :POST, '/users/sign_up', 'Create user'
    param :user, Hash, required: true do
      param :email, String, required: true
      param :name, String
      param :password, String, required: true
      param :password_confirmation, String, required: true
    end
    error code: 422, desc: 'Unprocessable entity'
  end

  doc_for :show do
    api :GET, '/user', 'Get authenticated user'
    error code: 401, desc: 'Unauthorized'
  end

  doc_for :update do
    api :PUT, '/user', 'Update authenticated user'
    param :user, Hash, required: true do
      param :email, String
      param :name, String
      param :password, String
      param :password_confirmation, String
    end
    error code: 401, desc: 'Unauthorized'
    error code: 422, desc: 'Unprocessable entity'
  end
end
