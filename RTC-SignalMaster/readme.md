### SignalMaster
 Essentially a signal listener that will connect two devices via peer-to-peer connection. Will be set up on a central server and exclusively make/remove P2P connections.
 Start with "npm start".

### WebRTC
 The environment that our video chatrooms will exist in. The user will connect to this service, which will make a call to SignalMaster, finally opening a connection on the central server pointing to your device. Anyone else can then ping SignalMaster to create for them a direct line to your device. A peer-to-peer video stream will be established.
 Start with "npm run test-page"
