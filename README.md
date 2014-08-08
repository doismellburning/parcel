# Parcel

## What is Parcel?

Parcel is a tool for turning code into packages.

### Sort of like [fpm](https://github.com/jordansissel/fpm)?

Sort of, in that it's built around fpm.

Sort of not, in that it adds a config layer on the top so you / your organisation can easily build and deploy packages in minutes

### How?

You `cd` to a project, run `parcel`.
It reads your organization config (default: `/etc/parcel/organization.yaml`) and your local package config (default: `./package.yaml`) and builds you packages in `./parcel`)

What sort of things does this let you do, and why is it better than vanilla fpm?

* Simple, organisation-wide configuration of email address, license, et cetera
* Easy per-project overrides
* Automatic init-script generation from a per-project `Procfile`
* Automatic version number extraction (TODO)

