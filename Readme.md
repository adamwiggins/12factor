The Twelve-Factor App
=====================

Source for the content app running at: http://www.12factor.net/

中文翻译：http://liangshan.me/blog/2014/05/22/the-twelve-factor-app/

Development
-----------

    bundle install
    foreman start
    open http://localhost:5000

Production deploy
-----------------

    heroku create -s cedar
    git push heroku master
    heroku open

Meta
----

Created by Adam Wiggins

Contributions from: James Lindenbaum, Mark McGranaghan, Chris Stolt, Ryan
Daigle, Mark Imbriaco, Keith Rarick, Will Leinweber, Jesper Jørgensen, James
Ward, Adam Seligman, Phil Hagelberg, Jon Mountjoy, Matthew Turland, Daniel
Jomphe, Mattt Thompson, Anand Narasimhan, Lucas Fais, Pete Hodgson

Released under the MIT License: http://www.opensource.org/licenses/mit-license.php

