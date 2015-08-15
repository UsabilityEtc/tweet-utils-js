'use strict'

extractGeocoding = require("../index").extractGeocoding

describe "The extractGeocoding() function", ->

  it "should be defined", ->
    expect(extractGeocoding).toBeDefined()

  it "should return null when the tweet is null or empty", ->
    tweet = null
    expect(extractGeocoding(tweet)).toBeNull()
    tweet = {}
    expect(extractGeocoding(tweet)).toBeNull()

  it "should return the coordinates in the coordinates key", ->
    tweet = { coordinates: { coordinates: [1, 2] } }
    expect(extractGeocoding(tweet)).toEqual({ longitude: 1 , latitude: 2 })

  it "should return the coordinates in the deprecated geo key if there is no coordinates key", ->
    tweet = { geo: { coordinates: [3, 4] } } # the coordinates in the geo key are [lat,long]
    expect(extractGeocoding(tweet)).toEqual({ longitude: 4, latitude: 3 })

  it "should return the coordinates in the coordinates key in preference to the coordinates in the deprecated geo key", ->
    tweet = { coordinates: { coordinates: [1, 2] }, geo: { coordinates: [3, 4] } }
    expect(extractGeocoding(tweet)).toEqual({ longitude: 1, latitude: 2 })
