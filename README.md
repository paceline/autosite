# autosite

## Introduction
Autosite is a simple framework/tool for running a personal website with largely auto-generate content (hence the name). This is a quick rewrite of the outdated GO version since it seemed like less work than upgrading the original GO version to the new SDK and Google APIs.

## Install

* Clone repository: `git clone https://github.com/paceline/autosite.git`
* Run bundler to install missing gems: `bundle`
* Run Rails app: `rails s`
* Open http://localhost:3000/manage in your browser to get started

## TODOs

Lots of stuff is still missing, this is really a minimal set of the original:

* Javascripts in management section somewhat buggy on page reloads
* Remove all updates, e.g. over x days old
* Add more status update providers (e.g. Instagram, LinkedIn)
* Documentation
* Specs and tests

## Credits
Created by Ulf Möhring <ulf@moehring.me>
