Repo | One code repo, many deploys
==================================

A twelve-factor app is always tracked in a version control system, with the tracked code history known as a *code reposistory*, often shortened to *code repo* or just *repo*.

There is always a one-to-one correlation between the repo and the app.  If there are multiple code repos, it's not an app - it's a distributed system.  Multiple apps sharing the same code is a violation of twelve-factor and generally poor practice.  In the latter case, the better approach is to factor shared code libraries which can be included through the [dependency manager](#).

There is only one repo per app, but there will be many deploys of the app.  A *deploy* is a running instance of the app.  This is typically one production site, and one or more staging sites.  Every developer working on the app has their own local version which also qualifies as a deploy, though one visible only to that developer and only useful for editing the app's code.

The repo is the same across all deploys, although different versions may be active in each deploy.  For example, a developer has some commits not yet deployed to staging; staging has some commits not yet deployed to production.  But they all share the same revision history tree.

