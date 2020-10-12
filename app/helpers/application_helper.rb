module ApplicationHelper
  # Возвращает полный заголовок на основе заголовка страницы
  def full_title(page_title = '')
    base_title = 'Ruby on Rails Tutorial Sample App'
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def icon_label(classes, text = '')
    "<i class='#{ classes }'></i> #{ text }".html_safe
  end

  def page_header(text = nil, subtext = nil)
    "<div class='page-header'> <h3> #{ text ? text : t('.header') } #{ subtext ? ('<small>' + subtext + '</small>') : ''} </h3> </div>".html_safe
  end

  def no_results(text = nil)
    "<div class='no-results well'> <h3> #{ text ? text : t('.no_results') } </h3> </div>".html_safe
  end

  def subheader(text)
    "<div class='page-header'> <h3> <small> #{ text } </small> </h3> </div>".html_safe
  end

  def heads_up! text
    "<div class='heads-up'> <strong> #{ t('common.heads_up!') } </strong> #{ text } </div>".html_safe
  end

  def inline_heads_up! text
    "<span class='inline-heads-up'> <span class='label label-info'> #{ t('common.heads_up!') } </span> <strong> #{ text } </span>".html_safe
  end
end
