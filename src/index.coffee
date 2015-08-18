'use strict'

extractGeocoding = (tweet) ->
  coordinatesObject = null
  if tweet
    latitude = longitude = null
    if tweet.coordinates and tweet.coordinates.coordinates
      coordinatesArray = tweet.coordinates.coordinates
      longitude = coordinatesArray[0]
      latitude = coordinatesArray[1]
    else if tweet.geo and tweet.geo.coordinates
      # The geo key
      # - is deprecated by Twitter so the coordinates key (above) is preferred
      # - records the coordinates in the order [latitude, longitude]
      coordinatesArray = tweet.geo.coordinates
      longitude = coordinatesArray[1]
      latitude = coordinatesArray[0]
    if latitude and longitude
      coordinatesObject =
        longitude: longitude,
        latitude: latitude
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
