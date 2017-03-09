# Staffjoy on Rails


## Goal

Over the weekend, I tried to run the original code for [Staffjoy](https://github.com/Neil-Ni/v2) locally, but it was taking too long to run vagrant and too heavy to iterate with modifications. This repo is an attempt to simplify the original code into rails api.


###To run with json server:

```
cd client && npm instal

cd json-server && sh start.sh

npm start

```


###To run with rails:

```

# make sure postgres is runnning and modify your config in config/database.yml
bundle install && rails db:create && rails db:reset
cd client && npm install && npm start


```
