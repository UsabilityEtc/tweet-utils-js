'use strict'

fs = require('fs')
tweetsPath = "./spec/tweets/user-mentions";
oneUserMentionsTweet = JSON.parse(fs.readFileSync("#{tweetsPath}/one-user-mention.json", "utf8"))
twoUserMentionsTweet = JSON.parse(fs.readFileSync("#{tweetsPath}/two-user-mentions.json", "utf8"))
threeUserMentionsTweet = JSON.parse(fs.readFileSync("#{tweetsPath}/three-user-mentions.json", "utf8"))
extractUserMentions = require("../index.min").extractUserMentions

describe "The extractUserMentions() function", ->

  it "should be defined", ->
    expect(extractUserMentions).toBeDefined()

  it "should return an empty array when the tweet is null or empty", ->
    tweet = null
    expect(extractUserMentions(tweet)).toEqual([])
    tweet = {}
    expect(extractUserMentions(tweet)).toEqual([])

  it "should return an empty array when the tweet has no entities", ->
    tweet = { entities: null }
    expect(extractUserMentions(tweet)).toEqual([])
    tweet = { entities: {} }
    expect(extractUserMentions(tweet)).toEqual([])

  it "should return an empty array when the tweet has no user mentions", ->
    tweet = { entities: { user_mentions: null } }
    expect(extractUserMentions(tweet)).toEqual([])
    tweet = { entities: { user_mentions: [] } }
    expect(extractUserMentions(tweet)).toEqual([])

  it "should return an array of screen names when the tweet has user mentions", ->
    tweet = oneUserMentionsTweet
    expect(extractUserMentions(tweet)).toEqual(["user1"])
    tweet = twoUserMentionsTweet
    expect(extractUserMentions(tweet)).toEqual(["user1", "user2"])
    tweet = threeUserMentionsTweet
    expect(extractUserMentions(tweet)).toEqual(["user1", "user2", "user3"])
