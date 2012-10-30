express = require 'express'
stylus = require 'stylus'
assets = require 'connect-assets'

app = express()
# Add Connect Assets
app.use assets()
# Set the public folder as static assets
app.use express.static(process.cwd() + '/public')
# Set View Engine
app.set 'view engine', 'jade'
#simple logger
app.use express.logger()
#enable real ip and other stuff via nginx
app.enable 'trust proxy'

#session support
app.use express.cookieParser("fZFlzqGvCW0JnbxUO825hPGBaQaD7eYe2nVIosTjHUpTWqV6cg8HNo63pr8nyZnU")
app.use express.session()

#parse request bodies (req.body)
app.use express.bodyParser()

# Mount wiki app
require('./wiki')(app)


#Fallback
app.use (err, req, res, next) ->
  #treat as 404
  if ~err.message.indexOf('not found') then return next()
  
  #log it
  console.error(err.stack);

  #error page
  res.status(500).render('5xx');

#assume 404 since no middleware responded
app.use (req, res, next) ->
  res.status(404).render('404', { url: req.originalUrl });

# Define Port
port = process.env.PORT or process.env.VMC_APP_PORT or 3000
# Start Server
app.listen port, -> console.log "Listening on #{port}\nPress CTRL-C to stop server."