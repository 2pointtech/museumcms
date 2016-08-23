class di.routers.HofRouter extends Backbone.Router
  initialize: ->
  routes:
    '': 'home'
    'videos/:type/:id': 'videos'
  home: ->
    @load
      background: 'background1'
      menu: false
      page: (elements)=>
        nav = new di.views.NavView
          collection:
            'History': '#history'
            'Stadiums': '#stadiums'
            'Coach Snyder': '#page/coach_snyder'
            'Bowl Games': '#games'
            'Championship Teams': '#champs'
            'All-Americans': '#allamericans'
            'Ring of Honor': '#honorees'
            'The Next Level': '#nextlevel'

        $('.page').append nav.render()
        elements.push nav
  videos: (type, id)->
    @load
      background: 'background2'
      header: =>
        header = new di.views.HeaderView
          title1: 'History of K-State Football'
          title2: '2013 Wildcat Football'
        return header
      page: (elements)=>
        videos = di[type].get(id).videos
        videosView = new di.views.VideosView(collection: videos)
        $('.page').append videosView.render()
        elements.push videosView

  stadiums: ->
    @load
      background: 'background4'
      header: =>
        header = new di.views.HeaderView
          title1: 'Stadiums'
          title2: '2013 Wildcat Football'
        return header
      page: (elements)=>
        slider = new di.views.SliderView
          collection: di.stadiums
          view: di.views.StadiumView
        $('.page').append slider.render()
        elements.push slider
  champs: ->
    @load
      background: 'background3'
      header: =>
        header = new di.views.HeaderView
          title1: 'Championship Teams'
          title2: '2013 Big 12 Champions'
        return header
      page: (elements)=>
        slider = new di.views.SliderView
          collection: di.champs
          view: di.views.ChampView
        $('.page').append slider.render()
        elements.push slider
  honorees: ->
    @load
      background: 'background3'
      header: =>
        header = new di.views.HeaderView
          title1: 'Ring of Honor'
          title2: 'Ben Kittrell'
        return header
      page: (elements)=>
        slider = new di.views.SliderView
          collection: di.honorees
          view: di.views.HonoreeView
        $('.page').append slider.render()
        elements.push slider
  games: ->
    @load
      background: 'background2'
      header: =>
        header = new di.views.HeaderView
          title1: 'Bowl Games'
          title2: '2013 Tostitos Fiesta Bowl'
        return header
      page: (elements)=>
        slider = new di.views.SliderView
          collection: di.games
          view: di.views.GameView
        $('.page').append slider.render()
        elements.push slider
  game: (id)->
    game = di.games.find((game)-> game.id == parseInt(id))
    @load
      background: 'background2'
      header: =>
        header = new di.views.HeaderView
          title1: 'Bowl Games'
          title2: '2013 Tostitos Fiesta Bowl'
        return header
      page: (elements)=>
        gameView = new di.views.GameDetailView
          model: game
        $('.page').append gameView.render()
        elements.push gameView
  pros: ->
    @load
      background: 'background2'
      header: =>
        header = new di.views.HeaderView
          title1: 'The Next Level'
          title2: 'Pros'
        return header
      page: (elements)=>
        slider = new di.views.SliderView
          collection: di.pros
          view: di.views.ProView
        $('.page').append slider.render()
        elements.push slider
  formerpros: ->
    @load
      background: 'background2'
      header: =>
        header = new di.views.HeaderView
          title1: 'The Next Level'
          title2: 'Former Pros'
        return header
      page: (elements)=>
        slider = new di.views.SliderView
          collection: di.former_pros
          view: di.views.FormerProView
        $('.page').append slider.render()
        elements.push slider
  allamericans: ->
    @load
      background: 'background2'
      header: =>
        header = new di.views.HeaderView
          title1: 'All-Americans'
          title2: 'Defensive Backs'
        return header
      page: (elements)=>
        slider = new di.views.SliderView
          collection: di.all_american_categories
          view: di.views.AllAmericanView
        $('.page').append slider.render()
        elements.push slider
  nextlevel: ->
    page = di.pages.find((page)-> page.get('handle') == 'nextlevel')
    @load
      background: 'background2'
      header: =>
        header = new di.views.HeaderView
          title1: page.get('title')
          title2: page.get('sub_title')
          title3: page.get('title2')
        return header
      page: (elements)=>
        pageView = new di.views.NextLevelView
          model: page
        $('.page').append pageView.render()
        elements.push pageView
  page: (handle)->
    page = di.pages.find((page)-> page.get('handle') == handle)
    @load
      background: 'background4'
      header: =>
        header = new di.views.HeaderView
          title1: page.get('title')
          title2: page.get('sub_title')
          title3: page.get('title2')
        return header
      page: (elements)=>
        pageView = new di.views.PageView
          model: page
          addClass: handle
        $('.page').append pageView.render()
        elements.push pageView

  load: (options)->
    if @elements
      for el in @elements
        el.hide()
    @elements = []
    if options.background
      @renderBackground options.background
    if !@currentHeader and options.header
      @currentHeader = options.header()
      $('.page').append @currentHeader.render()
      @currentHeader.show()
    else if @currentHeader and !options.header
      @currentHeader.hide()
      @currentHeader = null
    else if @currentHeader and options.header
      newHeader = options.header()
      if !newHeader.equals(@currentHeader)
        @currentHeader.hide()
        @currentHeader = newHeader
        $('.page').append @currentHeader.render()
        @currentHeader.show()
      
    if options.page
      options.page(@elements)
      for el in @elements
        el.show()
    if options.menu == false and @menu
      @menu.hide()
      @menu = null
    else
      @menu = new di.views.MenuView()
      $('.page').append @menu.render()
      @menu.show()
    unless @breadcrumb
      @breadcrumb = new di.views.BreadcrumbView()
      $('.page').append @breadcrumb.render()
      @breadcrumb.show()

  renderBackground: (cls)->
    if @background and !@background.$el.hasClass(cls)
      @background.hide()

    if !@background or !@background.$el.hasClass(cls)
      console.log "Rendering Background: #{cls}"
      @background = new di.views.BackgroundView(type: cls)
      $(document.body).prepend @background.render()
      @background.show()
