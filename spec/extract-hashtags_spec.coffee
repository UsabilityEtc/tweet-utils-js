'use strict'

fs = require('fs')
tweetsPath = "./spec/tweets/hashtags";
oneHashtagTweet = JSON.parse(fs.readFileSync("#{tweetsPath}/one-hashtag.json", "utf8"))
twoHashtagTweet = JSON.parse(fs.readFileSync("#{tweetsPath}/two-hashtags.json", "utf8"))
threeHashtagTweet = JSON.parse(fs.readFileSync("#{tweetsPath}/three-hashtags.json", "utf8"))
extractHashtags = require("../index.min").extractHashtags

describe "The extractHashtags() function", ->

  it "should be defined", ->
    expect(extractHashtags).toBeDefined()

  it "should return an empty array when the tweet is null or empty", ->
    tweet = null
    expect(extractHashtags(tweet)).toEqual([])
    tweet = {}
    expect(extractHashtags(tweet)).toEqual([])

  it "should return an empty array when the tweet has no entities", ->
    tweet = { entities: null }
    expect(extractHashtags(tweet)).toEqual([])
    tweet = { entities: {} }
    expect(extractHashtags(tweet)).toEqual([])

  it "should return an empty array when the tweet has no hashtags", ->
    tweet = { entities: { hashtags: null } }
    expect(extractHashtags(tweet)).toEqual([])
    tweet = { entities: { hashtags: [] } }
    expect(extractHashtags(tweet)).toEqual([])

  it "should return an array of hashtags when the tweet has hashtags", ->
    tweet = oneHashtagTweet
    expect(extractHashtags(tweet)).toEqual(["hashtag1"])
    tweet = twoHashtagTweet
    expect(extractHashtags(tweet)).toEqual(["hashtag1", "hashtag2"])
    tweet = threeHashtagTweet
    expect(extractHashtags(tweet)).toEqual(["hashtag1", "hashtag2", "hashtag3"])
