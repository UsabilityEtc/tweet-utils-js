'use strict'

extractGeocoding = (tweet) ->
  coordinatesObject = null
  if tweet
    latitude = longitude = null
    if tweet.coordinates and tweet.coordinates.coordinates
      coordinatesArray = tweet.coordinates.coordinates
      latitude = coordinatesArray[1]
      longitude = coordinatesArray[0]
    else if tweet.geo and tweet.geo.coordinates
      coordinatesArray = tweet.geo.coordinates
      latitude = coordinatesArray[0]
      longitude = coordinatesArray[1]
    if latitude and longitude
      coordinatesObject =
        latitude: latitude,
        longitude: longitude
  coordinatesObject

extractUserMentions = (tweet) ->
  userMentionsArray = [];
  if tweet and tweet.entities and tweet.entities.user_mentions
      userMentions = tweet.entities.user_mentions
      userMentionsArray.push(userMention.screen_name) for userMention in userMentions
  userMentionsArray

extractHashtags = (tweet) ->
  hashtagsArray = [];
  if tweet and tweet.entities and tweet.entities.hashtags
    hashtags = tweet.entities.hashtags
    hashtagsArray.push(hashtag.text) for hashtag in hashtags
  hashtagsArray

module.exports =
  extractGeocoding: extractGeocoding
  extractUserMentions: extractUserMentions
  extractHashtags: extractHashtags
