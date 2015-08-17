Laravel on OpsWorks
===================

This repository contains recipes to provision and deploy OpsWorks stacks with Laravel 5+.

You'll need to create an OpsWorks stack that uses Ubuntu 14.04 LTS, as the recipes in this repository are designed to work with that OS.

## Stack configuration

When creating a stack, indicate that you want to use custom Chef cookbooks, with a repository type of Git and a repository URL of `https://github.com/dwightwatson/laravel-opsworks` (or your own repository URL if you decide to fork this one). You will not need an SSH key if the repository is public (like this one). The other settings for the stack you may set as you please.

## PHP App Server layer configuration

You'll need to add the following recipes to the PHP App Server layer so that it can operate a Laravel installation.

### Setup

In the setup stage, add the `php::mcrypt_enable` recipe. This will enable the PHP Mcrypt extension which is required by Laravel.

## Deploy

In the deploy stage, add the following recipes.

* `laravel::environment_variables`
This recipe will populate your `.env` file with the database configuration of your OpsWorks data store (whether it be a database instance or RDS instance). It will also take the custom environment variables from your app configuration and place them into your `.env` file.

* `laravel::symlink_storage`
This will move the `storage` directory into a shared directory so that it can be used by each release of your app. For example, if you're storing cache/sessions or other application data in the storage folder it can be used by the next release after a deployment (so it won't force your users to re-authenticate or the app to re-build the cache).

* `composer::install`
This will install Composer and then the dependencies of your application for the given release, without the development dependencies.

## App configuration

Select the correct data source type for your application (whether it be RDS or OpsWorks) as the credentials for that database will be passed into your application's environment. You can also add additional application environment variables, for example your `APP_KEY`.

```bash
opsworks-agent-cli get_json
```