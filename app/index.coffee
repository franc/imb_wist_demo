require('lib/setup')

Spine   = require('spine')
{Stage, Panel} = require('spine.mobile')
$       = Spine.$

class Home extends Panel
  title: "IMB Mobile"
  #elements:
  #  'form': 'form'
  #el: '#homeScroller'
  events:
    'submit #form': 'disableSubmit'
    'tap #splash': 'triggerNotification'
    'tap #accept_button': 'confirm'
    'tap #cancel_button': 'cancel'
  className: 'home'

  constructor: ->
    super
    @routes
      '/': -> 
        @render().active()
        @
      '/pop': ->
        @transactionNotification().active()
    @
  render: ->
    console.log "render"
    @html require('views/home/splash')()
    @
  transactionNotification: ->
    console.log('transactionNotification')
    @html require('views/home/transact')()
    @
  cancel: -> @navigate('/')
  triggerNotification: =>
    console.log('triggerNotification')
    setTimeout( (=> @navigate('/pop')), 5000)
  disableSubmit: (e) ->
    console.log('disableSubmit')
    try e.preventDefault() catch err then console.log(err)
    @
  confirm: (e) =>
    setTimeout @disableSubmit(e), 0
    console.log('confirm')
    @render()
    setTimeout( (=> @html(require('views/home/confirmation')())), 2000)
    setTimeout( (=> @navigate('/')), 5000)
    @


class App extends Stage.Global
  constructor: ->
    super
    @count = 0
    @start()
  start: ->
    console.log 'attempting start'
    @count++
    if @count is 2
      @home = new Home
      Spine.Route.setup(shim:true)
      console.log 'about to navigate'
      @navigate '/'

module.exports = App

