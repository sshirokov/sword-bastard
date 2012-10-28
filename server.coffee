Bastard = require './lib/bastard'

bastard = new Bastard()

bastard.start
    port: process.env.PORT or 5000
