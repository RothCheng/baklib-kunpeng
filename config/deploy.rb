lock '3.4.0'

projects = {
  'baklib-kunpeng' => { path: '/data/www/baklib-kunpeng', templates: %w(baklib-kunpeng) },
}

project_name = ENV['PN']
project = projects[project_name] || fail('请输入PN项目名, 如：PN=tanmer bundle exec cap production deploy')
project_path = project[:path]
# project_templates = project[:templates] + ['default']

set :application, project_name
set :repo_url, 'git@github.com:RothCheng/baklib-kunpeng.git'

set :branch, 'master'
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, project_path

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml', 'config/application.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/ckeditor_assets')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 3
set :rvm_type, :system
set :rvm_ruby_version, 'ruby-2.5.1'

# namespace :bundler do
#   before :install, :delete_dot_ruby_gemset do
#     on roles(:all) do
#       within release_path do
#         execute :rm, '.ruby-gemset'
#         execute :rm, '.ruby-version'
#       end
#     end
#   end
# end

# namespace :deploy do
#   before :updated, :delete_other_tempaltes do
#     on roles(:all) do
#       # 删除其它项目文件
#       within File.join(release_path, 'public/templetes') do
#         execute :ls, "-d */|grep -v -E '#{project_templates.join('|')}'|xargs rm -rf"
#       end
#     end
#   end
# end

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
