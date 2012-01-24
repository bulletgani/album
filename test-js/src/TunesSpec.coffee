albumData = [{
"title":  "Album A",
"artist": "Artist A",
"tracks": [
  {
  "title": "Track A",
  "url": "/music/Album A Track A.mp3"
  },
  {
  "title": "Track B",
  "url": "/music/Album A Track B.mp3"
  }]
}, {
"title": "Album B",
"artist": "Artist B",
"tracks": [
  {
  "title": "Track A",
  "url": "/music/Album B Track A.mp3"
  },
  {
  "title": "Track B",
  "url": "/music/Album B Track B.mp3"
  }]
}]

describe 'Album', () ->
  beforeEach ()->
    @album = new Album(albumData[0])


  it 'creates from data', () ->
    expect(@album.get('tracks').length).toEqual(2)


  describe 'first track', () ->
    it 'identifies correct first track', () ->
      expect(@album.isFirstTrack(0)).toBeTruthy()

  describe 'last track', () ->
    it 'identifies correct last track', () ->
      expect(@album.isLastTrack(1)).toBeTruthy()

  it 'returns the URL for a track', () ->
    expect(@album.trackURLAtIndex(0)).toEqual('/music/Album A Track A.mp3')