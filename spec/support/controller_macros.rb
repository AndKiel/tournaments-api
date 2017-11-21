module ControllerMacros
  # Anonymous controller actions

  def define_anonymous_action(kontroller = 'anonymous', &action)
    controller do
      define_method :anon, action
    end

    before do
      routes.draw do
        get "/#{kontroller}/anon"
      end
    end
  end

  # Doorkeeper

  # def authenticate(user_sym)
  #   let(:current_resource_owner) { users(user_sym) }
  #   let(:token) do
  #     double acceptable?: true,
  #            resource_owner_id: current_resource_owner.id,
  #            scopes: ['public']
  #   end
  #
  #   before do
  #     allow(controller).to receive(:doorkeeper_token) { token }
  #   end
  # end
end
