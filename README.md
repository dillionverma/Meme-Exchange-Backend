
![Meme Exchange](https://github.com/dillionverma/Meme-Exchange-Frontend/blob/master/public/img/home.png)

# [Meme Exchange](https://meme.exchange)

## About
The Meme Exchange is an online web :computer: and mobile :iphone: platform which allows users to buy and sell memes for a profit :moneybag:.

Checkout the [frontend repo](https://github.com/dillionverma/Meme-Exchange-Frontend) for more information.

## Design decisions
 - The database schema and all related associations can be found [here](https://github.com/dillionverma/Meme-Exchange-Backend/blob/master/db/schema.rb)
 - The overall architecture follows the standard Ruby on Rails MVC pattern. The controller were kept slim and the models contain all the business logic.
 - There are cron jobs which track the prices of memes based off of the number of upvotes on Reddit.
 - This is an API-only repo and all the API/v1 endpoints can be found in the [controllers](https://github.com/dillionverma/Meme-Exchange-Backend/tree/master/app/controllers/api/v1) folder
