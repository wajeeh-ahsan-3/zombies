Here are the few steps start the application 

1) Ruby version(2.7.1)
2) Project Setup => Just run `bundle install`
3) Create Database
4) Migrate Database
5) Database Population => rails db:seed
6) Server Instantiation
  `Please run yarn install --check-files to update.`
  Now run `rails s`
7) Usage
  Api calls file added in the project `/vendor/zombie.postman_collection.json` folder in json format you can use in postman 
  
  -> For Survivors
    POST `/api/v1/survivors` It will create the survivor 
    PUT `/api/v1/survivors/:id` It will update the location of survivor

  -> For Generate Report
    GET `/api/v1/reports` It will give you all the reports as in the requirment

  -> For Infection Reports
    POST `/api/v1/infection_reports` It will give you infected reports but reporter can't report twice and unable to report himself.

  -> For Trade Items
    POST `/api/v1/trades` For trade between trader and survivor 

