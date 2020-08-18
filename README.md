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

There is a file called `.envrc` in the root directory of this project with all the environment variables set to empty value. You can set the correct values as per the following options:

    export GITLAB_KEY=your-key
    export GITLAB_SECRET=your-secret

    export GITHUB_ACCESS_TOKEN=your-token

    export RAILS_ENV=development
    export PORT=3000
    

**Test on LocalHost**

Make sure your are in the root directory and start the web server:

  ` $ bin/rails server`

Run with `—help` or `-h` for options.

**Ps:** you'll need to make your `url` public inorder for Gitlab OAuth to work. Try using `ngrok` or some other service to test locally.

 Go to http://localhost:3000 and Play around!