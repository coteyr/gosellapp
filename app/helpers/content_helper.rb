# @Author: Robert D. Cotey II <coteyr@coteyr.net>
# @Date:   2016-12-22 13:22:09
# @Last Modified by:   Robert D. Cotey II <coteyr@coteyr.net>
# @Last Modified time: 2016-12-22 14:13:09
module ContentHelper
  def row(&block)
    to_return = '<div class="row container-fluid">'
    to_return += with_output_buffer(&block)
    to_return += '</div>'
    to_return.html_safe
  end
  def panel(options={}, &block)
    size = options[:size] || 6
    offset = options[:offset] || 3
    to_return = '<div class="panel panel-default '
    to_return += "col-md-#{size} "
    to_return += "col-md-offset-#{offset}"
    to_return += '">'
    to_return += with_output_buffer(&block)
    to_return += '</div>'
    to_return.html_safe
  end
  def menu_button(title, url, options={})
    options.merge!(class: 'btn btn-default raised btn-block')
    to_return =  '<div class="panel center"><div class="row"><div class="col-xs-6 col-xs-offset-3">'
    to_return += link_to title, url, options
    to_return += '</div></div></div>'
    to_return.html_safe
  end
  def menu_panel(id, &block)
    to_return = '<div id="'
    to_return += id
    to_return += '" class="panel-collapse collapse"><div class="panel-body"><div class="row center">'
    to_return += with_output_buffer(&block)
    to_return += '</div></div></div>'
    to_return.html_safe
  end
  def menu_toggle(title, id, &block)
    to_return = menu_button title, "##{id}", data: {toggle: 'collapse', parent: '#accordion'}, role: 'button'
    to_return += menu_panel id, &block
    to_return.html_safe
  end
end
