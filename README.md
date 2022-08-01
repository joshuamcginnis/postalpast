# PostalPast.com

![Waltham Watch Company - Front](http://i.imgur.com/732ayPWm.jpg)![Waltham Watch Company - Back](http://i.imgur.com/1EIJuram.jpg)

[PostalPast.com](https://postalpast.com) is a repository of postcards from the early 20th century collected by me ([@joshuamcginnis](https://github.com/joshuamcginnis)) over the years.

Most postcards have a connection to [Waltham, Massachusetts, USA](https://en.wikipedia.org/wiki/Waltham,_Massachusetts) which is often referred to as *The Birthplace of the Industrial Revolution*. <sup>Citation Needed</sup>

The website was primarily created as a way for me to track which postcards I already own so that I can easily search through my collection when looking for new postcards to collect.

In addition, my hope is that this projects affords me the ability to learn and implement:

* A fully-tested and production-ready app to add to my portfolio
* Server-side image processing using ImageMagick
* Performance optimization techniques (caching, redis, etc)
* Data Analysis and Charting of postcard metadata using R
* Interactive UI / UX using modern javascript

Nothing would please me more than if local historians, other postcard collectors or the general public find the information useful and interesting.

* Homepage: [https://postalpast.com/](https://postalpast.com/)
* Source: [https://github.com/joshuamcginnis/postalpast](https://github.com/joshuamcginnis/postalpast)
* LinkedIn: [@joshuamc](https://linkedin.com/in/joshuamcginnis)

## Project Setup

Get started by first installing all require dependencies.

1. [Install rvm](https://rvm.io/rvm/install) to manage ruby versions.
2. Use rvm to install ruby using the version stated at the top of the [Gemfile](https://github.com/joshuamcginnis/postalpast/blob/master/Gemfile) (e.g. `rvm install 2.3.2`)
4. Using `homebrew` or your favorite package manager:
	* `brew install postgres redis`
3. Install bundler: `gem install bundler`
4. Run bundle install: `bundle install`
6. Prepare the database:
	* `rake db:setup`
	* `RAILS_ENV=test rake db:setup` #for test db
7. Start the server! `rails s`
8. Visit: http://localhost:3000

