ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html = html_tag
  form_fields = ['textarea', 'input', 'select']
  elements = Nokogiri::HTML::DocumentFragment.parse(html_tag).css(form_fields.join(', '))
  elements.each do |e|
    if form_fields.include? e.node_name
      if instance.error_message.kind_of?(Array)
        html = %(#{html_tag}<div class="invalid-feedback">#{instance.error_message.first}</div>).html_safe
      else
        html = %(#{html_tag}<div class="invalid-feedback">#{instance.error_message}</div>).html_safe
      end
    end
  end
  html
end
