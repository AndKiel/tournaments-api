module ControllerMacros
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
end
