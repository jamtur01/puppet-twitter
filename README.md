puppet-twitter
==============

Description
-----------

A Puppet report handler for sending notifications of failed runs to
Twitter.

Requirements
------------

* `oauth`
* `twitter`
* `puppet`

Installation & Usage
--------------------

1.  Install the `oauth` and `twitter` gems on your Puppet master

        $ sudo gem install oauth twitter

2.  Create a new Twitter app [here](http://twitter.com/apps/new). For
    `Application Type` specify `Client` and for `Default Access Type`
    specify `Read & Write`.  Make a note of the consumer key and consumer secret. You're going to need
    them in Step 3.

3.  Run the `poauth.rb` script and provide the comsumer key and secret
    from the Twitter application you created in Step 2.  Go to the URL
    provided by the script and authorise the Twitter user you wish to
    tweet your reports with to use this application.  You will be
    provided with a PIN number.  Paste it into the script where you are
    prompted.  This will create a file called `twitter.yaml` in your
    current directory:

        Set up your application at https://twitter.com/apps/ (as a 'Client' app),
        then enter your 'Consumer key' and 'Consumer secret':

        Consumer key:
        d26cebWimPohUXxXFBMl0Q
        Consumer secret:
        ZI4E5QDt15iplUn3QTJyLATNO6deMwCLeZOHN3WPd0g
        Visit http://api.twitter.com//oauth/authorize?oauth_token=sd4HGcFSpK7vI in your browser to authorize the app,
        then enter the PIN you are given:
        3300514

4.  Copy the `twitter.yaml` file you created in Step 3. into your `/etc/puppet/` directory.

5.  Install puppet-twitter as a module in your Puppet master's module
    path.

6.  Enable pluginsync and reports on your master and clients in `puppet.conf`

        [master]
        report = true
        reports = twitter
        pluginsync = true
        [agent]
        report = true
        pluginsync = true

7.  Run the Puppet client and sync the report as a plugin

Author
------

James Turnbull <james@lovedthanlost.net>

License
-------

    Author:: James Turnbull (<james@lovedthanlost.net>)
    Copyright:: Copyright (c) 2011 James Turnbull
    License:: Apache License, Version 2.0

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
