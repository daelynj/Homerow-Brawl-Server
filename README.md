# Homerow Brawl Server

The Homerow Brawl Server is a Ruby web server built with [Iodine](https://github.com/boazsegev/iodine).

This server supports the [Homerow Brawl Client](https://github.com/daelynj/Homerow-Brawl-Client).

By default, Hanami does not support websockets; for websocket support you have to look elsewhere. Fortunately [Iodine](https://github.com/boazsegev/iodine) is a Rack server that provides websocket and pub/sub support.

To utilize this functionality in Hanami you are required to write your own Rack middleware that routes incoming websocket requests to some application you have written to handle websocket traffic. You can't find anything like this on the internet so I will provide a guide for achieving this in the future.

Authentication for persistent user accounts are through Slack OAuth and maintined here in a postgresql database.

Some noteable features:
- websockets
- Slack authentication
- Persistent `Player` entities with game stats
- pub/sub support
- Game rooms

The idea for this application is to provide a typing competition between geographically separate offices in an organization. By integrating with Slack through OAuth with a Slack application, your workspace can compete in typing races against each other in different rooms and groups at any time.

## Setup

How to run tests:

```
% bundle exec rake
```

How to run the development console:

```
% bundle exec hanami console
```

How to run the development server:

```
% bundle exec hanami server
```

How to prepare (create and migrate) DB for `development` and `test` environments:

```
% bundle exec hanami db prepare

% HANAMI_ENV=test bundle exec hanami db prepare
```
To generate secrets: `bundle exec hanami generate secret <app_name>`
