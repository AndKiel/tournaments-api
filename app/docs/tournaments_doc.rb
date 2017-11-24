module TournamentsDoc
  extend BaseDoc
  resource :tournaments

  doc_for :index do
    api :GET, '/tournaments', 'Get tournaments'
  end

  doc_for :show do
    api :GET, '/tournaments/:id', 'Get tournament'
    error code: 404, desc: 'Not found'
  end

  doc_for :create do
    api :POST, '/tournaments', 'Create tournament'
    param :tournament, Hash, required: true do
      param :competitors_limit, Integer, required: true
      param :description, String
      param :name, String, required: true
      param :result_names, Array, required: true
      param :starts_at, DateTime, required: true
    end
    error code: 401, desc: 'Unauthorized'
    error code: 422, desc: 'Unprocessable entity'
  end

  doc_for :update do
    api :PUT, '/tournaments/:id', 'Update tournament'
    param :tournament, Hash, required: true do
      param :competitors_limit, Integer
      param :description, String
      param :name, String
      param :result_names, Array
      param :starts_at, DateTime
    end
    error code: 401, desc: 'Unauthorized'
    error code: 422, desc: 'Unprocessable entity'
  end

  doc_for :destroy do
    api :DELETE, '/tournaments/:id', 'Delete tournament'
    error code: 401, desc: 'Unauthorized'
    error code: 403, desc: 'Forbidden'
  end
end
