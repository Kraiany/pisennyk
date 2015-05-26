# -*- coding: utf-8 -*-
require 'slim'
require 'translit'
Slim::Engine.disable_option_validator!
require 'pry'
set :encoding, 'utf-8'
set :index_file, 'index.html'
set :css_dir, 'assets/stylesheets'
set :js_dir, 'assets/javascripts'
set :images_dir, 'assets/images'
set :partials_dir, 'partials'
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

helpers do

  # Find all songs that have title.
  def titled
    sitemap
      .resources
      .find_all { |res| !res.data.title.nil? }
  end

  # Find songs that start with a given letter
  def starts_with(letter)
    titled.find_all { |art| transliterated(art.data.title[0]) == transliterated(letter) }
  end

  def alphabet
    ("а".."я").to_a + %w(і ґ є) - %w{ы э ё ъ}
  end

  # Find all articles that have tags.
  def tagged
    sitemap
      .resources
      .find_all { |res| !res.data.tags.nil? }
  end

  def tags
    tagged
      .map(&:data)
      .map(&:tags)
      .flatten
      .uniq
      .compact
  end

  def with_tag(tag)
    tagged
      .find_all {|res| res.data.tags.include? tag }
  end

  def tag_path(tag)
    "tags/#{transliterated(tag)}.html"
  end

  def transliterated(word)
    Translit.convert(word, :english)
      .downcase
      .gsub(/[^A-Za-z0-9]/i,'_')
  end


  def tag_cloud
    size_min, size_max = 1, 3

    articles = {}
    tags.each do |tag|
      articles[tag] = tagged.find_all {|res| res.data.tags.include? tag }
    end

    counts = articles.map do |tag, posts|
      [tag, posts.count]
    end

    min, max = counts.map(&:last).minmax

    weight = counts.map do |name, count|
      # logarithmic distribution
      weight = (max == min) ? 0 : (Math.log(count) - Math.log(min))/(Math.log(max) - Math.log(min))
      [name, weight]
    end

    weight.sort_by! { rand }

    weight.map do |tag|
      name, weight = tag
      size = size_min + ((size_max - size_min) * weight).to_f
      [name, size]
    end
  end

end


ready do
  tags.each do |tag|
    articles = with_tag(tag)
    proxy tag_path(tag), "tag.html", locals: { tag: tag, articles: articles}, :ignore => true
  end
end



# Build-specific configuration
configure :build do
  activate :relative_assets
  # activate :directory_indexes
  activate :sprockets
  activate :minify_css
  activate :minify_javascript
  set :relative_links, true
  activate :minify_html do |html|
    html.remove_multi_spaces        = true   # Remove multiple spaces
    html.remove_comments            = true   # Remove comments
    html.remove_intertag_spaces     = false  # Remove inter-tag spaces
    html.remove_quotes              = true   # Remove quotes
    html.simple_doctype             = false  # Use simple doctype
    html.remove_script_attributes   = false   # Remove script attributes
    html.remove_style_attributes    = false   # Remove style attributes
    html.remove_link_attributes     = false   # Remove link attributes
    html.remove_form_attributes     = false  # Remove form attributes
    html.remove_input_attributes    = false   # Remove input attributes
    html.remove_javascript_protocol = false   # Remove JS protocol
    html.remove_http_protocol       = false   # Remove HTTP protocol
    html.remove_https_protocol      = false  # Remove HTTPS protocol
    html.preserve_line_breaks       = false  # Preserve line breaks
    html.simple_boolean_attributes  = true   # Use simple boolean attributes
  end
  activate :asset_hash
  activate :gzip
  ignore '*.less'
  ignore(/Icon\r$/)
  ignore(/\.DS_Store/)
  ignore(/^assets\/stylesheets\/(?!all).*\.css/)
  ignore(/^assets\/javascripts\/(?!all).*\.js/)
end
