# README

Heroku:
https://railstasksystem.herokuapp.com/

* 部署步驟：
1. 在專案目錄下新增 Procfile
加入底下內容:
- web: bundle exec rails server -p $PORT
- webpack: bin/webpack-dev-server

2. git push heroku master
3. heroku run rake db:migrate
4. heroku open
5. heroku logs --tail 查詢log
6. 其他指令 https://gizipp.com/reset-heroku-pg-database


Frontend:
* Bootstrap

Backend:
* Rails

Database:
* PostgreSQL

Gems:
* rails-i18n
* rspec-rails
* factory_bot_rails
* faker
* shoulda-matchers
* rails-controller-testing



