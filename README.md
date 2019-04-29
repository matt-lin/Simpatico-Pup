[![Build Status](https://travis-ci.org/matt-lin/Simpatico-Pup.svg?branch=master)](https://travis-ci.org/matt-lin/Simpatico-Pup) 
[![Code Climate](https://codeclimate.com/github/matt-lin/Simpatico-Pup/badges/gpa.svg)](https://codeclimate.com/github/matt-lin/Simpatico-Pup) 
[![Test Coverage](https://codeclimate.com/github/matt-lin/Simpatico-Pup/badges/coverage.svg)](https://codeclimate.com/github/matt-lin/Simpatico-Pup/coverage)


===================Team Info============================

Pivotal Tracker
https://www.pivotaltracker.com/n/projects/2068531

Heroku
https://simpatico-pup-19.herokuapp.com/

Customer's website
http://www.simpaticopup.com/

<br/>####How the app addresses customer's need<br/>
<br/>SimpaticoPup is a website that collect crowd sourced data about the health, 
temperament and suitability of pet dogs of various breeds, and from various 
sources (dog breeders). This site can reduce and discourage irresponsible dog 
breeding (by giving dog lovers a clear and superior way to identify responsibly 
raised, healthy puppies) and can even ultimately improve the health and 
temperament of the pet dogs being produced.


<br/>####Dependencies - 
  1. [rvm](https://rvm.io)
  2. Ruby: 2.2.2
  3. ImageMagick

###Setup
<br/>After cloning run bundle install --without production
<br/>Run rake db:setup to set up environment
<br/>If using a slow environment(e.g. Cloud9), run rake cucumber might fail on features that involve Javascript, especially edit_pup.feature and admin_upload.feature(these files involve heavy Javscript)
<br/>Travis CI should always be passing
<br/>If failed, try either re-run or only run individuals feature files, all the features files should be passing
<br/>Heroku site need to run rake db:migrate and rake db:seed
<br/>ImageMagick must be installed in order to support profile image resizing


####Current Contributors
<br/>*Eric Kong, Emiko Tsutsumi, Matthew Lin, Noah Poole, Raymond Gu, Shuyin Xu*

####Past Contributors
<br/>*Jeff Yu, Gilbert Lo, Licong Wang, Jack Chen, Alex Ho, Zipei Wang*



