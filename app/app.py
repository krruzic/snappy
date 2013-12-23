import pickle, os
from .snappy import Snappy
from operator import itemgetter
import tart
from tart import screenshot_handler
#start app -> check whether the user has saved credentials. yes -> main screen with tiny spinner and cached data. no -> login page
class App(tart.Application):
    SETTINGS_FILE = 'data/settings.state'
    session = None

    def prettyDate(self, time):
        """
        Get a datetime object or a int() Epoch timestamp and return a
        pretty string like 'an hour ago', 'Yesterday', '3 months ago',
        'just now', etc
        """

        from datetime import datetime
        now = datetime.now()
        if type(time) is int:
            diff = now - datetime.fromtimestamp(time)
        elif isinstance(time,datetime):
            diff = now - time
        elif not time:
            diff = now - now
        second_diff = diff.seconds
        day_diff = diff.days

        if day_diff < 0:
            return "Just now "

        if day_diff == 0:
            if second_diff < 10:
                return "Just now "
            if second_diff < 60:
                return str(second_diff) + " seconds ago "
            if second_diff < 120:
                return  "1 minute ago "
            if second_diff < 3600:
                return str( second_diff // 60 ) + " minutes ago "
            if second_diff < 7200:
                return "1 hour ago "
            if second_diff < 86400:
                return str( second_diff // 3600 ) + " hours ago "
        if day_diff == 1:
            return "Yesterday "
        if day_diff < 7:
            return str(day_diff) + " days ago "
        if day_diff < 31:
            return str(day_diff // 7) + " weeks ago "
        if day_diff < 365:
            return str(day_diff // 30) + " months ago "
        if str(day_diff // 365) == '1':
            return str(day_diff // 365) + " year ago "
        return str(day_diff // 365) + " years ago "

    def __init__(self):
        super().__init__(debug=False)   # set True for some extra debug output
        if not os.path.exists('data'):
            os.makedirs('data')
        self.settings = {
            'username': '',
            'password': '',
            'login': 'false',
            'authToken': ''
        }
        self.restore_data(self.settings, self.SETTINGS_FILE)
        print("restored: ", self.settings)
        if (self.settings["login"]):
            self.onRequestFeed()

    def onAuth(self, username=None, password=None):
        if username == None:
            username = self.settings['username']
            password = self.settings['password']
        self.session = Snappy(username, password)

        if self.settings['login']: # if login success
            self.settings['authToken'] = self.session.authToken

        tart.send('loginResult', value=self.settings['login'])
        self.onSaveSettings(self.settings)



    def onCheckLogin(self):
        print("Checking login")
        tart.send('loginChecked', login=self.settings['login'])

    def onUiReady(self):
        screenshot_handler.ScreenshotHandler(self.bps_dispatcher)
        self.onCheckLogin()

    def onLogin(self, username=None, password=None):
        # when we pass an auth token we just set up a Snappy instance (no request made)
        self.session = Snappy(self.settings['username'], self.settings['password'], self.settings['authToken'])
        self.onRequestFeed() # now we request the feed


    def onRequestFeed(self):
        snaps = self.session.getSnaps()
        if (snaps != False):
            self.onParseFeed(snaps)
        else:
            print("Token expired")
            self.onAuth()

    def onParseFeed(self, snaps):
        print("Parsing snaps...")
        for snap in snaps:

            if 'media' not in snap:
                snap['media'] = ''
            if snap['countdown'] != '':
                snap['countdown'] = int(snap['countdown'])
            snap['time'] = self.prettyDate(snap['sent'] // 1000)
            if snap['media_type'] == 0:
                snap['media'] = 'picture'
            elif snap['media_type'] in [1, 2]:
                snap['media'] = 'video'
            if snap['recipient'] == '': # Snap recieved
                snap['type'] = 'Recieved' # recieved == 1
            else:
                snap['user'] = snap['recipient']
                # print(snap['opened'])
                if snap['opened'] == 1:
                    snap['type'] = 'Opened' # sent == 2
                    snap['media'] = 'sent'
                else:
                    snap['type'] = 'Sent' # sent == 2
                    snap['media'] = 'sent'
            if snap['media_type'] != '':
                if int(snap['media_type']) >= 3: # Notifications
                    snap['type'] = 'Notification' # notif == 3

        for result in sorted(snaps, key=itemgetter('type')):
            tart.send('snapsReceived', snap=result)

    def onRequestImage(self, source):
        data = self.session.getMedia(source)
        imageURI = os.getcwd() + '/data/' + source + '.jpeg'
        if data != None:
            f = open('data/' + source + '.jpeg', 'wb')
            f.write(data)
            print("image written")
            f.close()
            tart.send('snapData', imageSource=imageURI)

    def onShrinkImage(self, image, res):
        print(res)
        THUMBNAIL_CMD = '/usr/bin/img_thumbnail {src} {dest} {x} {y}'
        cmd = THUMBNAIL_CMD.format(src=image, dest=image, x=res[0], y=res[1])
        os.system(cmd)

    def onSendImage(self, image, users, time=3):

        mediaID = self.session.upload(0, image)
        if mediaID != False:
            res = self.session.send(mediaID, users, time)
        else:
            return
        print(res)

    def onGetFriends(self):
        friends = self.session.getFriends()
        for friend in friends:
            tart.send('friends', name=friend['name'])

    def onSaveSettings(self, settings):
        self.settings.update(settings)
        self.save_data(self.settings, self.SETTINGS_FILE)

                # snapStatus: data.snap['status'],
                # snapTime: data.snap['time'],
                # snapType: data.snap['media'],
                # snapUser: data.snap['user'],
                # snapURL: data.snap['url']

