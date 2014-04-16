'use strict';

module.exports = function(grunt) {

    // Project configuration.
    grunt.initConfig({
        // Metadata.
        pkg: grunt.file.readJSON('package.json'),
        banner: '/*! <%= pkg.name %> - v<%= pkg.version %> - ' + '<%= grunt.template.today("yyyy-mm-dd") %>\n' + '<%= pkg.homepage ? "* " + pkg.homepage + "\\n" : "" %>' + '* Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author.name %>;' + ' Licensed <%= _.pluck(pkg.licenses, "type").join(", ") %> */\n',
        // Task configuration.
        src: {
            gruntfile: {
                src: 'Gruntfile.js'
            },
            lib: {
                src: ['lib/**/*.coffee']
            },
            test: {
                src: ['test/**/*.coffee']
            },
        },
        coffeeify: {
            options: {},
            files: {
                src: '<%= src.lib.src %>',
                dest: 'dist/main.js'
            }
        },

        nodeunit: {
            files: '<%= src.test.src %>'
        },
        watch: {
            gruntfile: {
                files: '<%= src.gruntfile.src %>',
                tasks: ['coffeeify', 'nodeunit']
            },
            lib: {
                files: '<%= src.lib.src %>',
                tasks: ['coffeeify', 'nodeunit']
            },
            test: {
                files: '<%= src.test.src %>',
                tasks: ['nodeunit']
            },
        },
    });

    // These plugins provide necessary tasks.
    grunt.loadNpmTasks('grunt-coffeeify');
    grunt.loadNpmTasks('grunt-contrib-nodeunit');
    grunt.loadNpmTasks('grunt-contrib-watch');

    // Default task.
    grunt.registerTask('default', ['coffeeify', 'nodeunit']);

};
