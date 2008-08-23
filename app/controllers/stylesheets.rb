class MerbInterface::Stylesheets < MerbInterface::Application

  only_provides :css

  def interface
    if gecko?
      @gecko = selector('*::-moz-focus-inner') do
        property('border', :value => 'none')
        property('padding', :value => 0)
      end
    elsif msie?
      @msie = selector('.mi_button, .mi_tab') do
        property('overflow', :value => 'visible')
        property('width', :value => 'auto')
      end
    end
    render
  end
  
end