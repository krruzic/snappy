import pickle
from Snappy import *
import tart
#start app -> check whether the user has saved credentials. yes -> main screen with tiny spinner and cached data. no -> login sheet
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

    def onUiReady(self):
        print("Call worked!")
        if self.settings['login'] == 'true':
            tart.send('loginChecked', value='true')
        else:
            tart.send('loginChecked', value='false')

    def onLogin(self, username, password):

        if self.settings['login'] == 'true':
            session = Snappy(self.settings['username'], self.settings['password'])
        else:
            self.settings['username'] = username
            self.settings['password'] = password
            self.onSaveSettings(self.settings)
            session = Snappy(username, password)

        self.settings['login'] = session.success

        if session.success == 'true':
            tart.send('loginResult', value='true')
        else:
            self.settings['login'] = session.success
            tart.send('loginResult', value='false')

        self.onSaveSettings(self.settings)

    def onRequestFeed(self):
        snaps = session.getSnaps()
        for snap in snaps:
            tart.send('receiveSnaps', snap=snap)

    def onSaveSettings(self, settings):
        self.settings.update(settings)
        self.save_data(self.settings, self.SETTINGS_FILE)

                # snapStatus: data.snap['status'],
                # snapTime: data.snap['time'],
                # snapType: data.snap['type'],
                # snapUser: data.snap['user'],
                # snapURL: data.snap['url']

