'use strict'

isRetweet = require("../index.min").isRetweet

describe "The isRetweet() function", ->

  it "should be defined", ->
    expect(isRetweet).toBeDefined()

  it "should return false when the tweet is null", ->
    tweet = null
    expect(isRetweet(tweet)).toEqual(false)

  it "should return false when the tweet was not retweeted with the retweet button", ->
    tweet = {} # sufficient to test for the absense of the retweeted_status key
    expect(isRetweet(tweet)).toEqual(false)

  it "should return false when the tweet was not retweeted with the RT prefix", ->
    tweet = { text: "This is not a retweet." }
    expect(isRetweet(tweet)).toEqual(false)

  it "should return true when the tweet was retweeted with the retweet button", ->
    tweet = { retweeted_status: {} } # sufficient to test for a non-null value of the retweeted_status key
    expect(isRetweet(tweet)).toEqual(true)

  it "should return true when the tweet was retweeted with the RT prefix", ->
    tweet = { text: "RT This is a retweet" }
    expect(isRetweet(tweet)).toEqual(true)
    tweet = { text: "RT: This is a retweet" }
    expect(isRetweet(tweet)).toEqual(true)

  it "should return false when the tweet does not start with the RT prefix", ->
    tweet = { text: "This is not a RT retweet" }
    expect(isRetweet(tweet)).toEqual(false)
    tweet = { text: "This is not a RT: retweet" }
    expect(isRetweet(tweet)).toEqual(false)
