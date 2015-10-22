module.exports = (grunt) ->
  
  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")

    asset_path: 'devAssets/'
    public_path: 'assets/'
    port: 4000

    
    watch:
      sass:
        files: [
          "<%= asset_path %>sass/*"
          "<%= asset_path %>sass/*/*"
        ]
        tasks: ["compass:dev"]
        options:
          atBegin: false

      coffee:
        files: [
          "<%= asset_path %>coffee/*"
        ]
        tasks: ["coffee"]
        options:
          atBegin: false

      js:
        files: [
          "<%= asset_path %>js/*"
        ]
        tasks: ["uglify:js_scripts"]
        options:
          atBegin: false

      plugins:
        files: [
          "<%= asset_path %>plugins/*"
        ]
        tasks: ["uglify:plugins"]
        options:
          atBegin: false

      svg:
        files: [
          "<%= asset_path %>svg/*.svg"
          "<%= asset_path %>svg/*/*.svg"
        ]
        tasks: ["svgmin"]
        options:
          atBegin: false


      watchFiles:
        files: [
          "<%= public_path %>js/*"
          "<%= public_path %>js/mouse/*"
          "site/templates/*"
          "site/snippets/*"
          "site/snippets/*/*"
          "site/plugins/*"
          "site/config/*"
        ]
        options:
          livereload: true


    php:
      dist:
        options:
          hostname: "localhost"
          port: "<%= port %>"
          base: ""
          keepalive: false
          open: false

    browserSync:
      options:
        proxy: "<%= php.dist.options.hostname %>:<%= php.dist.options.port %>"
        watchTask: true
        notify: true
        open: true
        logLevel: "silent"

      files:
        src: [
          "<%= public_path %>css/mouse/*.css"
          "<%= public_path %>gfx/*"
          "<%= public_path %>gfx/*/*"
          "<%= public_path %>images/*"
        ]


    uglify:
      plugins:
        options:
          mangle: true
          beautify: false
          compress: true

        files:
          "<%= public_path %>js/plugins.js": ["<%= asset_path %>plugins/*.js"]

      js_scripts:
        options:
          mangle: false
          beautify: true
          compress: false
          sourceMap: true
        files:
          "<%= public_path %>js/mouse/js_scripts.js": ["<%= asset_path %>js/*.js"]

      
      # combines plugins and scripts
      combine_all:
        options:
          mangle: true
          beautify: false
          compress:
            drop_console: true

        files:
          "<%= public_path %>js/min/scripts.js": [
            "<%= public_path %>js/plugins.js"
            "<%= public_path %>js/mouse/scripts.js"
            "<%= public_path %>js/mouse/js_scripts.js"
          ]

    compass:
      dev:
        options:
          sassDir: "<%= asset_path %>sass"
          cssDir: "<%= public_path %>css/mouse"
          outputStyle: "nested"
          fontsPath: "<%= public_path %>Fonts"
          sourcemap: true

      dist:
        options:
          sassDir: "<%= asset_path %>sass"
          cssDir: "<%= public_path %>css/min"
          outputStyle: "compressed"
          fontsPath: "<%= public_path %>Fonts"
          sourcemap: false

    coffee:
      compileBare:
        options:
          bare: true
          join: false
          sourceMap: true

        files:
          "<%= public_path %>js/mouse/scripts.js": ["<%= asset_path %>coffee/*.coffee"]


    imagemin: # Task
      dynamic: # Another target
        options:
          cache: false
          optimizationLevel: 2

        files: [
          expand: true # Enable dynamic expansion
          cwd: "<%= asset_path %>photos/" # Src matches are relative to this path
          src: ["*.{png,jpg,gif}"] # Actual patterns to match
          dest: "<%= public_path %>photos/" # Destination path prefix
        ]

    image_resize:
      resize:
        options:
          overwrite: true
          upscale: false
          crop: false
          width: 1600
        src: '<%= asset_path %>photos/*.{png,jpg,gif}'
        dest: '<%= public_path %>photos/'

    svgmin:
      options:
        plugins: [
          {
            removeViewBox: false
          }, {
            removeUselessStrokeAndFill: true
          }
        ]
      dist:
        files: [
          expand: true # Enable dynamic expansion
          cwd: "<%= asset_path %>svg/" # Src matches are relative to this path
          src: ["*.svg","*/*.svg"] # Actual patterns to match
          dest: "<%= public_path %>gfx/" # Destination path prefix
        ]

    modernizr:
      dist:
        "parseFiles": false
        "customTests": []
        "uglify": true
        "dest": "<%= asset_path %>plugins/1_modernizr.js"
        "tests": [
          "backgroundblendmode",
          "canvas",
          "hashchange",
          "history",
          "svg",
          "touchevents",
          "video",
          "webgl",
          "css/animations",
          "css/backgroundsize",
          "css/calc",
          "css/flexbox",
          "css/flexboxlegacy",
          "css/gradients",
          "css/pointerevents",
          "css/rgba",
          "css/scrollbars",
          "css/shapes",
          "css/transforms",
          "css/transforms3d",
          "css/transitions",
          "css/vhunit",
          "css/vmaxunit",
          "css/vminunit",
          "css/vwunit",
          "svg/asimg",
          "svg/inline"
        ]
        "options": [
          "mq",
          "setClasses"
        ]
        

  
  # Load grunt plugins.
  grunt.loadNpmTasks "grunt-contrib-compass"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-browser-sync"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-imageMin"
  grunt.loadNpmTasks "grunt-image-resize"
  grunt.loadNpmTasks "grunt-svgmin"
  grunt.loadNpmTasks "grunt-modernizr"
  grunt.loadNpmTasks "grunt-php"

  
  #register tasks
  
  #watch with css inject
  grunt.registerTask "default", [
    # "connect"
    "php"
    "browserSync"
    "watch"
  ]
  
  # compile all files that need compiling
  grunt.registerTask "c", [
    "compass"
    "coffee"
    # "uglify:js_scripts"
    "uglify:plugins"
    "uglify:combine_all"
  ]

  grunt.registerTask "coff", ["coffee"]
  grunt.registerTask "js", ["uglify:js_scripts"]
  grunt.registerTask "sass", ["compass"]
  grunt.registerTask "plug", ["uglify:plugins"]
  grunt.registerTask "min", ["imagemin"]
  grunt.registerTask "mod", ["modernizr","uglify:plugins"]


  # minify SVGs
  grunt.registerTask "svg", ["svgmin"]