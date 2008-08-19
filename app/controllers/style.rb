class MerbInterface::Style < MerbInterface::Application

  only_provides :css

  def index
    if mi_browser == 'gecko'
      @gecko = selector('*::-moz-focus-inner') do
        property('border', :value => 'none')
        property('padding', :value => 0)
      end
    elsif mi_browser == 'msie'
      @msie = selector('.mi_button, .mi_tab') do
        property('overflow', :value => 'visible')
        property('width', :value => 'auto')
      end
    end
    render
  end
  
end