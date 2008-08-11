class MerbInterface::Style < MerbInterface::Application

  only_provides :css

  def index
    if mi_browser == 'gecko'
      @gecko = selector('*::-moz-focus-inner') do
        property('border', :value => 'none')
        property('padding', :value => 0)
      end
      # Remove the following after FireFox supports border-radius officially
      @gecko << selector('button.mi, input[type=button].mi, input[type=reset].mi, input[type=submit].mi') do
        border_radius_gecko
      end
      @gecko << selector('div.mi_tray_outer') do
        border_radius_gecko
      end
      @gecko << selector('div.mi_tray_outer div.mi_bar') do
        border_radius_gecko(:edge => 'top')
      end
    elsif mi_browser == 'msie'
      @msie = selector('button.mi, input[type=button].mi, input[type=reset].mi, input[type=submit].mi') do
        property('overflow', :value => 'visible')
        property('width', :value => 'auto')
      end
    elsif mi_browser == 'webkit'
      # Remove the following after Safari supports border-radius officially
      @webkit = selector('button.mi, input[type=button].mi, input[type=reset].mi, input[type=submit].mi') do
        border_radius_webkit
      end
      @webkit << selector('div.mi_tray_outer') do
        border_radius_webkit
      end
      @webkit << selector('div.mi_tray_outer div.mi_bar') do
        border_radius_webkit(:edge => 'top')
      end
    end
    render
  end
  
end