REMOTE="origin"
SOURCE_BRANCH="master"
PUBLISH_BRANCH="gh-pages"
DATE=Time.now.strftime("%Y/%m/%d %H:%M")
REMOTE_V="git@github.com:Kraiany/pisennyk.git"


desc "Create build directory and gh-pages branch."
task :setup do
  sh "[ -d build ] || git clone -b #{PUBLISH_BRANCH} #{REMOTE_V} build"
end

desc "compile and publish the site to Github"
task :publish => [:setup] do
  sh "git checkout #{SOURCE_BRANCH}"
  comment = %x{ git log -n 1 --no-merges --format=%s%b }.chomp.strip
  sh "bundle exec middleman build"
  sh "cd build && git add -A && git commit -m \"At #{DATE} #{comment}\" && git push #{REMOTE} #{PUBLISH_BRANCH}"
  sh "git push origin #{SOURCE_BRANCH}"
end

# namespace :tags do

#   desc "Prints list of all tags"
#   task :list do
#   end
# end
