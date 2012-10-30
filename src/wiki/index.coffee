express = require 'express'
path = require 'path'

module.exports = (parent) ->
  wiki = express()
  wiki.set 'views', path.join __dirname, "views"

  #mount this app
  parent.use wiki
