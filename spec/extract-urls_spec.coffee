'use strict'

fs = require('fs')
tweetsPath = "./spec/tweets/urls";
oneURLTweet = JSON.parse(fs.readFileSync("#{tweetsPath}/one-url.json", "utf8"))
twoURLTweet = JSON.parse(fs.readFileSync("#{tweetsPath}/two-urls.json", "utf8"))
threeURLTweet = JSON.parse(fs.readFileSync("#{tweetsPath}/three-urls.json", "utf8"))
extractURLs = require("../index.min").extractURLs

describe "The extractURLs() function", ->

  it "should be defined", ->
    expect(extractURLs).toBeDefined()

  it "should return an empty array when the tweet is null or empty", ->
    tweet = null
    expect(extractURLs(tweet)).toEqual([])
    tweet = {}
    expect(extractURLs(tweet)).toEqual([])

  it "should return an empty array when the tweet has no entities", ->
    tweet = { entities: null }
    expect(extractURLs(tweet)).toEqual([])
    tweet = { entities: {} }
    expect(extractURLs(tweet)).toEqual([])

  it "should return an empty array when the tweet has no URLs", ->
    tweet = { entities: { urls: null } }
    expect(extractURLs(tweet)).toEqual([])
    tweet = { entities: { urls: [] } }
    expect(extractURLs(tweet)).toEqual([])

  it "should return an array of URLs when the tweet has URLs", ->
    tweet = oneURLTweet
    url1 = "https://nodejs.org/en/docs/"
    url2 = "https://docs.npmjs.com/getting-started/installing-node"
    url3 = "http://gruntjs.com/getting-started"
    expect(extractURLs(tweet)).toEqual([url1])
    tweet = twoURLTweet
    expect(extractURLs(tweet)).toEqual([url1, url2])
    tweet = threeURLTweet
    expect(extractURLs(tweet)).toEqual([url1, url2, url3])

  it "should return the expanded form of the URL in preference to the default form", ->
    defaultForm = "defaultForm"
    expandedForm = "expandedForm"
    tweet = { entities: { urls: [ { url: defaultForm, expanded_url: expandedForm } ] } }
    expect(extractURLs(tweet)).toEqual([expandedForm])

  it "should return the default form of the URL if the expanded form is not available", ->
    defaultForm = "defaultForm"
    tweet = { entities: { urls: [ { url: defaultForm } ] } }
    expect(extractURLs(tweet)).toEqual([defaultForm])
