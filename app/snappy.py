from .AES import *
# except Exception:
#     raise Exception("Error when trying to import pycrypto ( %s ), "
#                     "if you're running on dev_appserver on GAE, "
#                     "you will need to install the tar.gz version of PyCrypto "
#                     "-- the pip version doesn't work with GAE")
from hashlib import sha256
import json, base64, os, random
import urllib.parse, requests
import time, base64
import logging



class Snappy(object):

    # encryption key for blob data
    ENCRYPTION_KEY = 'M02cnQ51Ji97vwT4'

    # request token generator pattern
    PATTERN = '000111011110111000111101010111101'\
              '1010001001110011000110001000110'

    # current authentication token
    auth_token = None

    # initial static auth token used when logging in
    STATIC_TOKEN = 'm198sOkJEn37DjqZ32lpRu76xmw288xSQ9'

    # snapchat api host.
    #API_HOST = 'http://localhost/bq' #'https://feelinsonice.appspot.com'

    MEDIA_IMAGE = 0
    MEDIA_VIDEO = 1
    MEDIA_VIDEO_NOAUDIO = 2
    MEDIA_FRIEND_REQUEST = 3
    MEDIA_FRIEND_REQUEST_IMAGE = 4
    MEDIA_FRIEND_REQUEST_VIDEO = 5
    MEDIA_FRIEND_REQUEST_VIDEO_NOAUDIO = 6

    STATUS_NONE = -1
    STATUS_SENT = 0
    STATUS_DELIVERED = 1
    STATUS_OPENED = 2
    STATUS_SCREENSHOT = 3

    FRIEND_CONFIRMED = 0
    FRIEND_UNCONFIRMED = 1
    FRIEND_BLOCKED = 2

    PRIVACY_EVERYONE = 0
    PRIVACY_FRIENDS = 1


    # Secret (used as a Salt for request tokens)
    SECRET = 'iEk21fuwZApXlz93750dmW22pw389dPwOk'

    URL = 'https://feelinsonice-hrd.appspot.com/bq'#'http://localhost/bq'

    # static headers for each and every request
    _headers = {
        #'Content-Type': 'application/octet-stream',
        'user-agent': 'Snapchat/5.0.1 CFNetwork/609.1.4 Darwin/13.0.0',
        'version': '5.0.1'
    }

    VERSION = '5.0.1'
    # authenticated.
    authenticated = False
    auth_token = "100"
    # AES instance
    _crypto = None

    username = None
    password = None

    # constants
    BLOB = 0x1
    JSON = 0x2

    def __init__(self, username=None, password=None, auth_token=None):
        self.authenticated = False
        self.username = username
        self.password = password
        self.login(username, password)


    def getTime(self, rounded=True):
        if (rounded):
            return int(round(time.time() * 1000))
        return time.time() * 1000

    def testEmpty(self, dictionary,key):
        if key in dictionary:
            if dictionary[key]:
                return dictionary[key]
        return ''


    def isMedia(self, blob):
        if (blob[0] == chr(00) and blob[1] == chr(00)):
            return True

        elif (blob[0] == chr(0xFF) and blob[1] == chr(0xD8)):
            return True

        return False

    def _get_crypto(self):
        '''
        Load up a local instance of the pycrypto cipher library.
        '''

        if self._crypto is None:
            # ECB is required due to a recent change in the Snapchat API
            self._crypto = AES.new(self.ENCRYPTION_KEY, AES.SB_AES_ECB)

        return self._crypto


    def _decrypt(self, data):
        '''
        Decrypt data.
        '''
        crypto = self._get_crypto()
        return crypto.decrypt(self.pkcs5_pad(data))

    def _encrypt(self, data):
        '''
        Encrypt data.
        '''
        crypto = self._get_crypto()
        return crypto.encrypt(self.pkcs5_pad(data))

    def pkcs5_pad(self, data, blocksize=16):
        pad_count = blocksize - len(data)    % blocksize
        return data + (chr(pad_count) * pad_count).encode('utf-8')


    def hash(self, first, second):
        '''
        Given an auth_token and a timestamp, generate a snapchat request token
        '''

        # salt the authtoken and timestamp
        first = self.SECRET + first
        second = str(second) + self.SECRET
        first = first.encode('utf-8')
        second = second.encode('utf-8')
        # hash the newly salted values.
        hash1 = sha256(first).hexdigest()
        hash2 = sha256(second).hexdigest()

        # the snapchat req_token is a blend between the hashed+salted
        # auth_token and the hashed+salted timestamp.
        # Random characters are taken from each (using PATTERN) and blended
        # together to form a "hash-like" string
        out = ''
        for i in range(0, len(self.PATTERN)):
            if self.PATTERN[i] == '0':
                out += hash1[i]
            else:
                out += hash2[i]
        return out


    def sendData(self, endpoint, data, params, files=None):
        #print("SENDING")

        data['req_token'] = self.hash(params[0], params[1])
        data['version'] = self.VERSION
        url = self.URL + endpoint
        if files != None:
            payload = requests.post(url, data=data, files=files, headers=self._headers)
        else:
            payload = requests.post(url, data=data, headers=self._headers)
        #print(payload.content)
        return payload

    def login(self, username, password):
        '''
        Perform a snapchat login.
        '''

        timestamp = self.getTime()
        result = self.sendData('/login',
            {'username': username,
            'password': password,
            'timestamp': timestamp},
            [self.STATIC_TOKEN,
            timestamp])
        result = result.json()
        #print(result)
        if result and result.get('auth_token'):
            # successful login, set the auth token.
            self.authenticated = True
            self.auth_token = result['auth_token']
            self.username = username
            #self.settings[''] 'true'
        else:
            self.authenticated = False



    def logout(self):
        if not self.authenticated:
            return False

        timestamp = self.getTime()
        result = self.sendData('/logout',
            {'timestamp': timestamp,
            'username': self.username},
            [self.auth_token,
            timestamp])

        return result is None

    def getUpdates(self, since=0):
        # if not self.authenticated:
        #     return False

        timestamp = self.getTime()
        result = self.sendData('/updates',
            {'timestamp': timestamp,
            'username': self.username,
            'update_timestamp': since},
            [self.auth_token,
            timestamp])
        result = result.json()
        #print(result)
        if result and result.get('auth_token'):
            # successful login, set the auth token.
            self.authenticated = True
            self.auth_token = result['auth_token']

        return result

    def getSnaps(self, since=0):
        updates = self.getUpdates()

        if not updates:
            return False

        # snaps = []
        # for item in updates['snaps']:
        #     snap = {
        #     'id': item['id'],
        #     'media_id': self.testEmpty(item, 'c_id'),
        #     'media_type': self.testEmpty(item, 'm'),
        #     'time': self.testEmpty(item,'t'),
        #     'sender': self.testEmpty(item, 'sn'),
        #     'recipient': self.testEmpty(item, 'rp'),
        #     'status': item['st'],
        #     'screenshotCount': self.testEmpty(item, 'c'),
        #     'sent': item['sts'],
        #     'opened': item['ts']
        #     }
        #     snaps.append(snap)

        return updates['snaps']


    def upload(self, mediaType, filename):
        # if not self.authenticated:
        #     print("ERE")
        #     return False

        mediaId = self.username.upper() + str(int(time.time()))
        timestamp = self.getTime()
        origfile = open(os.getcwd() + filename, 'rb')
        encrypteddat = self._encrypt(origfile.read())
        origfile.close()
        encrfile = open(os.getcwd() + filename, 'wb')
        encrfile.write(encrypteddat)
        encrfile.close()
        files = {'data': open(os.getcwd() + filename, 'rb')}
        result = self.sendData('/upload',
            {'media_id': mediaId,
            'type': mediaType,
            'timestamp': timestamp,
            'username': self.username},
            [self.auth_token,
            timestamp], files)
        #print(result)
        if result:
            return mediaId
        else:
            return False

    def send(self, mediaId, recipients, time=3):
        # if not self.authenticated:
        #     return False
        timestamp = self.getTime()
        result = self.sendData('/send',
            {'media_id': mediaId,
            'recipient': ','.join(recipients),
            'time': time,
            'timestamp': timestamp,
            'username': self.username},
            [self.auth_token,
            timestamp])
        #print(result.content)

        return result

    def getFriends(self, since=0):
        addedFriends = self.getUpdates()
        if not addedFriends:
            return False

        return addedFriends['friends']

    def addFriends(self, usernames):
        if not self.authenticated:
            return False

        friends = [ {'display': '', 'name': username, 'type': self.FRIEND_UNCONFIRMED}  for username in usernames ]

        timestamp = self.getTime()
        result = self.sendData('/friend',
            {'action': 'multiadddelete',
            'friend': json.dumps({'friendsToAdd': friends, 'friendsToDelete': []}),
            'timestamp': timestamp,
            'username': self.username},
            [self.auth_token,
            timestamp])
        return result.content

    def clearFeed(self):
        if not self.authenticated:
            return False

        timestamp = self.getTime()
        result = self.sendData('/clear',
            {'timestamp': timestamp,
            'username': self.username},
            [self.auth_token,
            timestamp])

        return result.content

    def getBests(self, friends):
        if not self.authenticated:
            return False

        timestamp = self.getTime()
        result = self.sendData('/bests',
            {'friend_usernames': json.dumps(friends),
            'timestamp': timestamp,
            'username': self.username},
            [self.auth_token,
            timestamp])
        result = result.json()
        #print(result)
        friends = []
        #print(result['teamsnapchat']['best_friends'])
        for item in result:
            friend = {}
            friend[item] = result[item]['best_friends']
            friends.append(friend)

        return friends

    def getMedia(self, ident):
        '''
        Given a snap id, return the raw decrypted blob content of a
        jpeg image, or mp4 video.
        '''
        timestamp = self.getTime()
        result = self.sendData('/blob',
            {'id': ident,
            'timestamp': timestamp,
            'username': self.username},
            [self.auth_token,
            timestamp])
        print(result.content)
        if (result.status_code != 200):
            return None
        print(type(result.content))
        if (self.isMedia(str(result.content)) == False):
            print("Encrypted!")
            data = result.content
            #print(data)
        return data

    def markRead(self, ident, viewed=1):
        '''
        Given a snap ID, mark it read and return the status_code
        '''
        timestamp = int(time.time())
        snapInfo = {ident: {'t': timestamp, 'sv': viewed + (random.randint(0, 21474836) / 2147483 / 10)}}
        events = [
            {'eventName': 'SNAP_VIEW',
            'params': {'id': ident},
            'ts': int(time.time()) - viewed
            },
            {'eventName': 'SNAP_EXPIRED',
            'params': {'id': ident},
            'ts': int(time.time())
            }]

        self.sendEvents(events, snapInfo)

    def sendEvents(self, events, snapInfo):
        # if not self.authenticated:
        #     return False

        timestamp = self.getTime()
        result = self.sendData('/update_snaps',
            {'events': json.dumps(events),
            'json': json.dumps(snapInfo),
            'timestamp': timestamp,
            'username': self.username},
            [self.auth_token,
            timestamp])
        return result

    # def _is_blob(self, header):
    #     '''
    #     Determine if the passed-in string is actually a snapchat blob
    #     '''
    #     is_jpeg = header[0] == chr(00) and header[1] == chr(00)
    #     is_mp4 = header[0] == chr(0xFF) and header[1] == chr(0xD8)

    #     if is_jpeg or is_mp4:
    #         return True
    #     else:
    #         # unknown or encrypted blob.
    #         return False

    # def _request(self, url, response_type=None, **params):
    #     '''
    #     Perform a snapchat api request.
    #     '''
    #     if response_type is None:
    #         response_type = self.JSON

    #     auth_token = self.auth_token or self.STATIC_TOKEN
    #     timestamp = round(time.time() * 1000)

    #     request_token = self._generate_request_token(auth_token=auth_token,
    #                                                  timestamp=timestamp)

    #     # attach additional params
    #     params['req_token'] = request_token
    #     params['version'] = self._headers['version']
    #     params['timestamp'] = timestamp

    #     # build the url
    #     url = self.API_HOST + url

    #     # make the request.
    #     try:            # f = open('snapAuth', 'w')
    #         # f.write()

    #         request = urllib2.urlopen(urllib2.Request(url=url,
    #                                               data=urlencode(params),
    #                                               headers=self._headers))
    #     except Exception:
    #         return "ERR", "ERROR"
    #     payload = request.read()

    #     if response_type is self.BLOB:
    #         # decode blob response.
    #         if self._is_blob(payload) is False:
    #             # the blob is encrypted
    #             payload = self._decrypt(payload)
    #     elif response_type is self.JSON:
    #         # json response, decode it.
    #         payload = json.loads(payload)

    #     url = self.API_HOST + self.FRIEND_URI
    #     request = urllib2.urlopen(urllib2.Request(url=url,
    #                                           data=urlencode(params),
    #                                           headers=self._headers))


    #     pay = request.read()
    #     print pay

    #     return request.getcode(), payload

a = Snappy('bbtest', '278lban')
a.getMedia('30674381287168270r')
# # fr = a.addFriends(['ughttt', 'love', 'friend'])
# # fr = a.getFriends()
# # print(fr)
# # f = open(os.getcwd() + '/908967380595753700r.jpeg', 'rb')
# # data = f.read()
# # pic = a.upload(a.MEDIA_IMAGE, '/night.jpg')
# # while(1):
# # a.send(pic, ['ughttt'])
# p = a.getSnaps()
# for i in p:
#     print(i)
#     print()
# # for i in res:
# #     h = a.getMedia(i['id'])
# #     print(h)
# #     if h != None:
# #         # h = base64.b64encode(h)
# #         # h = base64.decodestring(h)
# #         f = open(i['id'] + '.jpeg', 'wb')
# #         f.write(h)
# #         f.close()

