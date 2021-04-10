module ApplicationHelper
  def devise_error_messages
    return '' if resource.errors.empty?

    html = ''

    resource.errors.full_messages.each do |msg|
      html += <<-EOF
        <div class= "error_field alert alert-danger" role="alert">
          <p class= "error_msg">#{msg}</p>
        </div>
      EOF
    end
    html.html_safe
  end

  def reset_tag(value = 'Reset form', options = {})
    options = options.stringify_keys
    tag :input, { type: 'reset', value: value }.update(options)
  end
end
