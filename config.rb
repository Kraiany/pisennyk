# -*- coding: utf-8 -*-
require 'slim'
Slim::Engine.disable_option_validator!
require 'pry'
set :encoding, 'utf-8'
set :index_file, 'index.html'
set :css_dir, 'assets/stylesheets'
set :js_dir, 'assets/javascripts'
set :images_dir, 'assets/images'
set :partials_dir, 'partials'
###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (https://middlemanapp.com/advanced/dynamic_pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# helpers do
#   def tag_cloud
#     size_min, size_max = 12.0, 30.0

#     articles = sitemap.resources.find_all { |res| !res.data.tags.empty? }

#     # counts = articles.map(&:tags) do |tag, posts|
#     #   [tag, posts.count]
#     # end

#     # min, max = counts.map(&:last).minmax

#     # weight = counts.map do |name, count|
#     #   # logarithmic distribution
#     #   weight = (Math.log(count) - Math.log(min))/(Math.log(max) - Math.log(min))
#     #   [name, weight]
#     # end

#     # weight.sort_by! { rand }

#     # weight.map do |tag|
#     #   name, weight = tag
#     #   size = size_min + ((size_max - size_min) * weight).to_f
#     #   [name, size]
#     # end
#   end

# end

activate :blog do |blog|
  blog.tag_template = "tag.html"
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
