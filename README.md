# Procodile 🐊

> **This is DeployHQ's maintained fork of [adamcooke/procodile](https://github.com/adamcooke/procodile).**
>
> Upstream has had no release since 1.0.26 (November 2019) and no commit since February 2021. Its `master` carries a version bump to 1.0.27 and a bug fix that were never published to RubyGems, and open pull requests have gone unanswered for years.
>
> We depend on Procodile to run DeployHQ in production, so we maintain it. All credit for the original work goes to Adam Cooke; this fork stays MIT licensed.
>
> **The gem is published as [`dhq-procodile`](https://rubygems.org/gems/dhq-procodile)**, because we do not own the `procodile` name on RubyGems. It still installs an executable called `procodile`, so no Procfile, script, or Capistrano config needs to change:
>
> ```
> gem install dhq-procodile
> procodile --version
> ```
>
> Upstream pull requests are left open as a courtesy, but this fork is where changes land.

Running & deploying Ruby apps to places like [Viaduct](https://viaduct.io) & Heroku is really easy but running processes on actual servers is less fun. Procodile aims to take some the stress out of running your Ruby/Rails apps and give you some of the useful process management features you get from the takes of the PaaS providers.

Procodile is a bit like [Foreman](https://github.com/ddollar/foreman) but things are designed to run in the background (as well as the foreground if you prefer) and there's a supervisor which keeps an eye on your processes and will respawn them if they die.

Procodile works out of the box with your existing `Procfile`.

* [Watch a quick screencast](https://vimeo.com/188041935)
* [Read documentation](https://github.com/adamcooke/procodile/wiki)
* [View on RubyGems](https://rubygems.org/gems/dhq-procodile)
* [Check the CHANGELOG](https://github.com/adamcooke/procodile/blob/master/CHANGELOG.md) (upstream)

![Screenshot](https://share.adam.ac/16/cAZRKUM7.png)
