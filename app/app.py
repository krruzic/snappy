import pickle
from .snappy import Snappy
from operator import itemgetter
import tart
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
        self.settings = {
            'username': '',
            'password': '',
            'login': 'false'
        }
        self.restore_data(self.settings, self.SETTINGS_FILE)
        print("restored: ", self.settings)

    def onCheckLogin(self):
        print("Checking login")
        tart.send('loginChecked', login=self.settings['login'])

    def testEmpty(self, dictionary,key):
        if key in dictionary:
            if dictionary[key]:
                return dictionary[ey]
        return ''

    def onUiReady(self):
        self.onCheckLogin()

    def onLogin(self, username=None, password=None):

        self.settings['username'] = username
        self.settings['password'] = password
        self.session = Snappy(username, password)

        self.settings['login'] = self.session.authenticated

        tart.send('loginResult', value=self.settings['login'])
        self.onSaveSettings(self.settings)

    def onRequestFeed(self):
        if self.session == None:
            print("Not logged in...")
            self.session = Snappy(self.settings['username'], self.settings['password'])

        snaps = self.session.getSnaps()
        if (snaps != False):
            self.onParseFeed(snaps)
        else:
            print("No new snaps")

    def onParseFeed(self, snaps):
        print("Parsing snaps...")
        for snap in snaps:
            snap['media'] = ''
            snap['time'] = self.prettyDate(snap['sent'] // 1000)
            if snap['media_type'] == 0:
                snap['media'] = 'image'
            elif snap['media_type'] in [1, 2]:
                snap['media'] = 'video'
            if snap['recipient'] == '': # Snap recieved
                snap['type'] = '1' # recieved == 1
            else:
                snap['type'] = '2' # sent == 2
            if snap['media_type'] != '':
                if int(snap['media_type']) >= 3: # Notifications
                    snap['type'] = '3' # notif == 3
            print("MEDIA " + snap['media'])

        for result in sorted(snaps, key=itemgetter('type')):
            tart.send('snapsReceived', snap=result)

    def onSaveSettings(self, settings):
        self.settings.update(settings)
        self.save_data(self.settings, self.SETTINGS_FILE)

                # snapStatus: data.snap['status'],
                # snapTime: data.snap['time'],
                # snapType: data.snap['media'],
                # snapUser: data.snap['user'],
                # snapURL: data.snap['url']

