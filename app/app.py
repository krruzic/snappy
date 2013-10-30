import pickle
from .snappy import Snappy
import tart
#start app -> check whether the user has saved credentials. yes -> main screen with tiny spinner and cached data. no -> login page
class App(tart.Application):
    #session = WhiteGhost('bbtest', '278lban')
    SETTINGS_FILE = 'data/settings.state'


    def __init__(self):
        super().__init__(debug=False)   # set True for some extra debug output
        self.settings = {
            'username': '',
            'password': '',
            'login': 'false'
        }
        self.restore_data(self.settings, self.SETTINGS_FILE)
        print("restored: ", self.settings)



    def testEmpty(self, dictionary,key):
        if key in dictionary:
            if dictionary[key]:
                return dictionary[key]
        return ''

    def onUiReady(self):
        pass

    def onLogin(self, username=None, password=None):

        if self.settings['login'] == 'true':
            session = Snappy(self.settings['username'], self.settings['password'])
        else:
            self.settings['username'] = username
            self.settings['password'] = password
            self.onSaveSettings(self.settings)
            session = Snappy(username, password)

        self.settings['login'] = session.authenticated

        if session.authenticated == True:
            self.settings['login'] = 'true'
            tart.send('loginResult', value='true')
        else:
            self.settings['login'] = 'false'
            tart.send('loginResult', value='false')

        self.onSaveSettings(self.settings)

    def onRequestFeed(self):
        updates = session.getSnaps()
        if (updates != null):
            self.onParseFeed(updates)

    def onParseFeed(self, updates):
        snaps = []
        for item in updates['snaps']:
            snap = {
            'url': item['id'],
            'media_id': self.testEmpty(item, 'c_id'),
            'media_type': self.testEmpty(item, 'm'), # >3 Friend Request
            'time': self.testEmpty(item,'t'),
            'sender': self.testEmpty(item, 'sn'),
            'recipient': self.testEmpty(item, 'rp'),
            'status': item['st'], # Sent, Delivered, Opened, Screenshotted
            'sent': item['sts'],
            'opened': item['ts']
            }
            if snap['media_type'] == 0:
                snap['media'] = 'image'
            elif snap['media_type'] in [1, 2]:
                snap['media'] = 'video'
            if snap['recipient'] == '': # Snap recieved
                snap['type'] = '1' # recieved == 1
            else:
                snap['type'] = '2' # sent == 2

            if snap['media_type'] >= 3: # Notifications
                snap['type'] = '3' # notif == 3

            snaps.append(snap)
        for result in sorted(snaps, key=itemgetter('type')):
            tart.send('snapsRecieved', snap=result)

    def onSaveSettings(self, settings):
        self.settings.update(settings)
        self.save_data(self.settings, self.SETTINGS_FILE)

                # snapStatus: data.snap['status'],
                # snapTime: data.snap['time'],
                # snapType: data.snap['type'],
                # snapUser: data.snap['user'],
                # snapURL: data.snap['url']

