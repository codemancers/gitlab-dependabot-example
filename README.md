# Gitlab Dependabot Example
Rails app that simply shows your Gitlab Repositories and later on adds dependabot service to them.

heroku: https://gitlab-dependabot-example.herokuapp.com/

### Getting Started
**Installing Ruby**

We’re going to use  [rbenv](https://github.com/sstephenson/rbenv)  to install and manage our Ruby versions.
1. Run the following commands in your Terminal:
    ```
    $ brew install rbenv ruby-build
    ```
2. Set up rbenv in your shell.
    ```
    $ rbenv init
    ```
3. Install Ruby
    ```
    $ rbenv install 2.7.1
    $ rbenv global 2.7.1
    $ ruby -v
    ```

**Installing Rails**
1. Install Rails
      ```
      $ gem install rails -v 6.0.2.1
      ```
2. Rails is now installed, but in order for us to use the rails executable, we need to tell rbenv to see it:
      ```
      $ rbenv rehash
      ```
3. verify Rails is installed:
      ```
      $ rails -v
      ```

**Installing Yarn**
1. Install Yarn
      ```
      $ brew install yarn
      ```

**Installing dependencies**
1. Change directory to *`cammondra-work/`*  and Run:
    ```
    # Install gem dependencies
    $ bundle
    # Install Js dependencies
    $ yarn
    ```
**Environment variables**

To generate your GITLAB_KEY and GITLAB_SECRET sign in to your gitlab and go to 'User Settings > Applications' 
 -provide a suitable name
 -redirect URI = https://<your_hostname>/auth/gitlab/callback
 -check all the necessary access
 -click on 'Save Application'

 Doing this will generate your application ID and SECRET which will be your KEY and SECRET respectively.

 To generate your GITLAB_ACCESS_TOKEN sign in to your gitlab and go to 'User Settings > Access Tokens' 
 -provide a suitable name
 -keep the date section blank if you want to use the toke indefinitely
 -check all the necessary access
 -click on 'Create Personal Access Token'

 Doing this will generate your Access Token.


There is a file called `.env` in the root directory of this project with all the environment variables set to empty value. You can set the correct values as per the following options:

    GITLAB_KEY=your-key
    GITLAB_SECRET=your-secret

    GITLAB_ACCESS_TOKEN=your-token

    RAILS_ENV=development
    PORT=3000
    

**Test on LocalHost**

Make sure your are in the root directory and start the web server:

  ` $ bin/rails server`

Run with `—help` or `-h` for options.

**Ps:** you'll need to make your `url` public inorder for Gitlab OAuth to work. Try using `ngrok` or some other service to test locally.
Make sure 'merge requests' in gitlab repository settings is enabled.
 Go to http://localhost:3000 and Play around!

 For Docker:
 $ docker-compose build
 $ docker-compose run web bash
 *it will bash in the container*
 # rake db:create
 # rake db:migrate
 # exit
 $ docker-compose up